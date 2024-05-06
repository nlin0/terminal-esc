open Inventory
open Items

(* ---------- JSON AND INVENTORY ---------- *)
let room1 = Utils.load_json (Constants.run_json "data/room1.json")
let inventory = Inventory.create_inventory ()

(* ---------- TUTORIAL PLAYTHROUGH ---------- *)
(* The player will always get this in their playthrough. For new players, this
   will familiarize them witht the terminal game *)

let golden_egg_choice () =
  Utils.clear_screen ();
  Constants.happy_chicken ();
  let golden_egg = { health_dmg_max = 0; empty = false; item = "golden-egg" } in
  if Inventory.get_next_empty inventory = -1 then
    print_endline "Unsuccessful, seems like your inventory is full!"
  else (
    ignore (Inventory.add_item inventory golden_egg);
    Utils.print_nested_msg "kill_pet_chicken" "1" room1)

let dead_chicken_choice () =
  Utils.clear_screen ();
  Constants.dead_chicken ();

  let dead_chicken =
    { health_dmg_max = 0; empty = false; item = "dead-chicken" }
  in
  if Inventory.get_next_empty inventory = -1 then
    print_endline "Unsuccessful, seems like your inventory is full!"
  else (
    ignore (Inventory.add_item inventory dead_chicken);
    Utils.print_nested_msg "kill_pet_chicken" "2" room1)

let invalid_choice1 () =
  Utils.clear_screen ();
  print_endline ">> That's not an option! Please rethink your choice.\n"

let print_inventory_choice () =
  Inventory.print_inventory inventory;
  print_endline ">> Okay! Now pick your move!\n"

let rec chicken_option () =
  Constants.chicken ();
  Utils.print_nested_msg "kill_pet_chicken" "prompt" room1;

  let rec part () =
    let input = read_line () in
    match input with
    | "1" -> golden_egg_choice ()
    | "2" -> dead_chicken_choice ()
    | "i" ->
        print_inventory_choice ();
        part ()
    | "h" ->
        print_inventory_choice ();
        part ()
    | _ ->
        invalid_choice1 ();
        chicken_option ()
  in
  part ()

(* ---------- INVENTORY OPTIONS TUTORIAL ---------- *)

let print_health_choice () =
  Utils.clear_screen ();
  Inventory.print_inventory inventory;
  Inventory.print_health inventory;
  Utils.print_msg "Health Bar" item_doc;
  Utils.print_nested_msg "inventory_tutorial" "conc" room1

let clear_and_print_inventory () =
  Utils.clear_screen ();
  Inventory.print_inventory inventory

(** [inventory_option_tutorial] is run only once after players complete
    [inventory_tutorial] to teach players how to select and learn more about
    specific items. *)
let rec inventory_option_tutorial inventory =
  Utils.print_nested_msg "inventory_tutorial" "i" room1;

  let rec part () =
    let input = read_line () in
    match input with
    | "i 1" -> print_health_choice ()
    | "i 2" ->
        clear_and_print_inventory ();
        print_item (get_item_slot inventory 2);
        part ()
    | "i 3" ->
        clear_and_print_inventory ();
        print_item (get_item_slot inventory 3);
        part ()
    | "i 4" ->
        clear_and_print_inventory ();
        print_item (get_item_slot inventory 4);
        part ()
    | "i 5" ->
        clear_and_print_inventory ();
        print_item (get_item_slot inventory 5);
        part ()
    | "h" ->
        Inventory.print_health inventory;
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n";
        part ()
    | _ ->
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n"
  in
  part ()

(** [inventory_tutorial] is only run once after room1 (chicken_option) to teach
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

(** [selecting_inventory] is the function for selecting to use a specific item *)
let rec selecting_inventory item curr_fun =
  let rec part () =
    let input = read_line () in
    match input with
    | "y" -> failwith "TODO" (* use item... *)
    | "n" -> curr_fun ()
    (* reprompts the current scene*)
    | _ ->
        Utils.clear_screen ();
        print_endline
          ">> That's not an option silly! Why don't you try again.\n"
  in
  part ()

(** [calling_inventory] is the function for calling specific inventory items. *)
let rec calling_inventory input curr_fun =
  let rec part () =
    match input with
    | "i 1" -> Inventory.print_health inventory
    | "i 2" ->
        print_item (get_item_slot inventory 2);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 2) curr_fun
    | "i 3" ->
        print_item (get_item_slot inventory 3);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 3) curr_fun
    | "i 4" ->
        print_item (get_item_slot inventory 4);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 4) curr_fun
    | "i 5" ->
        print_item (get_item_slot inventory 5);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 5) curr_fun
    | "h" ->
        Inventory.print_health inventory;
        print_endline
          ">> That's not how you do it silly! It's okay, try again. \n";
        part ()
    | _ ->
        Utils.clear_screen ();
        print_endline
          ">> That's not how you do it silly! It's okay, try again.\n"
  in
  part ()

(* ---------- EVENTS ---------- *)
(* after the tutorial, the events are random. Furthermore, scenes are also
   random. The player will play until they encounter the winning scenario. *)

let encounter_chest () =
  Rng.chest_prompt inventory;

  print_endline "end of chest scenario.."

let encounter_trap () = print_endline "Trap event has not been implemneted"
let encounter_battle () = print_endline "Battle event has not been implemneted"

(* ---------- SCENARIOS ---------- *)
(* Scenarios are also further randomized. There is a small chance that the
   player will encounter the winnign scenario, but the chance is small. As the
   player encounters more scenarios, the chances up encountering the winning
   scenario will increase. *)

(** List to keep track of visited scenes *)
let visited_scenes = ref []

(** [visit_scene scene] adds [scene] to the list of visited scenes *)
let visit_scene scene = visited_scenes := scene :: !visited_scenes

(** [has_visited scene] checks if [scene] has already been visited *)
let has_visited scene = List.mem scene !visited_scenes

(* ---------- RANDOMIZED PLAY ---------- *)
(* After the tutorial, the events are random *)

(** [random_scene] generates a random scene after the tutorial. *)
let rec random_scenario () =
  let available_scenes =
    [ scene_1; scene_2; scene_3 ] |> List.filter (fun s -> not (has_visited s))
  in
  match available_scenes with
  | [] -> print_endline "win" (* No more available scenes *)
  | _ ->
      let scene_num = Random.int (List.length available_scenes) in
      let scene = List.nth available_scenes scene_num in
      scene ()

(** [scene_1] is a placeholder for one of the random scenes. *)
and scene_1 () =
  (* Implement scene 1 logic here *)
  Utils.clear_screen ();
  visit_scene scene_1;
  print_endline "placeholder"

and scene_2 () =
  (* Implement scene 2 logic here *)
  Utils.clear_screen ();
  visit_scene scene_2;
  print_endline "placeholder"

and scene_3 () =
  (* Implement scene 3 logic here *)
  Utils.clear_screen ();
  visit_scene scene_3;
  print_endline "placeholder"

(* ---------- RANDODMIZED PLAY ---------- *)

let rec random_event () =
  let event_num = Random.int 100 in
  match event_num with
  | n when n < 90 -> encounter_chest ()
  | n when n < 55 -> random_scenario ()
  | n when n < 70 -> encounter_trap ()
  | _ -> encounter_battle ()

(* ---------- START GAME ---------- *)
let start () =
  Utils.print_msg "intro" room1;
  chicken_option ();
  inventory_tutorial ();
  random_event ()
