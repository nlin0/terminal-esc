open Utils
open Inventory
(* RNG Functions *)

(* 


let () = Random.self_init ()
  
let random_weapon() = 
  let rand = Random.float 1.0 in
  if rand < 0.1 then "Legendary Sword"
  else if rand < 0.25 then "Ice Wand"
  else if rand < 0.45 then "Wooden Sword"
  else "Stone Sword"

let random_item() = 
  let rand = Random.float 1.0 in
  if rand < 0.3 then random_weapon()(* 30% chance for weapon*)
  else if rand < 0.6 then "meat"  (* 60% chance for food *)
  else "key" (* else get key instead *)


let open_chest inventory = 
  let has_key = Inventory.check_key inventory in
  if not has_key then
    print ms  *)


  