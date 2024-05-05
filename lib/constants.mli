(** Constants stores the npcs and text arts for the game *)

type art

val logo : unit -> unit
(** [logo ()] prints the game logo using the loaded text art *)

val chicken : unit -> unit
(** [chicken ()] prints a chicken text art *)

val happy_chicken : unit -> unit
(** [happy_chicken ()] prints a happy chicken text art *)

val dead_chicken : unit -> unit
(** [dead_chicken ()] prints a dead chicken text art *)

val smile_whale : unit -> unit
(** [smile_whale ()] prints a smile whale text art *)

val chest : unit -> unit
