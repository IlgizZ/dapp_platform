pragma solidity ^0.4.11;
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./Investor.sol";
import "./Organizer.sol";
import "./Winners.sol";
import "./Expert.sol";


contract Event is Ownable {

    string public name;
    string public prize;
    Organizer[] public organizers;
    Winners[] public winners;
    Participant[] public participants;
    Expert[] public experts;

    Investor[] private investors;

    event WinnersChoosen(int count);

    modifier onlyInvestors() {
        bool found = false;
        for (uint i = 0; i < investors.length; i++) {
            if (investors[i] == msg.sender){
              found = true;
              break;
            }
        }
        require(found);
        _;
    }

    function Event(string _name, address _prize) public {
        name = _name;
        prize = _prize;
    }

    function () public payable onlyInvestors {

    }

    function chooseWinners() public onlyOwner returns(bool result) {
        winners = experts.chooseWinners();
        WinnersChoosen(winners.length);
    }

    function addOrganizers(Organizer organizer) public onlyOwner {
        organizers.push(organizer);
    }

    function addParticipant(Participant participant) public onlyOwner {
        participants.push(participant);
    }

    function addExpert(Expert expert) public onlyOwner {
        experts.push(expert);
    }
}
