(** Inventory is the module that has all the inventory functionalities *)

open Utils

let constants = load_json "text_dat/constants.json"

type inventory_item = {
  mutable health_points : int;
  mutable empty : bool;
  mutable item : string;
}

(** [size] is the inventory size *)
let size = 5

let get_item_slot inventory num = Array.get inventory num

(** [create_inventory] is an empty inventory with 3 slots*)

let create_inventory () =
  let prev =
    Array.init size (fun _ ->
        { health_points = 0; empty = true; item = "none" })
  in
  let new_item = { health_points = 83; empty = false; item = "health-bar" } in
  Array.set prev 0 new_item;
  prev

let get_next_empty inventory =
  let size = Array.length inventory in
  let empty = ref size in
  for slot = size - 1 downto 0 do
    if not inventory.(slot).empty then empty := slot
  done;
  if !empty = size then empty := -1;
  !empty

(* todo: account for when empty = false... can't add *)
let add_item inventory new_item =
  let next_slot = get_next_empty inventory in
  match next_slot with
  | -1 -> print_string "Full, Unsuccessful"
  | _ ->
      Array.set inventory next_slot new_item;
      print_endline "Successful!"

let get_health inventory = (Array.get inventory 0).health_points

let print_health inventory =
  let health_text = get_nested "health-bar" constants in
  print_msg "health-bar-top" health_text;
  let rec print_boxes number str =
    if number = 0 then "" else str ^ print_boxes (number - 1) str
  in
  print_string ("|" ^ print_boxes (get_health inventory / 5) "▋");
  print_string (print_boxes (20 - (get_health inventory / 5)) " ");
  print_endline ("︳" ^ "Health: " ^ string_of_int (get_health inventory));
  print_string " ";
  print_msg "health-bar-bot" health_text
