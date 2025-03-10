pub type LinkEvent {
  Preload(to: String)
  Load(to: String, reload: Bool, replace: Bool)
}

pub type Message {
  LinkEvent(LinkEvent)
  Incr
  Decr
}
