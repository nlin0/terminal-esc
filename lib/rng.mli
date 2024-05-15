open Yojson.Safe

open Utils
(** RNG Functions *)

val chest_msgs : (string * json) list
(** Load the JSON files for chest messages and battle messages *)

val battle_msgs : (string * json) list

val obtain_item : Inventory.inventory_item array -> int -> string -> unit
(** [obtain_item inventory hp item_str] Obtain an item and add it to the
    inventory *)

(*[random_item_helper] returns the item from chest*)
val random_item_helper : float -> string

(*[random_item] returns random item from chest*)
val random_item : unit -> string

(*[random_int num1 num2] generate a random integer within the specified range*)
val random_int : int -> int -> int

(*[random_item_helper] returns the name of weapon*)
val random_weapon_helper : float -> string

(*[random_item] returns random weapon name*)
val random_weapon : unit -> string

(*[obtain_weapon inventory weapon] gets weapon and adds it to inventory*)
val obtain_weapon : Inventory.inventory_item array -> string -> unit

(*[obtain_weapon_drop weapon inventory] obtain a weapon drop after battle and
  add to inventory*)
val obtain_weapon_drop : string -> Inventory.inventory_item array -> unit

(*[obtain_ran_weapon inventory] obtain a randomly generated weapon and add it to
  the inventory*)
val obtain_ran_weapon : Inventory.inventory_item array -> unit

(*[random_chest_intro () generate a random introduction message for a chest] *)
val random_chest_intro : unit -> unit

(*[chest_helper num] returns the item of chest*)
val chest_helper : float -> string

(*[random_chest_item () generate a random item type for a chest]*)
val random_chest_item : unit -> string

(*[open_chest inventory] open a chest and add its contents to the inventory*)
val open_chest : Inventory.inventory_item array -> unit

(*[chest_prompt inventory] prompt the player to open a chest and handle the
  choice*)
val chest_prompt : Inventory.inventory_item array -> unit
