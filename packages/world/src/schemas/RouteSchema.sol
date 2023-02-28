// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { console } from "forge-std/console.sol";
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { SchemaType } from "@latticexyz/store/src/Types.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";

// -- User defined schema and tableId --
struct RouteSchema {
  string value;
}

// -- Autogenerated library to interact with tables with this schema --
// TODO: autogenerate

library RouteSchemaLib {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema schema) {
    schema = SchemaLib.encode(SchemaType.STRING);
  }

  /** Register the table's schema */
  function registerSchema(uint256 tableId) internal {
    StoreSwitch.registerSchema(tableId, getSchema());
  }

  function registerSchema(uint256 tableId, IStore store) internal {
    store.registerSchema(tableId, getSchema());
  }

  /** Set the table's data */
  function set(
    uint256 tableId,
    uint256 routeId,
    string memory value
  ) internal {
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = bytes32(routeId);
    StoreSwitch.setField(tableId, keyTuple, 0, bytes(value));
  }

  /** Get the table's data */
  function get(uint256 tableId, uint256 routeId) internal view returns (string memory) {
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = bytes32(routeId);
    bytes memory blob = StoreSwitch.getRecord(tableId, keyTuple);
    return string(SliceLib.getSubslice(blob, 32).toBytes());
  }

  function get(
    uint256 tableId,
    IStore store,
    uint256 routeId
  ) internal view returns (string memory) {
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = bytes32(routeId);
    bytes memory blob = store.getRecord(tableId, keyTuple);
    return string(SliceLib.getSubslice(blob, 32).toBytes());
  }

  function has(uint256 tableId, uint256 routeId) internal view returns (bool) {
    bytes32[] memory keyTuple = new bytes32[](1);
    keyTuple[0] = bytes32(routeId);
    bytes memory blob = StoreSwitch.getRecord(tableId, keyTuple);
    return blob.length > 0;
  }
}