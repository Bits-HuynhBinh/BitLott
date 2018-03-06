contract BitLottery {

	enum State {
		New,
        AcceptBuyTicket,
        EndBuyTicket,
        KillContract
    }

	 address public _owner = msg.sender;
	 address public _co_owner1;
	 address public _co_owner2;
	 address public _co_owner3;
	 
	 uint public creationTime = now;
	 
	 mapping (address => uint) pendingWithdrawals;
	 mapping (address => uint) pendingWithdrawals;
		
 
	State public contractState = State.New;
 
    // Modifier
    modifier onlyCLevel(){
       require(msg.sender == 0xca35b7d915458ef540ade6068dfe2f44e8fa733c);
        _;
    }
	
	modifier onlyOwner(){
		require(msg.sender == _owner);
		_;
	}
	
	modifier onlyAfter(uint _time) {
        require(now >= _time);
        _;
    }
	
	modifier onlyAcceptBuyTicket()
	{
	}
	
	modifier onlyEndBuyTicket()
	{
	}
	
	modifier onlyEndBuyTicket()
	{
	}
	
	modifier onlyWhenContractIsNotKill()
	{
		
	}
	// End Modifier
 
 
 
    // campaign index of lottery
    uint CampaignID;
    mapping (uint => Campaign) campaigns;
    
    struct Player{
        address playerAddress;
        uint16 lotteryNumber;
    }
    
    struct Campaign{
        address beneficiary;
        uint amount;
        uint numPlayers;
        uint16 winningLotteryNumber;
        uint ticketPrice;
        bool isClosed;
        mapping (uint => Player) players;
    }
	
	
	function changeOwner(address newOwner) public onlyOwner()
    {
        _owner = newOwner;
    }
	
	function setCoOwner(int who, address coOwner) public onlyOwner()
    {
		if(who == 1)
		{
			_co_owner1 = coOwner;
		}
		else if(who == 2)
		{
			_co_owner2 = coOwner;
		}
		else if(who ==3)
		{
			_co_owner3 = coOwner;
		}
		else
		{
			//throw
		}   
    }
    
    
    function createCampaign(address beneficiary ,uint ticketPrice) public onlyCLevel() returns (uint campaignID) {
    
        campaignID = numCampaigns++; // campaignID is return variable
        campaigns[campaignID] = Campaign(beneficiary,0,0,0,ticketPrice,false);
    }
    
    
   function setWinningLotteryNumber(uint campainID, uint16 winningLotteryNumber) public onlyCLevel(){
       require(campaigns[campainID].winningLotteryNumber == 0);
       campaigns[campainID].winningLotteryNumber = winningLotteryNumber;
       campaigns[campainID].isClosed = true;
   }
    
   function getWinningLotteryNumber(uint campainID) public view returns(uint){
       return campaigns[campainID].winningLotteryNumber;
   } 
   
   function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        // Remember to zero the pending refund before
        // sending to prevent re-entrancy attacks
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
	
	// Order of the modifiers matters here!
    function buyTicket(string lottery_number) public payable timedTransitions onlyAcceptBuyTicket
    {
        
    }
	
	
	function startStateAcceptBuyTicket()
	{
		contractState = State.AcceptBuyTicket;
	}
	
	function startStateEndBuyTicket()
	{
		contractState = State.EndBuyTicket;
	}
	
	function killContract()
	{
		contractState = State.KillContract;
		close();
	}
	
	function close() public onlyOwner {
        selfdestruct(owner);
    }
	
	// fallback function
	// the amount will be added to support developers
	// or return back to player
	function () payable {  
		// add eth to contract balance
	}
	 
}