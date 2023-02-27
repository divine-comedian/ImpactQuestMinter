// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import 'forge-std/Script.sol';
import 'forge-std/console.sol';
import '../contracts/MitchMinter.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';

contract deployMitchMinter is Script {
    using SafeERC20 for IERC20;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint('PRIVATE_KEY');
        vm.startBroadcast(deployerPrivateKey);
        string memory baseURI = 'ipfs://QmRA1cRXMB1Y8Y14DxVshKbWRqWmHR35pUVuP5nynKqfZn';
        address paymentToken = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;
        uint256 price = 0.001 ether;
        MitchMinter mintingContract = new MitchMinter(baseURI, IERC20(paymentToken), price);
        mintingContract.addToken("ipfs://QmUsoyGXmfQDTdwqn3ZcDvtBTqTQzenUGgXuyFzwZcoiyk/1.json");
        mintingContract.addToken("ipfs://QmUsoyGXmfQDTdwqn3ZcDvtBTqTQzenUGgXuyFzwZcoiyk/2.json");
        mintingContract.addToken("ipfs://QmUsoyGXmfQDTdwqn3ZcDvtBTqTQzenUGgXuyFzwZcoiyk/3.json");
        mintingContract.addToken("ipfs://QmUsoyGXmfQDTdwqn3ZcDvtBTqTQzenUGgXuyFzwZcoiyk/4.json");
        console.log("there are this many tokens", mintingContract.getUniqueTokens());
    }
}