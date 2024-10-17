actor Token {
  // Token metadata
  let name: Text = "MyToken";
  let symbol: Text = "MTK";
  let decimals: Nat8 = 8;
  var totalSupply: Nat = 1000000;
  
  // Map to track balances
  var balances: TrieMap<Principal, Nat> = TrieMap();
  
  // Transfer token function
  public func transfer(to: Principal, amount: Nat): async Bool {
    let caller = msg.caller;
    if (balances.get(caller)? >= amount) {
      balances.put(caller, balances.get(caller)? - amount);
      balances.put(to, balances.get(to)? + amount);
      return true;
    } else {
      return false; // insufficient balance
    }
  }
  
  // Function to check balance of a user
  public query func balanceOf(user: Principal): async Nat {
    return balances.get(user)? or 0;
  }
  
  // Mint new tokens (only by the contract owner)
  public func mint(to: Principal, amount: Nat): async Bool {
    let caller = msg.caller;
    if (caller == msg.sender) { // Only owner can mint
      totalSupply += amount;
      balances.put(to, balances.get(to)? + amount);
      return true;
    } else {
      return false;
    }
  }
};
