(** Inventory is the module that has all the inventory functionalities *)

open Utils

let constants = load_json "../data/constants.json"

type inventory_item = {
  mutable health_dmg_max : int;
  mutable empty : bool;
  mutable item : string;
}

(** [size] is the inventory size *)
let size = 5

let get_item_slot inventory num = Array.get inventory num
let inventory = ref [||]

(** [create_inventory] is an empty inventory with 5 slots*)
let create_inventory () =
  let prev =
    Array.init size (fun _ ->
        { health_dmg_max = 0; empty = true; item = "none" })
  in
  let new_item = { health_dmg_max = 100; empty = false; item = "health-bar" } in
  Array.set prev 0 new_item;
  inventory := prev

let get_next_empty inventory =
  let size = Array.length inventory in
  let empty = ref size in
  for slot = size - 1 downto 0 do
    if not inventory.(slot).empty then empty := slot
  done;
  if !empty = size then empty := -1;
  !empty

let item_slot_name inventory num = (Array.get inventory num).item
let item_slot_dmg inventory num = (Array.get inventory num).health_dmg_max
let item_slot_empty inventory num = (Array.get inventory num).empty

(* todo: account for when empty = false... can't add *)
let add_item inventory new_item =
  let next_slot = get_next_empty inventory in
  match next_slot with
  | -1 -> "Full, Unsuccessful"
  | _ ->
      Array.set inventory next_slot new_item;
      "Successful!"

let remove_item inventory item_name =
  let rec find_and_remove index =
    if index >= Array.length inventory then "Item not found, unsuccessful"
    else if (not inventory.(index).empty) && inventory.(index).item = item_name
    then begin
      inventory.(index).empty <- true;
      "Successful"
    end
    else find_and_remove (index + 1)
  in
  find_and_remove 0

let get_health inventory = (Array.get inventory 0).health_dmg_max

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

(* inventory should be a list of mutable arrays *)
let rec check_item target =
  match !inventory with
  | [||] -> false (* Base case: if the inventory is empty, return false *)
  | items ->
      (* Check if any item's 'item' field matches the target *)
      let rec check = function
        | [] -> false
        | item :: rest -> if item.item = target then true else check rest
      in
      check (Array.to_list items)

(* checks to see if key is in inventory *)
let check_key () = check_item "key"
