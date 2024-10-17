actor IPFSStorage {

  // We use a TrieMap to store the hashes
  var ipfsHashes: TrieMap<Principal, [Text]> = TrieMap();

  // Add a new IPFS hash
  public func addIPFSHash(hash: Text): async Bool {
    let caller = msg.caller;
    let currentHashes = ipfsHashes.get(caller) ?? [];
    ipfsHashes.put(caller, currentHashes # [hash]);
    return true;
  }

  // Retrieve all IPFS hashes of the caller
  public query func getHashes(): async ?[Text] {
    return ipfsHashes.get(msg.caller);
  }
};
