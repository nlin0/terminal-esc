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
        let golden_egg =
          { health_dmg_max = 0; empty = false; item = "golden-egg" }
        in
        if Inventory.get_next_empty inventory = -1 then
          print_endline "Unsuccessful, seems like your chest is full!"
        else (
          ignore (Inventory.add_item inventory golden_egg);
          Utils.print_nested_msg "kill_pet_chicken" "1" room1)
    | "2" ->
        Utils.clear_screen ();
        Constants.dead_chicken ();

        let dead_chicken =
          { health_dmg_max = 0; empty = false; item = "dead-chicken" }
        in
        if Inventory.get_next_empty inventory = -1 then
          print_endline "Unsuccessful, seems like your chest is full!"
        else (
          ignore (Inventory.add_item inventory dead_chicken);
          Utils.print_nested_msg "kill_pet_chicken" "2" room1)
    | "i" ->
        Inventory.print_inventory inventory;
        print_endline ">> Okay! Now pick your move!\n";
        part ()
    | "h" ->
        Inventory.print_health inventory;
        print_endline ">> Okay! Now pick your move!\n";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline ">> That's not an option! Please rethink your choice.\n";
        chicken_option ()
  in
  part ()

(* [inventory_option_tutorial] is run only once after players complete
   [inventory_tutorial] to teach players how to select and learn more about
   specific items. *)
let rec inventory_option_tutorial inventory =
  Utils.print_nested_msg "inventory_tutorial" "i" room1;
  let rec part () =
    let input = read_line () in
    match input with
    | "i 1" ->
        (* first item is health bar *)
        Inventory.print_health inventory;
        Utils.print_msg "Health Bar" item_doc
    | "i 2" -> print_item (get_item_slot inventory 2)
    | "i 3" -> print_item (get_item_slot inventory 3)
    | "i 4" -> print_item (get_item_slot inventory 4)
    | "i 5" -> print_item (get_item_slot inventory 5)
    | "h" ->
        Inventory.print_health inventory;
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n"
  in
  part ()

(* [inventory_tutorial] is only run once after room1 (chicken_option) to teach
   players how to open their inventory. *)
let rec inventory_tutorial () =
  Utils.print_nested_msg "inventory_tutorial" "prompt" room1;
  let rec part () =
    let input = read_line () in
    match input with
    | "i" ->
        Inventory.print_inventory inventory;
        inventory_option_tutorial inventory
    | "h" ->
        Inventory.print_health inventory;
        print_endline ">> Cool, but not right now. Why don't you try again?\n";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n"
  in
  part ()

(* [calling_inventory] is the function for calling specific inventory items. *)
let rec calling_inventory input =
  let rec part () =
    match input with
    | "i 1" ->
        (* first item is health bar *)
        Inventory.print_health inventory;
        Utils.print_msg "Health Bar" item_doc
    | "i 2" -> print_item (get_item_slot inventory 2)
    | "i 3" -> print_item (get_item_slot inventory 3)
    | "i 4" -> print_item (get_item_slot inventory 4)
    | "i 5" -> print_item (get_item_slot inventory 5)
    | "h" ->
        Inventory.print_health inventory;
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n"
  in
  part ()

let rec selecting_inventory input =
  match input with
  | _ -> failwith "TODO"

let start () =
  Utils.print_msg "intro" room1;
  chicken_option ();
  inventory_tutorial ()
