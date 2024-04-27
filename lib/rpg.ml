open Yojson
open Constants

(* NOTE: DELETE THE DUNE FILE IN THE ROOT AFTER WE ARE DONE TESTING *)

(* load nested json *)
let room1 = Utils.load_json "text_dat/room1.json"
(* build rng function to random option choices... *)

(* first option on all playthroughs *)
let rec chicken_option () =
  Constants.chicken ();
  Utils.print_nested_msg "kill_pet_chicken" "prompt" room1;
  let input = read_line () in
  match input with
  | "1" ->
      Constants.happy_chicken ();
      Utils.print_nested_msg "kill_pet_chicken" "1" room1
  | "2" ->
      Constants.dead_chicken ();
      Utils.print_nested_msg "kill_pet_chicken" "2" room1
  | _ ->
      print_endline "That's not an option! Please rethink your choice.\n";
      chicken_option ()

let start () =
  Utils.print_msg "intro" room1;
  chicken_option ()
