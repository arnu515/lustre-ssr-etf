import backend/context
import gleam/option
import lustre/element
import shared/init
import shared/layouts
import wisp.{type Request, type Response}

pub fn handle(req: Request, ctx: context.Context) -> Response {
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use <- wisp.serve_static(req, under: "/", from: ctx.static_dir)

  let #(elem, model) =
    wisp.path_segments(req)
    |> init.init
  option.Some(elem(model))
  |> layouts.root_html()
  |> element.to_document_string_builder
  |> wisp.html_response(200)
}
