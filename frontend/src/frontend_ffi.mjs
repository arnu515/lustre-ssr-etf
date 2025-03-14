import { Some, None } from "../gleam_stdlib/gleam/option.mjs"
import {BitArray} from "./gleam.mjs"

export function getDocPath() {
  return new URL(window.location.href).pathname
} 

export function getRawInitData() {
  console.log(data)
  if (typeof data === 'undefined') return new None()
  return new Some(new BitArray(data))
}
