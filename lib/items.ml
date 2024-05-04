(* stores all the qualities of the items *)

open Utils
open Inventory

let item_doc = Utils.load_json "data/items.json"

let gold_egg : inventory_item =
  { health_dmg_max = 0; empty = false; item = "Gold Egg" }

let chicken_breast : inventory_item =
  { health_dmg_max = 15; empty = false; item = "Chicken Breast" }

let print_item item =
  print_endline item.item;
  if item.health_dmg_max > 0 then
    print_endline ("\nHealth: +" ^ string_of_int item.health_dmg_max)
  else if item.health_dmg_max < 0 then
    print_endline ("\nHealth: " ^ string_of_int item.health_dmg_max)
  else print_endline "\n?";
  Utils.print_msg item.item item_doc
