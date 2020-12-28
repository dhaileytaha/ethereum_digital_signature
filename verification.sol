pragma solidity ^0.4.0;

contract Bank{
    
    address public creator;
    
    struct bankDetails {
        uint accountNumber;
        string fullName;
        string dob;
    }

    string signature;
    
    mapping (uint => string) public customerSign;
    
    mapping(address => bankDetails) mapBankDetails;
    
    address[] public bankAccountAddr;
    
    function Bank(){
        creator = msg.sender;
    }
    
    function storeDetails(address _myAddress, uint _accountNumber, string _fullName, string _dob) {
      
      var bankDetails = mapBankDetails[_myAddress]; 
      
        bankDetails.accountNumber = _accountNumber;
        bankDetails.fullName = _fullName;
        bankDetails.dob = _dob;
        
        bankAccountAddr.push(_myAddress);
        
    }
    function getCustomerAddr() view public returns (address[]){
        return bankAccountAddr;
    }
    function getDetails(address _address) view public returns(uint, string, string){
        return (mapBankDetails[_address].accountNumber, mapBankDetails[_address].fullName, mapBankDetails[_address].dob);
    }
    //strore signature
    function storeSign(string _signature, uint _bankAccount) 
    {
            customerSign[_bankAccount] = _signature;
    }
    
    // verify sign
    function verify(bytes32 _message, uint8 _v, bytes32 _r, bytes32 _s, address signer) public constant returns (bool) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHash = sha3(prefix, _message);
        return ecrecover(prefixedHash, _v, _r, _s) == signer;
  }
             
}