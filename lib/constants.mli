(** Constants stores the npcs and text arts for the game *)

type art

val run_json : string -> string

val logo : unit -> unit
(** [logo ()] prints the game logo using the loaded text art *)

val chicken : unit -> unit
(** [chicken ()] prints a chicken text art *)

val happy_chicken : unit -> unit
(** [happy_chicken ()] prints a happy chicken text art *)

val dead_chicken : unit -> unit
(** [dead_chicken ()] prints a dead chicken text art *)

val chest : unit -> unit
(** [chest ()] prints a chest text art *)

val bug : unit -> unit
(** [bug ()] prints a bug text art *)

val robo_bun : unit -> unit
(** [robo_bun ()] prints a robot bunny text art *)
