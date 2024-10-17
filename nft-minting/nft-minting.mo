actor NFT {
  type Token = {
    id: Nat;
    owner: Principal;
    metadata: Text;
  };

  var tokens: [Token] = [];
  var nextTokenId: Nat = 0;

  // Mint a new NFT
  public func mintNFT(metadata: Text): async Nat {
    let caller = msg.caller;
    let tokenId = nextTokenId;
    tokens := tokens # [{ id = tokenId; owner = caller; metadata = metadata }];
    nextTokenId += 1;
    return tokenId;
  }

  // Transfer an NFT to another user
  public func transferNFT(tokenId: Nat, to: Principal): async Bool {
    let caller = msg.caller;
    if (tokenId < tokens.size() and tokens[tokenId].owner == caller) {
      tokens[tokenId].owner := to;
      return true;
    } else {
      return false;
    }
  }

  // Get the details of a specific NFT
  public query func getToken(tokenId: Nat): async ?Token {
    if (tokenId < tokens.size()) {
      return ?tokens[tokenId];
    }
    return null;
  }
};
