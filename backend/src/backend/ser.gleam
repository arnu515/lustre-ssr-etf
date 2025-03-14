import gleam/dynamic.{type Dynamic}
import gleam/erlang/atom
import gleam/int
import gleam/string_tree.{type StringTree}
import lustre/element
import lustre/element/html

@external(erlang, "erlang", "term_to_binary")
fn term_to_binary(term: Dynamic, opts: List(Dynamic)) -> BitArray

pub fn to_etf(term: Dynamic) {
  term_to_binary(term, [dynamic.from(atom.create_from_string("compressed"))])
}

pub fn to_etf_uncompressed(term: Dynamic) {
  term_to_binary(term, [])
}

pub fn to_etf_with_compression(term: Dynamic) {
  term_to_binary(term, [dynamic.from(atom.create_from_string("compressed"))])
}

fn binary_to_comma_sep_string(b: BitArray, st: StringTree) -> StringTree {
  case b {
    <<>> -> st
    <<a>> -> string_tree.append(st, int.to_string(a))
    <<a, rest:bytes>> ->
      string_tree.append(st, int.to_string(a) <> ",")
      |> binary_to_comma_sep_string(rest, _)
    x -> {
      // not byte aligned
      echo x
      st
    }
  }
}

pub fn binary_to_script(b: BitArray) -> element.Element(a) {
  string_tree.from_string("const data = new Uint8Array([")
  |> binary_to_comma_sep_string(b, _)
  |> string_tree.append("])")
  |> string_tree.to_string()
  |> html.script([], _)
}
