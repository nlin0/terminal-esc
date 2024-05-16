(* RNG Functions *)
open Utils
open Inventory
(* open Scenario *)

let () = Random.self_init ()

(* ---------- SCENARIOS ---------- *)
(* let random_scenario () = let rand = Random.float 1.0 in if rand >= 0. && rand
   < 0.25 then play_scenario scenario_array.(0) (* 25% s1 *) else if rand >=
   0.25 && rand < 0.5 then play_scenario scenario_array.(1) (* 25% s2 *) else if
   rand >= 0.5 && rand < 0.75 then play_scenario scenario_array.(2) (* 25% s3 *)
   else if rand >= 0.75 && rand <= 1. then play_scenario scenario_array.(3) *)

(* ---------- JSON TEXT FILES ---------- *)
let chest_msgs = load_json (Constants.run_json "chest")
let battle_msgs = load_json (Constants.run_json "battle")

(* ---------- RANDOM ITEMS ---------- *)

let obtain_item inventory hp item_str =
  let obtained = create_item hp item_str in
  print_endline (add_item inventory obtained)

let random_item_helper num =
  if num < 0.3 then "weapon" (* 30% chance for weapon*)
  else if num < 0.6 then "Meat" (* 30% chance for food *)
  else if num < 0.9 then "key" (* 30% chance for key *)
  else "nothing" (* 10% nothing *)

let random_item () =
  let rand = Random.float 1.0 in
  random_item_helper rand

let random_int num1 num2 =
  let range = num2 - num1 + 1 in
  let random_number = Random.int range in
  random_number + 10

(* ---------- WEAPON FUNCTIONS ---------- *)

let random_weapon_helper num =
  if num < 0.1 then "Legendary Sword"
  else if num < 0.25 then "Ice Wand"
  else if num < 0.45 then "Wooden Sword"
  else "Stone Sword"

let random_weapon () =
  let rand = Random.float 1.0 in
  random_weapon_helper rand

let obtain_weapon inventory weapon =
  match weapon with
  | "Legendary Sword" ->
      print_nested_msg "chest_weapon" "legendary" chest_msgs;
      obtain_item inventory 50 "Legendary Sword"
  | "Ice Wand" ->
      print_nested_msg "chest_weapon" "wand" chest_msgs;
      obtain_item inventory 35 "Ice Wand"
  | "Stone Sword" ->
      print_nested_msg "chest_weapon" "stone" chest_msgs;
      obtain_item inventory 23 "Stone Sword"
  | _ ->
      print_nested_msg "chest_weapon" "wooden" chest_msgs;
      obtain_item inventory 15 "Wooden Sword"

(* for battle scenarios *)
let obtain_weapon_drop weapon inventory =
  match weapon with
  | "Legendary Sword" ->
      print_nested_msg "battle_weapon" "legendary" battle_msgs;
      obtain_item inventory 88 "Legendary Sword"
  | "Ice Wand" ->
      print_nested_msg "battle_weapon" "wand" battle_msgs;
      obtain_item inventory 60 "Ice Wand"
  | "Stone Sword" ->
      print_nested_msg "battle_weapon" "stone" battle_msgs;
      obtain_item inventory 40 "Stone Sword"
  | _ ->
      print_nested_msg "battle_weapon" "wooden" battle_msgs;
      obtain_item inventory 25 "Wooden Sword"

let obtain_ran_weapon inventory =
  let weapon = random_weapon () in
  obtain_weapon_drop weapon inventory

(* ---------- CHEST FUNCTIONS ---------- *)

let random_chest_intro () =
  let rand = Random.float 1.0 in
  let num =
    match rand with
    | _ when rand < 0.25 -> "1"
    | _ when rand < 0.5 -> "2"
    | _ when rand < 0.75 -> "3"
    | _ -> "4"
  in
  print_nested_msg "chest_descr" num chest_msgs

let random_battle_intro () =
  clear_screen ();
  let rand = Random.float 1.0 in
  let num =
    match rand with
    | _ when rand < 0.25 -> "1"
    | _ when rand < 0.5 -> "2"
    | _ when rand < 0.75 -> "3"
    | _ -> "4"
  in
  print_nested_msg "prompts" num battle_msgs

let chest_helper num =
  match num with
  | num when num < 0.30 -> "weapon"
  | num when num < 0.60 -> "Meat"
  | _ -> "nothing"

let random_chest_item () =
  let rand = Random.float 1.0 in
  chest_helper rand

let open_chest inventory =
  let _ = remove_item inventory "key" in
  match random_chest_item () with
  | "weapon" ->
      let new_weapon = random_weapon () in
      obtain_weapon inventory new_weapon;
      pause_cont ()
  | "Meat" ->
      let rand_hp = random_int 20 90 in
      let () = print_msg "chest_meat" chest_msgs in
      obtain_item inventory rand_hp "Meat";
      pause_cont ()
  | _ ->
      let () = print_msg "chest_empty" chest_msgs in
      pause_cont ()

let no_key_prompt () =
  print_msg "chest_fail" chest_msgs;
  pause_cont ()

let chest_prompt inventory =
  Utils.clear_screen ();
  random_chest_intro ();
  let rec prompt_choice () =
    Constants.chest ();
    print_msg "chest_prompt" chest_msgs;

    let input = read_line () in
    match input with
    | "1" ->
        clear_screen ();
        if check_key inventory then begin
          open_chest inventory
        end
        else begin
          no_key_prompt ()
        end
    | "2" ->
        clear_screen ();
        print_msg "chest_ignore" chest_msgs;
        pause_cont ()
    | _ ->
        Utils.clear_screen ();
        print_endline
          "\n\
          \ >> You must've tapped the wrong thing on your keyboard. That's \
           okay, we all make mistakes. Try again."
  in
  prompt_choice ()
