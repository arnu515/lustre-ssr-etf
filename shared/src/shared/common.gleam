import lustre/attribute
import lustre/element

pub type ElemFunc(msg) =
  fn(List(attribute.Attribute(msg)), List(element.Element(msg))) ->
    element.Element(msg)

pub type Children(msg) =
  List(element.Element(msg))

pub type Attrs(msg) =
  List(attribute.Attribute(msg))

pub type View(model, msg) =
  fn(model) -> element.Element(msg)
