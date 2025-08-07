// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

// import "src/BridgeETH.sol";
// import "src/USDT.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BridgeETHTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 value);

    BridgeETH bridge;
    USDT usdt;

    function setUp() public {
        usdt = new USDT();
        bridge = new BridgeETH(address(usdt));
    }

    function test_Deposit() public {
        usdt.mint(0x17c085c7a50ABBdC56B3482C4385Bbe92539D8E9,200);
        vm.startPrank(0x17c085c7a50ABBdC56B3482C4385Bbe92539D8E9);
        usdt.approve(address(bridge),200);

        bridge.deposit(usdt,200);
        assertEq(usdt.balanceOf(0x17c085c7a50ABBdC56B3482C4385Bbe92539D8E9),0);
        assertEq(usdt.balanceOf(address(bridge)),200);

        bridge.withdraw(usdt,100);

        assertEq(usdt.balanceOf(0x17c085c7a50ABBdC56B3482C4385Bbe92539D8E9),100);
        assertEq(usdt.balanceOf(address(bridge)),100);
        
    }
}