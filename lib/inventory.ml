(** Inventory is the module that has all the inventory functionalities  *)

open Utils

type item = {
  name : string;
  quantity : int;
  condition : string;
}

