actor NoteApp {
  var notes: TrieMap<Principal, Text> = TrieMap();

  // Add or update a note
  public func setNote(note: Text): async Bool {
    let caller = msg.caller;
    notes.put(caller, note);
    return true;
  }

  // Get the note of the caller
  public query func getNote(): async ?Text {
    return notes.get(msg.caller);
  }
};
