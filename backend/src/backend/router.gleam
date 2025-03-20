import backend/context
import backend/ser
import gleam/option.{type Option, None, Some}
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html
import shared/init
import shared/model
import wisp.{type Request, type Response}

fn init_data(init: model.Model, segments: List(String)) -> Option(model.Model) {
  case segments {
    [] -> Some(model.Model(..init, count: 5))
    _ -> None
  }
}

pub fn root_html(model: model.Model, children: Option(element.Element(msg))) {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute("charset", "UTF-8")]),
      html.meta([
        attribute("content", "width=device-width, initial-scale=1.0"),
        attribute.name("viewport"),
      ]),
      html.link([attribute.rel("stylesheet"), attribute.href("/style.css")]),
      ser.binary_to_script(ser.to_etf_with_compression(model.encode(model))),
      html.title([], "Wilkommen auf App"),
    ]),
    html.body([], [
      html.div([attribute.id("app")], case children {
        Some(children) -> [children]
        None -> []
      }),
      html.script(
        [attribute.type_("module")],
        "import {main} from \"/script.js\";window.main=main;main()",
      ),
    ]),
  ])
}

pub fn handle(req: Request, ctx: context.Context) -> Response {
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use <- wisp.serve_static(req, under: "/", from: ctx.static_dir)

  let segments = wisp.path_segments(req)
  let #(elem, model) = init.init(segments, None)
  let model = init_data(model, segments) |> option.unwrap(model)
  Some(elem(model))
  |> root_html(model, _)
  |> element.to_document_string_builder
  |> wisp.html_response(200)
}
