(* stores all the qualities of the items *)

open Utils
open Inventory
let item_doc = Utils.load_json "data/items.json"

let gold_egg : inventory_item = {
  mutable health_dmg_max : 0;
  mutable empty : false;
  mutable item : "Gold Egg";
}

let chicken_breast : inventory_item = {
  mutable health_dmg_max : 15;
  mutable empty : false;
  mutable item : "Chicken Breast";
}

let print_item item =
  print_endline "\n"^item.item;
  if item.health_dmg_max > 0 then
  print_string "\nHealth: "^"+"^(string_of_int item.health_dmg_max)
  else if item.health_dmg_max < 0 then
    print_string (string_of_int item.health_dmg_max)
  else
    print_string "\n?"
  Utils.print_msg item.item item_doc;
  
  