actor Ledger {
  type Transaction = {
    from: Principal;
    to: Principal;
    amount: Nat;
    timestamp: Int;
  };

  var transactions: [Transaction] = [];

  // Perform a transaction
  public func transfer(to: Principal, amount: Nat): async Bool {
    let caller = msg.caller;
    if (amount > 0) {
      let tx = {
        from = caller;
        to = to;
        amount = amount;
        timestamp = Time.now();
      };
      transactions := transactions # [tx];
      return true;
    }
    return false;
  }

  // Get the transaction history
  public query func getTransactionHistory(): async [Transaction] {
    return transactions;
  }
};
