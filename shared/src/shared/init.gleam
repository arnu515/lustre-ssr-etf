import gleam/option
import lustre/element
import shared/message
import shared/model.{type Model, Model}
import shared/routes.{router}

pub fn init(
  segments: List(String),
  model init_model: option.Option(model.Model),
) -> #(fn(model.Model) -> element.Element(message.Message), Model) {
  let model = option.unwrap(init_model, Model(0))
  #(router(segments), model)
}
