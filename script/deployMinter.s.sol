// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import 'forge-std/Script.sol';
import 'forge-std/console.sol';
import '../src/ImpactQuests.sol';

contract deployImpactQuest is Script {

    function run() external {
        uint256 deployerPrivateKey = vm.envUint('PRIVATE_KEY');
        vm.startBroadcast(deployerPrivateKey);
        string memory baseURI = 'ipfs://QmWYhfWfUqBhkRZSFfXYCg7Geuikj7icd8ts6WT1VzHZfc';
        GivethImpactQuest mintingContract = new GivethImpactQuest(baseURI);
        mintingContract.addToken("ipfs://QmXLqKbRWrNqY2GDXLnZzxHoGSYf6qaiwRnzsydXMwZFXB/AstralArt.json");
        mintingContract.addToken("ipfs://QmXLqKbRWrNqY2GDXLnZzxHoGSYf6qaiwRnzsydXMwZFXB/CosmicContribution.json");
        mintingContract.addToken("ipfs://QmXLqKbRWrNqY2GDXLnZzxHoGSYf6qaiwRnzsydXMwZFXB/OperationHaveAHome.json");
        mintingContract.addToken("ipfs://QmXLqKbRWrNqY2GDXLnZzxHoGSYf6qaiwRnzsydXMwZFXB/PizzaPayload.json");
        mintingContract.addToken("ipfs://QmXLqKbRWrNqY2GDXLnZzxHoGSYf6qaiwRnzsydXMwZFXB/SocialMedia.json");
        mintingContract.addToken("ipfs://QmXLqKbRWrNqY2GDXLnZzxHoGSYf6qaiwRnzsydXMwZFXB/SpacewalkerSweep.json");

        string memory URIOne = mintingContract.uri(2);
        console.log(URIOne);
    }
}
