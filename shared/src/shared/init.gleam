import lustre/element
import shared/message
import shared/model.{type Model, Model}
import shared/routes.{router}

pub fn init(
  segments: List(String),
) -> #(fn(model.Model) -> element.Element(message.Message), Model) {
  let model = Model(0)
  #(router(segments), model)
}
