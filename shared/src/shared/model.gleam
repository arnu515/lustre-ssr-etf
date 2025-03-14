import gleam/dynamic/decode

pub type Model {
  Model(count: Int)
}

pub fn decoder() {
  use count <- decode.field("count", decode.int)
  decode.success(Model(count:))
}
