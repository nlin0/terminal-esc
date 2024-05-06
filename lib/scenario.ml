(* organize the scenarios *)
open Constants
open Utils
open Rng

(* scenarios have a mutable field to mark whether they've occurred or not *)
type scenario = { mutable occur : bool }

(* sceanrio list is a mutable array of scenarios *)
let scenario_array : scenario array = [| s1; s2; s3; s4 |]

let s1_text = Utils.load_json "data/s1.json"

(* scenario 1 *)
let scene1 () =
  Constants.dolphin;
  Constants.waves;
  Utils.print_nested_msg "seaweed_decision" "prompt" s1_text;

(* scenario 2 *)
let scene2 () = failwith "TODO"

(* scenario 3 *)
let scene3 () = failwith "TODO"

(*scenario 4 *)
let scene4 () = failwith "TODO"

(* function that checks if a scenario has occurred and then starts the
   corresponding scenario. *)
let play_scenario s =
  if not s.occur then begin
    match s with
    | s1 -> scene1 ()
    | s2 -> scene2 ()
    | s3 -> scene3 ()
    | s4 -> scene4 ()
    | _ -> random_scenario ()
  end
  else random_scenario ()
