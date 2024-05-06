(* RNG Functions *)
open Utils
open Inventory
open Scenario

let () = Random.self_init ()

let random_scenario () =
  let rand = Random.float 1.0 in
  if rand >= 0. && rand < 0.25 then play_scenario scenario_array.(0)
    (* 25% s1 *)
  else if rand >= 0.25 && rand < 0.5 then play_scenario scenario_array.(1)
    (* 25% s2 *)
  else if rand >= 0.5 && rand < 0.75 then play_scenario scenario_array.(2)
    (* 25% s3 *)
  else if rand >= 0.75 && rand <= 1. then play_scenario scenario_array.(3)
(* 25% s4 *)

let random_event () =
  let rand = Random.float 1.0 in
  if rand >= 0. && rand < 0.1 then failwith "TODO" (* 10% trap *)
  else if rand >= 0.1 && rand < 0.4 then failwith "TODO" (* 30% chest *)
  else if rand >= 0.4 && rand <= 1. then random_scenario ()
(* 60% scenario *)

(* 

   let () = Random.self_init ()

   let random_weapon() = let rand = Random.float 1.0 in if rand < 0.1 then
   "Legendary Sword" else if rand < 0.25 then "Ice Wand" else if rand < 0.45
   then "Wooden Sword" else "Stone Sword"

   let random_item() = let rand = Random.float 1.0 in if rand < 0.3 then
   random_weapon()(* 30% chance for weapon*) else if rand < 0.6 then "meat" (*
   60% chance for food *) else "key" (* else get key instead *)

   let open_chest inventory = let has_key = Inventory.check_key inventory in if
   not has_key then print ms *)
