open Constants
open Inventory
open Items
open Rng

(* NOTE: DELETE THE DUNE FILE IN THE ROOT AFTER WE ARE DONE TESTING *)
(* ---------- JSON AND INVENTORY ---------- *)

(* load nested json *)
let tut = Utils.load_json "data/tutorial.json"
let scenarios = Utils.load_json "data/scenarios.json"

(* build rng function to random option choices... *)
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
    Utils.print_nested_msg "kill_pet_chicken" "1" tut)

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
    Utils.print_nested_msg "kill_pet_chicken" "2" tut)

(* Note: reusing in other functions *)
let invalid_choice1 () =
  Utils.clear_screen ();
  print_endline ">> That's not an option! Please rethink your choice.\n"

(* Note: reusing in other functions *)
let print_inventory_choice () =
  Inventory.print_inventory inventory;
  print_endline ">> Okay! Now pick your move!\n"

let rec chicken_option () =
  Constants.chicken ();
  Utils.print_nested_msg "kill_pet_chicken" "prompt" tut;

  let rec part () =
    let input = read_line () in
    match input with
    | "1" -> golden_egg_choice ()
    | "2" -> dead_chicken_choice ()
    | "i" ->
        print_inventory_choice ();
        part ()
    | "h" ->
        print_health inventory;
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
  Utils.print_msg "health-bar" item_doc;
  Utils.print_nested_msg "inventory_tutorial" "conc" tut

let clear_and_print_inventory () =
  Utils.clear_screen ();
  Inventory.print_inventory inventory

(* [inventory_option_tutorial] is run only once after players complete
   [inventory_tutorial] to teach players how to select and learn more about
   specific items. *)
let rec inventory_option_tutorial inventory =
  Utils.print_nested_msg "inventory_tutorial" "i" tut;
  let rec part () =
    let input = read_line () in
    match input with
    | "i 1" ->
        print_health_choice ();
        Utils.pause_cont ()
    | "i 2" ->
        print_item (get_item_slot inventory 1);
        print_endline "\n>> Nice job show off, but try again.\n";
        part ()
    | "i 3" ->
        print_item (get_item_slot inventory 2);
        print_endline "\n>> Nice try, but not quite. Try again!\n";
        part ()
    | "i 4" ->
        print_item (get_item_slot inventory 3);
        print_endline "\n>> Nice try, but not quite. Try again!\n";
        part ()
    | "i 5" ->
        print_item (get_item_slot inventory 4);
        print_endline "\n>> Nice try, but not quite. Try again!\n";
        part ()
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
  Utils.print_nested_msg "inventory_tutorial" "prompt" tut;
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
          ">> That's not how you do it silly! It's okay, try again.\n";
        part ()
  in
  part ()

(* [selecting_inventory] is the function for selecting to use a specific item *)
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

(* [calling_inventory] is the function for calling specific inventory items. *)
let rec calling_inventory input curr_fun =
  let rec part () =
    match input with
    | "i 1" -> Inventory.print_health inventory
    | "i 2" ->
        print_item (get_item_slot inventory 1);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 2) curr_fun
    | "i 3" ->
        print_item (get_item_slot inventory 2);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 3) curr_fun
    | "i 4" ->
        print_item (get_item_slot inventory 3);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 4) curr_fun
    | "i 5" ->
        print_item (get_item_slot inventory 4);
        print_endline "\n>> Would you like to use this item? (y/n)\n";
        selecting_inventory (get_item_slot inventory 5) curr_fun
    | "h" ->
        Inventory.print_health inventory;
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

let encounter_chest () = Rng.chest_prompt inventory
let encounter_trap () = print_endline "Trap event has not been implemneted"
let encounter_battle () = Battle.battle_prompt inventory

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

let s1 = Utils.get_nested "s1" scenarios
let s2 = Utils.get_nested "s2" scenarios
let s3 = Utils.get_nested "s3" scenarios
let s4 = Utils.get_nested "s4" scenarios
let s5 = Utils.get_nested "s5" scenarios

(** [random_scene] generates a random scene after the tutorial. *)
let rec random_scenario () =
  let available_scenes =
    [ scene_1; scene_2; scene_3; scene_4; scene_5 ]
    |> List.filter (fun s -> not (has_visited s))
  in
  match available_scenes with
  | [] -> print_endline "win" (* No more available scenes *)
  | _ ->
      let scene_num = Random.int (List.length available_scenes) in
      let scene = List.nth available_scenes scene_num in
      scene ()

and scene_1 () =
  Utils.clear_screen ();
  visit_scene scene_1;
  let seaweed_choice () =
    Utils.clear_screen ();
    let seaweed_piece =
      { health_dmg_max = 0; empty = false; item = "seaweed-piece" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory seaweed_piece);
      Utils.print_nested_msg "seaweed_decision" "1" scenarios)
  in

  let dolphin_friend_choice () =
    Utils.clear_screen ();
    let dolphin_friend =
      { health_dmg_max = 0; empty = false; item = "dolphin-friend" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory dolphin_friend);
      Utils.print_nested_msg "seaweed_decision" "2" scenarios)
  in
  Utils.print_nested_msg "s1" "intro" scenarios;
  Utils.print_nested_msg "seaweed_decision" "prompt" scenarios;
  let rec part () =
    let input = read_line () in
    match input with
    | "1" -> seaweed_choice ()
    | "2" -> dolphin_friend_choice ()
    | "i" ->
        print_inventory_choice ();
        (* defined outside in tutorial *)
        part ()
    | "h" ->
        print_health inventory;
        part ()
    | _ ->
        invalid_choice1 ();
        (* defined outside in tutorial *)
        scene_1 ()
  in
  part ()

and scene_2 () =
  Utils.clear_screen ();
  visit_scene scene_2;
  let trusty_map_choice () =
    Utils.clear_screen ();
    let trusty_map =
      { health_dmg_max = 0; empty = false; item = "trusty-map" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory trusty_map);
      Utils.print_deep_nested_msg "s2" "carrot_patch_decision" "1" scenarios)
  in

  let untrustworthy_map_choice () =
    Utils.clear_screen ();
    let untrustworthy_map =
      { health_dmg_max = 0; empty = false; item = "untrustworthy-map" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory untrustworthy_map);
      Utils.print_deep_nested_msg "s2" "carrot_patch_decision" "2" scenarios)
  in
  Utils.print_nested_msg "s2" "intro" scenarios;
  Utils.print_deep_nested_msg "s2" "carrot_patch_decision" "prompt" scenarios;
  let rec part () =
    let input = read_line () in
    match input with
    | "1" -> trusty_map_choice ()
    | "2" -> untrustworthy_map_choice ()
    | "i" ->
        print_inventory_choice ();
        (* defined outside in tutorial *)
        part ()
    | "h" ->
        print_health inventory;
        part ()
    | _ ->
        invalid_choice1 ();
        (* defined outside in tutorial *)
        scene_2 ()
  in
  part ()

and scene_3 () =
  Utils.clear_screen ();
  visit_scene scene_3;
  let your_skeleton_choice () =
    Utils.clear_screen ();
    let your_skeleton =
      { health_dmg_max = 0; empty = false; item = "your-skeleton" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory your_skeleton);
      Utils.print_deep_nested_msg "s3" "lava_bridge_decision" "1" scenarios)
  in

  let shiny_crystal_choice () =
    Utils.clear_screen ();
    let shiny_crystal =
      { health_dmg_max = 0; empty = false; item = "shiny-crystal" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory shiny_crystal);
      Utils.print_deep_nested_msg "s3" "lava_bridge_decision" "2" scenarios)
  in
  Utils.print_nested_msg "s3" "intro" scenarios;
  Utils.print_deep_nested_msg "s3" "lava_bridge_decision" "prompt" scenarios;
  let rec part () =
    let input = read_line () in
    match input with
    | "1" ->
        your_skeleton_choice ();
        exit 0
    | "2" -> shiny_crystal_choice ()
    | "i" ->
        print_inventory_choice ();
        (* defined outside in tutorial *)
        part ()
    | "h" ->
        print_health inventory;
        part ()
    | _ ->
        invalid_choice1 ();
        (* defined outside in tutorial *)
        scene_3 ()
  in
  part ()

and scene_4 () =
  Utils.clear_screen ();
  visit_scene scene_4;
  let food_scrap_choice () =
    Utils.clear_screen ();
    let food_scrap =
      { health_dmg_max = 0; empty = false; item = "food-scrap" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory food_scrap);
      Utils.print_deep_nested_msg "s4" "sandstorm_survival" "1" scenarios)
  in

  let ancient_crown_choice () =
    Utils.clear_screen ();
    let ancient_crown =
      { health_dmg_max = 0; empty = false; item = "ancient-crown" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory ancient_crown);
      Utils.print_deep_nested_msg "s4" "sandstorm_survival" "2" scenarios)
  in
  Utils.print_nested_msg "s4" "intro" scenarios;
  Utils.print_deep_nested_msg "s4" "sandstorm_survival" "prompt" scenarios;
  let rec part () =
    let input = read_line () in
    match input with
    | "1" -> food_scrap_choice ()
    | "2" -> ancient_crown_choice ()
    | "i" ->
        print_inventory_choice ();
        (* defined outside in tutorial *)
        part ()
    | "h" ->
        print_health inventory;
        part ()
    | _ ->
        invalid_choice1 ();
        (* defined outside in tutorial *)
        scene_4 ()
  in
  part ()

and scene_5 () =
  Utils.clear_screen ();
  visit_scene scene_5;
  let night_orb_choice () =
    Utils.clear_screen ();
    let night_orb = { health_dmg_max = 0; empty = false; item = "night-orb" } in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory night_orb);
      Utils.print_deep_nested_msg "s5" "echo_chamber_decision" "1" scenarios)
  in

  let your_skeleton_choice () =
    Utils.clear_screen ();
    let your_skeleton =
      { health_dmg_max = 0; empty = false; item = "your-skeleton" }
    in
    if Inventory.get_next_empty inventory = -1 then
      print_endline "Unsuccessful, seems like your inventory is full!"
    else (
      ignore (Inventory.add_item inventory your_skeleton);
      Utils.print_deep_nested_msg "s5" "echo_chamber_decision" "2" scenarios)
  in
  Utils.print_nested_msg "s5" "intro" scenarios;
  Utils.print_deep_nested_msg "s5" "echo_chamber_decision" "prompt" scenarios;
  let rec part () =
    let input = read_line () in
    match input with
    | "1" -> night_orb_choice ()
    | "2" ->
        your_skeleton_choice ();
        exit 0
    | "i" ->
        print_inventory_choice ();
        (* defined outside in tutorial *)
        part ()
    | "h" ->
        print_health inventory;
        part ()
    | _ ->
        invalid_choice1 ();
        (* defined outside in tutorial *)
        scene_1 ()
  in
  part ()

(* ---------- RANDODMIZED PLAY ---------- *)

let rec random_event () =
  let event_num = Random.int 100 in
  match event_num with
  | n when n < 33 ->
      (* 33% chance for encounter_battle *)
      encounter_battle ();
      random_event ()
  | n when n < 66 ->
      (* 33% chance for encounter_chest *)
      encounter_chest ();
      random_event ()
  | _ ->
      (* 34% chance for random_scenario *)
      random_scenario ();
      random_event ()

(* ---------- START GAME ---------- *)
let start () =
  Utils.print_msg "intro" tut;
  chicken_option ();
  inventory_tutorial ();
  encounter_chest ();
  Battle.battle_tutorial inventory;
  random_event ()
