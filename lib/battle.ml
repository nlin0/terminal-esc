open Utils
open Inventory
open Rng
open Random

let () = Random.self_init ()
let constants = load_json (Constants.run_json "constants")

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

(* default value for empty inventory.. cuz its just your fist *)
let your_fist = { item_type = "weapon"; name = "your fist"; dmg = 5 }

let random_mob () =
  let rand = Random.float 1.0 in
  if rand < 0.3 then robo_bun else bug

(* check to see if character is using weapon*)
let is_valid_weapon item =
  let valid_weapons =
    [ "Legendary Sword"; "Ice Wand"; "Stone Sword"; "Wooden Sword" ]
  in
  List.mem item valid_weapons

(* then check to see if its food. If not, use fist attack *)
let is_valid_food item_pos inventory =
  let item_choice = item_slot_name inventory item_pos in
  let item_dmg = item_slot_dmg inventory item_pos in
  match item_choice with
  | "Meat" -> { item_type = "food"; name = item_choice; dmg = item_dmg }
  | "Chicken Breast" ->
      { item_type = "food"; name = item_choice; dmg = item_dmg }
  | "Golden Egg" -> { item_type = "special"; name = item_choice; dmg = 0 }
  | _ -> your_fist

let player_choice inventory =
  let item_pos = select_item_pos inventory in
  let item_choice = item_slot_name inventory item_pos in
  let item_dmg = item_slot_dmg inventory item_pos in
  if is_valid_weapon item_choice then
    { item_type = "weapon"; name = item_choice; dmg = item_dmg }
  else is_valid_food item_pos inventory

let player_attack weapon enemy =
  (* random damage amount ranging from 1/2 the attack to full attack *)
  let atk_dmg = Rng.random_int (weapon.dmg - (weapon.dmg / 2)) weapon.dmg in
  enemy.hp <- enemy.hp - atk_dmg;
  Printf.printf "You lunge, attacking %s and deal %d damage!\n" enemy.name
    atk_dmg

let enemy_attack enemy inventory =
  let enemy_atk_dmg = Rng.random_int (enemy.atk - (enemy.atk / 2)) enemy.atk in
  Inventory.deduct_health inventory enemy_atk_dmg;
  let new_health = get_health inventory in
  Printf.printf
    "%s attacks you, dealing %d damage!\n You are now at %d health. \n"
    enemy.name enemy_atk_dmg new_health

let eat_food food inventory =
  let heal_amt = Rng.random_int (food.dmg - (food.dmg / 2)) food.dmg in
  Inventory.add_health inventory heal_amt;
  let new_health = get_health inventory in
  Printf.printf
    "You consume some %s, and feel rejuvinated. You gain %d more hp. You are \
     now at %d health. \n"
    food.name heal_amt new_health

let golden_egg inventory =
  let egg = remove_item inventory "Golden Egg" in
  Printf.printf "You throw the %s. It does 0 damage." egg

let item_action usable_item enemy inventory =
  match usable_item.item_type with
  | "weapon" -> player_attack usable_item enemy
  | "food" -> eat_food usable_item inventory
  | "special" -> golden_egg inventory
  | _ ->
      print_endline "You can't use that. Choose something else.";
      clear_screen ();
      let _ = player_choice inventory in
      ()

let battle_turn usable_item enemy inventory =
  Utils.clear_screen ();
  print_health inventory;
  item_action usable_item enemy inventory

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

(* can make ways of death unique *)
let rec battle enemy inventory =
  if get_health inventory <= 0 then print_endline "You have died"
  else if enemy.hp <= 0 then print_endline "The enemy has been defeated!"
  else begin
    let item_choice = player_choice inventory in
    battle_turn item_choice enemy inventory;
    if enemy.hp > 0 then begin
      battle_turn item_choice enemy inventory;
      enemy_attack enemy inventory
    end
    else print_endline "The enemy has been defeated!"
  end
