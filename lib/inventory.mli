open Yojson.Basic

(** Inventory is the module that has all the inventory functionalities *)

(*val constants : (string * Yojson.Basic.json) list*)

(** Load constants from JSON file *)

type inventory_item = {
  mutable health_dmg_max : int;
  mutable empty : bool;
  mutable item : string;
}
(** Type representing an inventory item *)

val size : int
(** [size] is the inventory size *)

(*[get_item_slot inventory num] get the item at a specific slot in the
  inventory*)
val get_item_slot : inventory_item array -> int -> inventory_item

val create_inventory : unit -> inventory_item array
(** [create_inventory] is an empty inventory with 5 slots*)

(*[create_item health_dmg item] returns an item with the inputted health_damage
  and inputted item name*)
val create_item : int -> string -> inventory_item

(*[get_next_empty inventory] returns the next empty slot in the inventory. It
  would return -1 if there is not empty slot left.*)
val get_next_empty : inventory_item array -> int

(*[item_slot_name inventory num] returns the name of the item at the specified
  location*)
val item_slot_name : inventory_item array -> int -> string

(*[item_slot_dmg inventory num] returns the damage of the item at the specified
  location*)
val item_slot_dmg : inventory_item array -> int -> int

(*[item_slot_empty inventory num] returns where the slot is empty at the
  specified location*)
val item_slot_empty : inventory_item array -> int -> bool

(*[add_item inventory new_item] returns a string message of whether the item has
  been added into your inventory.*)
val add_item : inventory_item array -> inventory_item -> string

(*[remove_item inventory item_name] returns a message of whether the item (based
  on item name) has been removed from the inventory.*)
val remove_item : inventory_item array -> string -> string

(*[get_health inventory] returns the number of health currently.*)
val get_health : inventory_item array -> int

(*[add_health inventory num] adds the num health from what the player current
  has.*)
val add_health : inventory_item array -> int -> unit

(*[deduct_health inventory num] removes the num health from what the player
  current has.*)
val deduct_health : inventory_item array -> int -> unit

(*[print_health inventory] prints out the current health and the health bar.*)
val print_health : inventory_item array -> unit

(*[print_inventory inventory] prints out the items in inventory.*)
val print_inventory : inventory_item array -> unit

val check_item : inventory_item array -> string -> bool
(** [check_item inventory target] returns whether or not the inputted string
    item name is inside the inventory or not.*)

(* [check_key inventory ] returns whether or not we have a key in the
   inventory. *)
val check_key : inventory_item array -> bool

(* [select_item_pos inventory] returns the position of the item the player
   player selects items for battling*)
val select_item_pos : inventory_item array -> int
