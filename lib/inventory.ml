(** Inventory is the module that has all the inventory functionalities *)

open Utils

type inventory_item = {
  mutable empty : bool;
  mutable item : string;
}

(** [size] is the inventory size *)
let size = 3

(** [create_inventory] is an empty inventory with 3 slots*)
let create_inventory () =
  Array.init size (fun _ -> {empty = true; item = "none"})

(* todo: account for when empty = false... can't add *)


(* let first_empty slot_lst = 
  match lst with 
  | [] -> failwith "inventory full"
  | h :: t ->  *)



let add_item inventory slot_num new_item =
  inventory.(slot_num).item <- new_item


