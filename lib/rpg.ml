open Constants
open Inventory
open Items

(* NOTE: DELETE THE DUNE FILE IN THE ROOT AFTER WE ARE DONE TESTING *)

(* load nested json *)
let room1 = Utils.load_json "data/room1.json"

(* build rng function to random option choices... *)
let inventory = Inventory.create_inventory ()

(* first option on all playthroughs *)
let rec chicken_option () =
  Constants.chicken ();
  Utils.print_nested_msg "kill_pet_chicken" "prompt" room1;
  let rec part () =
    let input = read_line () in
    match input with
    | "1" ->
        Utils.clear_screen ();
        Constants.happy_chicken ();
        Utils.print_nested_msg "kill_pet_chicken" "1" room1
    | "2" ->
        Utils.clear_screen ();
        Constants.dead_chicken ();
        Utils.print_nested_msg "kill_pet_chicken" "2" room1
    | "i" ->
        Inventory.print_inventory inventory;
        print_endline "Okay! Now pick your move!";
        part ()
    | "h" ->
        Inventory.print_health inventory;
        print_endline "Okay! Now pick your move!";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline "That's not an option! Please rethink your choice.\n";
        chicken_option ()
  in
  part ()

let rec inventory_option inventory =
  Utils.print_nested_msg "inventory_tutorial" "i" room1;
  let rec part () =
    let input = read_line () in
    match input with
    | "i 1" ->
        (* first item is health bar *)
        Inventory.print_health inventory;
        Utils.print_msg "Health Bar" Items.item_doc
    | "i 3" -> print_item (Inventory.item_slot_name inventory 3)
    | "i 4" -> print_item (Inventory.item_slot_name inventory 4)
    | "i 5" -> print_item (Inventory.item_slot_name inventory 5)
    | "h" ->
        Inventory.print_health inventory;
        print_endline "Cool, but not right now. Why don't you try again?\n";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline "That's not how you do it silly! It's okay, try again.\n";
        part ()
  in
  part ()

let rec inventory_tutorial () =
  Utils.print_nested_msg "inventory_tutorial" "prompt" room1;
  let rec part () =
    let input = read_line () in
    match input with
    | "i" ->
        Inventory.print_inventory inventory;
        inventory_option inventory
    | "h" ->
        Inventory.print_health inventory;
        print_endline "Cool, but not right now. Why don't you try again?\n";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline "That's not how you do it silly! It's okay, try again.\n";
        part ()
  in
  part ()

let start () =
  Utils.print_msg "intro" room1;
  chicken_option ();
  inventory_tutorial ()
