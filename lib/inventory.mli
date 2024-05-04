(** Inventory is the module that has all the inventory functionalities *)

type inventory_item = {
  mutable health_dmg_max : int;
  mutable empty : bool;
  mutable item : string;
}
(** The type of inventory items *)

type t

val inventory : inventory_item array ref

val get_item_slot : inventory_item array -> int -> inventory_item
(** [get_item_slot inventory num] retrieves the item at the given slot in the
    inventory *)

val create_inventory : unit -> inventory_item array
(** [create_inventory ()] creates an empty inventory with 3 slots *)

val get_next_empty : inventory_item array -> int
(** [get_next_empty inventory] finds the next empty slot in the inventory *)

val item_slot_name : inventory_item array -> int -> string
(** [item_slot_name inventory num] retrieves the name of the item at the given
    slot in the inventory *)

val item_slot_dmg : inventory_item array -> int -> int
(** [item_slot_dmg inventory num] retrieves the maximum health damage of the
    item at the given slot in the inventory *)

val item_slot_empty : inventory_item array -> int -> bool
(** [item_slot_empty inventory num] checks if the item slot at the given index
    is empty *)

val add_item : inventory_item array -> inventory_item -> string
(** [add_item inventory new_item] attempts to add a new item to the inventory *)

val remove_item : inventory_item array -> string -> string
(** [remove_item inventory item_name] removes an item from the inventory by its
    name *)

val get_health : inventory_item array -> int
(** [get_health inventory] retrieves the health damage of the first item in the
    inventory *)

val print_health : inventory_item array -> unit
(** [print_health inventory] prints the health status of the inventory *)

val check_item : string -> bool
val check_key : unit -> bool
