import backend/context
import backend/router
import gleam/erlang
import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist

@external(erlang, "backend_ffi", "get_port")
fn get_port() -> Int

pub fn main() {
  wisp.configure_logger()
  let secret = wisp.random_string(64)

  let assert Ok(priv) = erlang.priv_directory("backend")
  let assert Ok(_) =
    router.handle(_, context.Context(priv <> "/static"))
    |> wisp_mist.handler(secret)
    |> mist.new
    |> mist.port(get_port())
    |> mist.start_http

  process.sleep_forever()
}
