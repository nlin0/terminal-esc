(** The Tutorial module provides functions for guiding new players through the
    game. *)

val golden_egg_choice : unit -> unit
(** [golden_egg_choice ()] is a function for handling the player's choice when
    encountering a golden egg. *)

val dead_chicken_choice : unit -> unit
(** [dead_chicken_choice ()] is a function for handling the player's choice when
    encountering a dead chicken. *)

val invalid_choice1 : unit -> unit
(** [invalid_choice1 ()] is a function for handling invalid choices during the
    tutorial. *)

val print_inventory_choice : unit -> unit
(** [print_inventory_choice ()] is a function for displaying the player's
    inventory during the tutorial. *)

val chicken_option : unit -> unit
(** [chicken_option ()] is a function for guiding the player through the initial
    chicken encounter. *)

val print_health_choice : unit -> unit
(** [print_health_choice ()] is a function for displaying the player's health
    during the inventory tutorial. *)

val clear_and_print_inventory : unit -> unit
(** [clear_and_print_inventory ()] is a function for clearing the screen and
    printing the player's inventory. *)

val inventory_option_tutorial : Inventory.inventory_item array -> unit
(** [inventory_option_tutorial inventory] is a function for guiding the player
    through inventory options during the tutorial. *)

val inventory_tutorial : unit -> unit
(** [inventory_tutorial ()] is a function for guiding the player through the
    initial inventory tutorial. *)

val encounter_chest : unit -> unit
(** [encounter_chest ()] is a function representing an encounter with a chest
    event. *)

val encounter_trap : unit -> unit
(** [encounter_trap ()] is a placeholder function for encountering a trap event. *)

val encounter_battle : unit -> unit
(** [encounter_battle ()] is a function representing an encounter with a battle
    event. *)

(** The Tutorial module provides functions for guiding new players through the
    game. *)

val scene_1 : unit -> string
(** [scene_1 ()] is a function representing the first scene in the game. *)

val scene_2 : unit -> string
(** [scene_2 ()] is a function representing the second scene in the game. *)

val scene_3 : unit -> string
(** [scene_3 ()] is a function representing the third scene in the game. *)

val scene_4 : unit -> string
(** [scene_4 ()] is a function representing the fourth scene in the game. *)

val scene_5 : unit -> string
(** [scene_5 ()] is a function representing the fifth scene in the game. *)

val random_scenario : unit -> unit
(** [random_scenario ()] is a function representing a randomly selected
    scenario. *)

val random_event : unit -> unit
(** [random_event ()] is a function representing a randomly selected event. *)

val start : unit -> unit
(** [start ()] is a function to start the game. *)
