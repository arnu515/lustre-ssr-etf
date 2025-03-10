import lustre/attribute
import lustre/element/html
import lustre/event
import shared/common.{type Attrs, type Children, type ElemFunc}
import shared/message

type M =
  message.Message

pub opaque type Opts {
  Opts(
    elem: ElemFunc(M),
    to: String,
    reload: Bool,
    replace: Bool,
    preload: Bool,
    attrs: Attrs(M),
    children: Children(M),
    // todo: custom click, mouseenter, touchstart events
  )
}

/// attrs must not include the href, or click, mouseenter, or touchstart events
pub fn a(
  to: String,
  attrs extra_attrs: Attrs(M),
  children children: Children(M),
) {
  Opts(
    html.a,
    to,
    False,
    False,
    True,
    [attribute.href(to), ..extra_attrs],
    children,
  )
}

/// attrs must not include click, mouseenter, or touchstart events
pub fn button(to: String, attrs attrs: Attrs(M), children children: Children(M)) {
  Opts(html.button, to, False, False, True, attrs, children)
}

pub fn with_reload(opts: Opts) {
  Opts(..opts, reload: True)
}

pub fn with_replace(opts: Opts) {
  Opts(..opts, replace: True)
}

pub fn without_preload(opts: Opts) {
  Opts(..opts, preload: False)
}

/// attrs must not include click, mouseenter, or touchstart events
pub fn link(
  el: ElemFunc(M),
  to: String,
  attrs attrs: Attrs(M),
  children children: Children(M),
) {
  Opts(el, to, False, False, True, attrs, children)
}

pub fn make(opts: Opts) {
  let click_event = fn() {
    use e <- event.on("click")
    event.prevent_default(e)
    Ok(
      message.LinkEvent(message.Load(
        to: opts.to,
        reload: opts.reload,
        replace: opts.replace,
      )),
    )
  }
  let preload_message = message.LinkEvent(message.Preload(opts.to))
  let attrs = case opts.preload {
    False -> opts.attrs
    True -> [
      event.on("touchstart", fn(_) { Ok(preload_message) }),
      event.on("mouseenter", fn(_) { Ok(preload_message) }),
      ..opts.attrs
    ]
  }
  opts.elem([click_event(), ..attrs], opts.children)
}
