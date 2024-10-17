actor Voting {
  type Proposal = {
    id: Nat;
    description: Text;
    votes: Nat;
  };
  
  var proposals: [Proposal] = [];
  var voteRecord: TrieMap<Principal, Bool> = TrieMap(); 

  // Add a new proposal
  public func addProposal(description: Text): async Nat {
    let id = proposals.size();
    proposals := proposals # [{ id = id; description = description; votes = 0 }];
    return id;
  }

  // Vote for a proposal by ID
  public func vote(proposalId: Nat): async Bool {
    let caller = msg.caller;
    if (voteRecord.get(caller) == null and proposalId < proposals.size()) {
      proposals[proposalId].votes += 1;
      voteRecord.put(caller, true);
      return true;
    }
    return false;
  }

  // Get proposal details
  public query func getProposals(): async [Proposal] {
    return proposals;
  }

  // Get the result of a proposal by ID
  public query func getProposalResult(proposalId: Nat): async Nat {
    return proposals[proposalId].votes;
  }
};
