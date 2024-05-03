(** Inventory is the module that has all the inventory functionalities *)

open Utils

let constants = load_json "text_dat/constants.json"

type inventory_item = {
  mutable health : int;
  mutable empty : bool;
  mutable item : string;
}

(** [size] is the inventory size *)
let size = 5

(** [create_inventory] is an empty inventory with 3 slots*)
let create_inventory () =
  Array.init size (fun _ -> { health = 100; empty = true; item = "none" })

(* todo: account for when empty = false... can't add *)
let add_item inventory slot new_item = inventory.(slot).item <- new_item

let print_health inventory =
  let health_text = get_nested "health-bar" constants in
  print_msg "health-bar-bot" health_text;
  let rec print_boxes number str =
    if number = 0 then "" else str ^ print_boxes (number - 1) str
  in
  print_endline (print_boxes (inventory.health / 5) "🟥");
  print_msg "health-bar-bot" health_text
