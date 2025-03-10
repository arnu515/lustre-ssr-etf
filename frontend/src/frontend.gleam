import frontend/update
import gleam/uri
import lustre
import lustre/effect
import shared/init

@external(javascript, "./frontend_ffi.mjs", "getDocPath")
fn get_doc_path() -> String

pub fn main() {
  let segments = uri.path_segments(get_doc_path())
  lustre.application(
    fn(x) { #(init.init(x), effect.none()) },
    update.update,
    fn(x) { x.0(x.1) },
  )
  |> lustre.start("#app", segments)
}
