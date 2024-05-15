(** Inventory is the module that has all the inventory functionalities *)

open Utils

let constants = load_json (Constants.run_json "constants")
(*let constants = load_json
  "/Users/jollyzheng/Desktop/terminal-esc/data/constants.json"*)

type inventory_item = {
  mutable health_dmg_max : int;
  mutable empty : bool;
  mutable item : string;
}

(** [size] is the inventory size *)
let size = 5

let get_item_slot inventory num = Array.get inventory num

(** [create_inventory] is an empty inventory with 5 slots*)

let create_inventory () =
  let prev =
    Array.init size (fun _ ->
        { health_dmg_max = 0; empty = true; item = "none" })
  in
  let new_item = { health_dmg_max = 100; empty = false; item = "health-bar" } in
  Array.set prev 0 new_item;
  prev

(*[create_item health_dmg item] returns an item with the inputted health_damage
  and inputted item name*)
let create_item health_dmg item =
  { health_dmg_max = health_dmg; empty = false; item }

(*[create_item health_dmg item] returns the next empty slot in the inventory. It
  would return -1 if there is not empty slot left.*)

let get_next_empty inventory =
  let size = Array.length inventory in
  let rec find_empty_slot slot =
    if slot >= size then -1
    else if inventory.(slot).empty then slot
    else find_empty_slot (slot + 1)
  in
  find_empty_slot 0

(*[item_slot_name inventory num] returns the name of the item at the specified
  location*)
let item_slot_name inventory num = (Array.get inventory num).item

(*[item_slot_dmg inventory num] returns the damage of the item at the specified
  location*)
let item_slot_dmg inventory num = (Array.get inventory num).health_dmg_max

(*[item_slot_empty inventory num] returns where the slot is empty at the
  specified location*)
let item_slot_empty inventory num = (Array.get inventory num).empty

(*[add_item inventory new_item] returns a string message of whether the item has
  been added into your inventory.*)
let add_item inventory new_item =
  let next_slot = get_next_empty inventory in
  match next_slot with
  | -1 -> "Your Inventory is Full."
  | _ ->
      Array.set inventory next_slot new_item;
      "Item has been added to Inventory!"

(*[remove_item inventory item_name] returns a message of whether the item (based
  on item name) has been removed from the inventory.*)
let remove_item inventory item_name =
  let rec find_and_remove index =
    if index >= Array.length inventory then "Item not found, unsuccessful"
    else if (not inventory.(index).empty) && inventory.(index).item = item_name
    then begin
      Array.set inventory index
        { health_dmg_max = 0; empty = true; item = "none" };
      "Successful"
    end
    else find_and_remove (index + 1)
  in
  find_and_remove 0

(* ---- battling ---- *)
(*[get_health inventory] returns the number of health currently.*)
let get_health inventory = (Array.get inventory 0).health_dmg_max

(*[add_health inventory num] adds the num health from what the player current
  has.*)
let add_health inventory num =
  let player_item = Array.get inventory 0 in
  let new_health = player_item.health_dmg_max + num in
  player_item.health_dmg_max <- new_health

(*[deduct_health inventory num] removes the num health from what the player
  current has.*)
let deduct_health inventory num =
  let player_item = Array.get inventory 0 in
  let new_health = player_item.health_dmg_max - num in
  player_item.health_dmg_max <- new_health

(*[print_health inventory] prints out the current health and the health bar.*)
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

(*[print_inventory inventory] prints out the items in inventory.*)
let print_inventory inventory =
  let max_item_length = 29 in
  (* Added padding so there is a maximum length for item names *)
  print_endline "╔════════════════════════════════════════╗";
  print_endline "║                Inventory               ║";
  print_endline "╠════════════════════════════════════════╣";
  Array.iteri
    (fun i item ->
      let padded_item_name =
        if not item.empty then
          let len_diff = max_item_length - String.length item.item in
          item.item ^ String.make (max 0 len_diff) ' '
        else "Empty"
      in
      Printf.printf "║  Slot %d: %-*s ║\n" (i + 1) max_item_length
        padded_item_name)
    inventory;
  print_endline "╚════════════════════════════════════════╝"

(** [check_item inventory target] returns whether or not the inputted string
    item name is inside the inventory or not.*)

let check_item inventory target =
  match inventory with
  | [||] -> false (* Base case: if the inventory is empty, return false *)
  | slot ->
      (* Check if any item's 'item' field matches the target *)
      let rec check = function
        | [] -> false
        | item :: rest -> if item.item = target then true else check rest
      in
      check (Array.to_list slot)

(* [check_key inventory ] returns whether or not we have a key in the
   inventory. *)
let check_key inventory = check_item inventory "key"

(* [select_item_pos inventory] returns the position of the item the player
   player selects items for battling*)
let select_item_pos inventory =
  let rec prompt_item () =
    print_inventory inventory;
    print_endline "Select an item to use (enter item number):";
    try
      let choice = read_int () in
      if choice < 1 || choice > Array.length inventory then begin
        print_endline "Invalid choice. Please enter a valid item number.";
        prompt_item ()
      end
      else choice
    with Failure _ ->
      print_endline "Invalid input. Please enter a valid item number.";
      prompt_item ()
  in
  prompt_item ()
