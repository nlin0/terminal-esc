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

(* ---------- RANDOM ITEMS ---------- *)

let obtain_item inventory hp item_str =
  let obtained = create_item hp item_str in
  print_endline (add_item inventory obtained)

let random_item () =
  let rand = Random.float 1.0 in
  if rand < 0.3 then "weapon" (* 30% chance for weapon*)
  else if rand < 0.6 then "meat" (* 30% chance for food *)
  else if rand < 0.9 then "key" (* 30% chance for key *)
  else "nothing" (* 10% nothing *)

let random_int num1 num2 =
  let range = num2 - num1 + 1 in
  let random_number = Random.int range in
  random_number + 10

(* ---------- WEAPON FUNCTIONS ---------- *)
let random_weapon () =
  let rand = Random.float 1.0 in
  if rand < 0.1 then "Legendary Sword"
  else if rand < 0.25 then "Ice Wand"
  else if rand < 0.45 then "Wooden Sword"
  else "Stone Sword"

let obtain_weapon inventory weapon =
  match weapon with
  | "Legendary Sword" ->
      print_nested_msg "chest_weapon" "legendary" chest_msgs;
      obtain_item inventory 88 "Legendary Sword"
  | "Ice Wand" ->
      print_nested_msg "chest_weapon" "wand" chest_msgs;
      obtain_item inventory 60 "Ice Wand"
  | "Stone Sword" ->
      print_nested_msg "chest_weapon" "stone" chest_msgs;
      obtain_item inventory 40 "Stone Sword"
  | _ ->
      print_nested_msg "chest_weapon" "wooden" chest_msgs;
      obtain_item inventory 25 "Wooden Sword"

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

let random_chest_item () =
  let rand = Random.float 1.0 in
  match rand with
  | rand when rand < 0.30 -> "weapon"
  | rand when rand < 0.60 -> "meat"
  | _ -> "nothing"

(* todo: change functionality after key can be acquired *)
let open_chest inventory =
  match random_chest_item () with
  | "weapon" ->
      let new_weapon = random_weapon () in
      obtain_weapon inventory new_weapon
  | "meat" ->
      let rand_hp = random_int 10 45 in
      let () = print_msg "chest_meat" chest_msgs in
      obtain_item inventory rand_hp "Meat"
  | _ ->
      let () = print_msg "chest_empty" chest_msgs in
      ()

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
        open_chest inventory
    | "2" ->
        clear_screen ();
        print_msg "chest_ignore" chest_msgs
    | _ ->
        Utils.clear_screen ();
        print_endline
          "\n\
          \ >> You must've tapped the wrong thing on your keyboard. That's \
           okay, we all make mistakes. Try again."
  in
  prompt_choice ()

(* ---------- RANDOMIZED EVENTS ---------- *)
(* let random_event inventory = let rand = Random.float 1.0 in if rand < 0.9
   then chest_prompt inventory (* all % chest for now *) else if rand < 0.1 then
   print_endline "you got trap... not implemented yet" (* 10% trap *) else if
   rand < 0.05 then print_endline "you got scenario, not implemented yet" *)
