open Utils
open Inventory
open Rng

let () = Random.self_init ()
let battle_msgs = load_json (Constants.run_json "battle")

type enemy = {
  mutable hp : int;
  mutable atk : int;
  name : string;
}

type item = {
  item_type : string;
  name : string;
  dmg : int;
}

let bug = { hp = 40; atk = 8; name = "bug" }
let robo_bun = { hp = 80; atk = 10; name = "robo_bun" }
let your_fist = { item_type = "weapon"; name = "fist"; dmg = 5 }

let reset_enemy_health (enemy : enemy) =
  match enemy.name with
  | "bug" -> enemy.hp <- 40
  | "robo_bun" -> enemy.hp <- 80
  | _ -> enemy.hp <- 100

(* default value for empty inventory.. cuz its just your fist *)

let random_mob () =
  let rand = Random.float 1.0 in
  if rand < 0.3 then robo_bun else bug

let print_mob (enemy : enemy) =
  match enemy.name with
  | "bug" -> Constants.bug ()
  | "robo_bun" -> Constants.robo_bun ()
  | _ -> ()

let victory_reward inventory =
  let reward = random_item () in
  match reward with
  | "weapon" -> obtain_ran_weapon inventory
  | "Meat" ->
      let rand_hp = random_int 10 45 in
      let _ = obtain_item inventory rand_hp "Meat" in
      print_endline "You got some Meat!"
  | _ ->
      let _ = obtain_item inventory 0 "key" in
      print_endline "You found a key!"

(* check to see if character is using weapon*)
let is_valid_weapon item =
  let valid_weapons =
    [ "Legendary Sword"; "Ice Wand"; "Stone Sword"; "Wooden Sword" ]
  in
  List.mem item valid_weapons

let break_weapon weapon inventory =
  let _ = remove_item inventory weapon.name in
  Printf.printf "Oh no.. %s has broke! It has served you well.\n" weapon.name

let break_weapon_chance weapon inventory =
  let rand = Random.float 1.0 in
  (* 18% chance for weapon to break *)
  if rand < 0.18 then (
    break_weapon weapon inventory;
    pause_cont ())
  else ()

(* then check to see if its food. If not, use fist attack *)
let is_valid_food item_pos inventory =
  let item_choice = item_slot_name inventory item_pos in
  let item_dmg = item_slot_dmg inventory item_pos in
  match item_choice with
  | "Meat" -> { item_type = "food"; name = item_choice; dmg = item_dmg }
  | "dead-chicken" -> { item_type = "food"; name = item_choice; dmg = item_dmg }
  | "golden-egg" -> { item_type = "special"; name = item_choice; dmg = 0 }
  | _ -> your_fist

let rec player_choice inventory =
  let item_pos = select_item_pos inventory - 1 in
  let item_choice = item_slot_name inventory item_pos in
  let item_dmg = item_slot_dmg inventory item_pos in
  if is_valid_weapon item_choice then
    { item_type = "weapon"; name = item_choice; dmg = item_dmg }
  else if item_pos = 0 then (
    print_endline "\nCurrently your health is:";
    print_health inventory;
    print_endline "Now make your move! \n";
    player_choice inventory)
  else is_valid_food item_pos inventory

let enemy_death (enemy : enemy) inventory =
  Printf.printf "%s has been defeated!\n" enemy.name;
  victory_reward inventory

let enemy_check enemy atk_dmg =
  if enemy.hp <= 0 then Printf.printf "%s suddenly collapses.\n" enemy.name
  else (
    Printf.printf "You lunge, attacking %s and deal %d damage!\n" enemy.name
      atk_dmg;
    Printf.printf "%s still has %d health.\n" enemy.name enemy.hp)

let random_atk min_dmg max_dmg = Rng.random_int min_dmg max_dmg

let player_attack inventory weapon enemy =
  (* random damage amount ranging from 1/2 the attack to full attack *)
  print_mob enemy;
  let atk_dmg = random_atk (weapon.dmg / 2) weapon.dmg in
  enemy.hp <- enemy.hp - atk_dmg;
  enemy_check enemy atk_dmg;

  pause_cont ();

  if is_valid_weapon weapon.name then break_weapon_chance weapon inventory

let enemy_attack enemy inventory =
  let enemy_atk_dmg = random_atk (enemy.atk / 2) enemy.atk in
  Inventory.deduct_health inventory enemy_atk_dmg;
  let new_health = get_health inventory in
  Printf.printf
    "%s attacks you, dealing %d damage!\n You are now at %d health. \n"
    enemy.name enemy_atk_dmg new_health;
  if get_health inventory > 0 then print_health inventory

let heal_player food inventory actual_heal =
  Inventory.add_health inventory actual_heal;
  let _ = remove_item inventory food.name in
  Printf.printf
    "You consume some %s, and feel rejuvenated. You gain %d more HP. You are \
     now at %d health.\n"
    food.name actual_heal (get_health inventory);
  print_health inventory;
  pause_cont ()

let eat_food food inventory =
  let current_health = get_health inventory in
  let max_health = 100 in
  let heal_amt = random_atk (food.dmg / 2) food.dmg in
  let new_health = min (current_health + heal_amt) max_health in
  let actual_heal = new_health - current_health in
  if actual_heal > 0 then heal_player food inventory actual_heal
  else begin
    Printf.printf
      "Your health is already at maximum (100). Choose another option.\n";
    clear_screen ();
    let _ = player_choice inventory in
    ()
  end

let golden_egg inventory enemy =
  print_mob enemy;
  let _ = remove_item inventory "golden-egg" in
  Printf.printf "You throw the golden egg at %s. It does 0 damage.\n" enemy.name

let item_action usable_item enemy inventory =
  match usable_item.item_type with
  | "weapon" -> player_attack inventory usable_item enemy
  | "food" -> eat_food usable_item inventory
  | "special" -> golden_egg inventory enemy
  | _ ->
      print_endline "You can't use that. Choose something else.";
      clear_screen ();
      let _ = player_choice inventory in
      ()

let battle_turn usable_item enemy inventory =
  Utils.clear_screen ();
  item_action usable_item enemy inventory;
  if enemy.hp > 0 then enemy_attack enemy inventory

(* can make ways of death unique *)

let player_death_check inventory =
  if get_health inventory <= 0 then (
    print_endline "You have died. Game over.";
    exit 0)

let rec battle enemy inventory =
  if enemy.hp <= 0 then enemy_death enemy inventory
  else if get_health inventory <= 0 then begin
    print_endline "You have died. Game over.";
    exit 0
  end
  else begin
    let item_choice = player_choice inventory in
    if enemy.hp > 0 then begin
      battle_turn item_choice enemy inventory;
      battle enemy inventory
    end
  end

let battle_prompt inventory =
  Rng.random_battle_intro ();
  pause_cont ();
  clear_screen ();
  let enemy = random_mob () in
  let _ = reset_enemy_health enemy in

  print_mob enemy;
  Printf.printf "You encounter a %s! It has %d health." enemy.name enemy.hp;
  Printf.printf "\n>> Choose something in your inventory to use! \n";
  battle enemy inventory;
  let _ = reset_enemy_health enemy in
  pause_cont ()

let battle_tutorial_prompt enemy =
  print_mob enemy;
  Printf.printf "You encounter a %s! It has %d health.\n" enemy.name enemy.hp;
  pause_cont ();
  clear_screen ();
  print_mob enemy;
  print_msg "tutorial" battle_msgs

let battle_tutorial inventory =
  Rng.random_battle_intro ();
  pause_cont ();
  let enemy = random_mob () in
  let _ = reset_enemy_health enemy in

  battle_tutorial_prompt enemy;
  pause_cont ();
  battle enemy inventory;
  pause_cont ()
