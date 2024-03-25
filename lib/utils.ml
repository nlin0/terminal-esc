(* open Yojson

   (* The utilities.ml will have simple functions that can be used across all of
   our ml files. For example loading a json file *)

   let to_alst json = match json with | `Assoc assoc_list -> assoc_list | _ ->
   []

   (* load json file *) let load_json filepath = let json =
   Yojson.Basic.from_file filepath in to_alst json

   (* function for retriving the value of key *) let get_val key alst = (* we
   can add options or exceptions.. idk if its needed tho *) List.assoc key alst

   (* function for grabbing a nested dictionary *) let get_nested key alst = let
   nested_json = get_val key alst in to_alst nested_json *)
