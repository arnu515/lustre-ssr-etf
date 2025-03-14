import etf_js
import frontend/update
import gleam/dynamic/decode
import gleam/javascript/promise
import gleam/option.{type Option, None, Some}
import gleam/uri
import lustre
import lustre/effect
import shared/init
import shared/model

@external(javascript, "./frontend_ffi.mjs", "getDocPath")
fn get_doc_path() -> String

@external(javascript, "./frontend_ffi.mjs", "getRawInitData")
fn get_raw_init_data() -> Option(BitArray)

fn get_init_data() -> promise.Promise(Option(model.Model)) {
  case get_raw_init_data() {
    Some(data) -> {
      use res <- promise.await(etf_js.to_dynamic(data))
      option.from_result(res)
      promise.resolve(Some(model.Model(0)))
    }
    None -> promise.resolve(None)
  }
}

pub fn main() {
  let segments = uri.path_segments(get_doc_path())
  use model <- promise.await(get_init_data())
  let _ =
    lustre.application(
      fn(x) { #(init.init(x, model), effect.none()) },
      update.update,
      fn(x) { x.0(x.1) },
    )
    |> lustre.start("#app", segments)

  promise.resolve(Nil)
}
