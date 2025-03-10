import lustre/effect
import shared/common.{type View}
import shared/message.{type Message, Decr, Incr, LinkEvent, Load, Preload}
import shared/model.{type Model, Model}

pub fn update(model: #(View(Model, Message), Model), message: Message) {
  let #(elem, model) = model
  case message {
    Decr -> #(#(elem, Model(..model, count: model.count - 1)), effect.none())
    Incr -> #(#(elem, Model(..model, count: model.count + 1)), effect.none())

    LinkEvent(e) -> {
      #(#(elem, model), effect.none())
    }
  }
}
