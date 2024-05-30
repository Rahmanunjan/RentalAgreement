// Changed compiler to Solidity 0.8.26
// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.26;

contract RentalAgreement {
    // This declares a new complex type which will 
    // hold the paid rents
    struct PaidRent {
        uint id; // The paid rent id
        uint value; // The amount of rent that is paid
        }

        PaidRent[] public paidrents;

        uint public createdTimestamp;

        uint public rent;
        // Combination of eir code and house number
        string public house;

        address public landlord;

        address public tenant;
        enum State {Created, Started, Terminated};
        State public state;

        function RentalAgreement(uint _rent, string _house) {
            rent = _rent;
            house = _house;
            landlord = msg.sender;
            createdTimestamp = block.timestamp;
        } 
        modifier require(bool _condition) {
            if (!_condition) throw;
            _;
        }
        modifier onlyLandlord() {
            if (msg.sender != landlord) throw;
            _;
        }
        modifier onlyTenant() {
            if (msg.sender != tenant) throw;
            _;
        }
        modifier inState(State _state) {
            if (state != _state) throw;
            _;
        }
        // We also have some getters so that we can read the values
        // from the blockchain at any time
        function getPaidRents() internal returns (PaidRent[]) {
            return paidrents;
        }
        
        function getHouse() constant returns (string) {
            return house;
        }

        function getLandlord() constant returns (address) {
            return landlord;
        }

        function getTenant() constant returns (address) {
            return tenant;
        }

        function getRent()  returns () {
            return rent;   
        }

        function getContractCreated() constant returns (uint) {
            return createdTimestamp;
        }

        function getContractAddress() constant returns () {
            return this;
        }

        function getState()  returns (State) {
            return state;
        }

        // Events for Dapps to listen to
        event agreementConfirmed();

        event paidRent();

        event contractTerminated();

        // Confirm the lease agreement as tenant
        function confirmAgreement() inState(State.Started) {
            require(msg.sender != landlord);
            agreementConfirmed();
            tenant = msg.msg.sender;
            state = State.Started;
            };
        }
        // Terminate

            
        }
