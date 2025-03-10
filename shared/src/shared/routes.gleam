import gleam/int
import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import lustre/event
import shared/link
import shared/message.{Decr, Incr}
import shared/model

fn counter(model) {
  let model.Model(count:) = model
  let count = int.to_string(count)
  html.div([class("flex items-center justify-center gap-2")], [
    html.button([event.on_click(Decr), class("bg-blue-500 p-2 rounded")], [
      element.text("-"),
    ]),
    html.span([class("text-lg font-bold")], [element.text(count)]),
    html.button([event.on_click(Incr), class("bg-blue-500 p-2 rounded")], [
      element.text("+"),
    ]),
  ])
}

pub fn index(model) {
  html.div([class("flex mt-20 items-center justify-center flex-col gap-4")], [
    html.h1([class("text-5xl text-center font-bold")], [
      element.text("Lustre basic SSR demo"),
    ]),
    html.p([class("text-2xl text-center font-medium")], [
      element.text("This is a basic SSR demo with Lustre!"),
    ]),
    counter(model),
    html.p([class("text-lg text-center font-medium")], [
      link.a("/asdf", [class("text-blue-500 underline")], [
        element.text("click me!"),
      ])
      |> link.make,
    ]),
  ])
}

pub fn not_found(_model) {
  html.div([class("fixed left-0 top-0 w-full h-full grid place-items-center")], [
    html.main([class("flex flex-col gap-4 items-center justify-center")], [
      html.h1([class("text-5xl text-center font-bold")], [
        element.text("404 Not Found"),
      ]),
      html.p([class("text-2xl text-center font-medium")], [
        element.text("The page you were looking for does not exist"),
      ]),
    ]),
  ])
}

pub fn router(
  segments: List(String),
) -> fn(model.Model) -> element.Element(message.Message) {
  case segments {
    [] -> index
    _ -> not_found
  }
}
