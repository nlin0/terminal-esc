(** The Utils module includes simple functions that can be used across all of
    our ml files. *)

type json
(** json is a JSON file containing JSON values *)

val remove_quotes : string -> string
(** [remove_quotes str] removes leading and trailing quotes from [str]. *)

val clear_screen : unit -> unit
(** [clear_screen ()] clears the terminal screen. *)

val to_alst : [> `Assoc of 'a list ] -> 'a list

val load_json : string -> (string * json) list
(** [load_json filepath] loads a JSON file and converts it to an association
    list. *)

val print_msg : string -> (string * json) list -> unit
(** [print_msg key alst] prints out the value associated with [key] from the
    association list [alst]. *)

val get_nested : string -> (string * json) list -> (string * json) list
(** [get_nested key alst] gets the child association list at [key] from the
    parent association list [alst]. *)

val print_nested_msg : string -> string -> (string * json) list -> unit
(** [print_nested_msg parent_key child_key alst] prints out the [child_key] of
    the child association list at [parent_key] in [alst]. *)
