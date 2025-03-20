import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode

pub type Model {
  Model(count: Int)
}

pub fn encode(model: Model) -> Dynamic {
  dynamic.from(#(model.count))
}

/// to be used with etf_js
pub fn decoder() -> decode.Decoder(Model) {
  use count <- decode.field(0, decode.int)
  decode.success(Model(count:))
}
