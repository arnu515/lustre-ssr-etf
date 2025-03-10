import gleam/option.{type Option, None, Some}
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html

pub fn root_html(children: Option(element.Element(msg))) {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute("charset", "UTF-8")]),
      html.meta([
        attribute("content", "width=device-width, initial-scale=1.0"),
        attribute.name("viewport"),
      ]),
      html.link([attribute.rel("stylesheet"), attribute.href("/style.css")]),
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
