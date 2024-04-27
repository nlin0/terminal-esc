open Yojson

(** The Utils module includes simple functions that can be used across all of
    our ml files. *)

(** [to_alst json] is a helper function that converts [json] to an association
    list *)
let to_alst json =
  match json with
  | `Assoc assoc_list -> assoc_list
  | _ -> []

(** [load_json filepath] loads the json file and converts to json *)
let load_json filepath =
  let json = Yojson.Basic.from_file filepath in
  to_alst json

(** [get_val key alst] gets out the value associated with [key] from the
    association list [alst] *)
let get_val key alst =
  (* we can add options or exceptions.. idk if its needed tho *)
  List.assoc key alst

(** [print_msg key alst] prints out the value associated with [key] from the
    association list [alst] *)
let print_msg key alst =
  print_endline (Yojson.Basic.to_string (get_val key alst))

(** [get_nested key alst] grabs the child association list in the parent [alst]
    at [key] *)
let get_nested key alst =
  let nested_json = get_val key alst in
  to_alst nested_json
