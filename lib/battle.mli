(** Battle module is responsible for handling enemy and player interactions
    during battles *)

(** {2 Types} *)

type enemy = {
  mutable hp : int;
  mutable atk : int;
  name : string;
}
(** [enemy] is the type representing an enemy with mutable health and attack
    stats, and a name *)

type item = {
  item_type : string;
  name : string;
  dmg : int;
}
(** [item] is the type representing an item with a type, name, and damage value *)

val bug : enemy
(** [bug] is a predefined enemy of type bug with specific stats *)

val robo_bun : enemy
(** [robo_bun] is a predefined enemy of type robo_bun with specific stats *)

val your_fist : item
(** [your_fist] is the default weapon representing the player's fist *)

val reset_enemy_health : enemy -> unit
(** [reset_enemy_health enemy] resets the health of the given [enemy] to its
    default value *)

val random_mob : unit -> enemy
(** [random_mob] returns a random enemy, either [bug] or [robo_bun] *)

val print_mob : enemy -> unit
(** [print_mob enemy] prints the appearance of the given [enemy] *)

val victory_reward : Inventory.inventory_item array -> unit
(** [victory_reward inventory] awards the player with a random item upon
    defeating an enemy, updating the [inventory] *)

val is_valid_weapon : string -> bool
(** [is_valid_weapon item_name] checks if the given [item_name] is a valid
    weapon *)

val break_weapon : item -> Inventory.inventory_item array -> unit
(** [break_weapon weapon inventory] breaks the given [weapon] and removes it
    from the [inventory] *)

val break_weapon_chance : item -> Inventory.inventory_item array -> unit
(** [break_weapon_chance weapon inventory] checks if the given [weapon] should
    break after use, and breaks it if necessary *)

val is_valid_food : int -> Inventory.inventory_item array -> item
(** [is_valid_food item_pos inventory] determines if the item in the specified
    [item_pos] of the [inventory] is valid food, and returns the corresponding
    item *)

val player_choice : Inventory.inventory_item array -> item
(** [player_choice inventory] prompts the player to choose an item from the
    [inventory] and returns the chosen item *)

val enemy_death : enemy -> Inventory.inventory_item array -> unit
(** [enemy_death enemy inventory] handles the death of the given [enemy],
    providing rewards to the player and updating the [inventory] *)

val enemy_check : enemy -> int -> unit
(** [enemy_check enemy atk_dmg] checks the [enemy]'s health and prints the
    result of the player's attack with [atk_dmg] damage *)

val random_atk : int -> int -> int
(** [random_atk min_dmg max_dmg] generates a random attack damage within the
    specified range [min_dmg] to [max_dmg] *)

val player_attack : Inventory.inventory_item array -> item -> enemy -> unit
(** [player_attack inventory weapon enemy] executes the player's attack on the
    [enemy] using the given [weapon] and updates the [inventory] *)

val enemy_attack : enemy -> Inventory.inventory_item array -> unit
(** [enemy_attack enemy inventory] executes the [enemy]'s attack on the player
    and updates the [inventory] *)

val heal_player : item -> Inventory.inventory_item array -> int -> unit
(** [heal_player food inventory actual_heal] heals the player using the
    specified [food] item, applying [actual_heal] amount of healing and updating
    the [inventory] *)

val eat_food : item -> Inventory.inventory_item array -> unit
(** [eat_food food inventory] allows the player to consume a [food] item,
    healing themselves and updating the [inventory] *)

val golden_egg : Inventory.inventory_item array -> enemy -> unit
(** [golden_egg inventory enemy] handles the special action of using a golden
    egg on the [enemy] and updates the [inventory] *)

val item_action : item -> enemy -> Inventory.inventory_item array -> unit
(** [item_action usable_item enemy inventory] performs the appropriate action
    based on the type of the [usable_item] and updates the [inventory] *)

val battle_turn : item -> enemy -> Inventory.inventory_item array -> unit
(** [battle_turn usable_item enemy inventory] executes a single turn of battle,
    including player and [enemy] actions, and updates the [inventory] *)

val player_death_check : Inventory.inventory_item array -> unit
(** [player_death_check inventory] checks if the player's health has dropped to
    zero or below, ending the game if necessary, and updating the [inventory] *)

val battle : enemy -> Inventory.inventory_item array -> unit
(** [battle enemy inventory] initiates and handles the entire battle sequence
    between the player and an [enemy], updating the [inventory] *)

val battle_prompt : Inventory.inventory_item array -> unit
(** [battle_prompt inventory] prompts the player for a battle, setting up the
    enemy encounter and updating the [inventory] *)

val battle_tutorial_prompt : enemy -> unit
(** [battle_tutorial_prompt enemy] displays the tutorial prompt for battling an
    [enemy] *)

val battle_tutorial : Inventory.inventory_item array -> unit
(** [battle_tutorial inventory] initiates the battle tutorial sequence, updating
    the [inventory] *)
