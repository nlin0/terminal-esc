open Utils
(** Constants stores the npcs and text arts for the game *)

type art = Yojson.Basic.t

(* json path for running dune exec or testing. change accordingly *)
let run_json file_name =
  (* for running dune exec. Uncomment to use dune exec *)
  (* "data/" ^ file_name ^ ".json" *)

  (* for testing, uncomment to test *)
  "/Users/nicolelin/cs3110/terminal_esc/data/" ^ file_name ^ ".json"

let text_art = load_json (run_json "constants")
let logo () = print_msg "logo" text_art

(* tutorial *)
let chicken () =
  print_endline ("   \\\\ \n" ^ "   (o>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "  _|_")

let happy_chicken () =
  print_endline ("   \\\\ \n" ^ "   (^>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "o _|_")

let dead_chicken () =
  print_endline ("   \\\\ \n" ^ "   (x>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "  _|_")

(* scene 1 *)

let dolphin () =
  print_endline "                   __) \\_  ";
  print_endline "       ( \\ _ . - '       o ` - .";
  print_endline "       ( / ~ ~ ` ` ` `( / ~^^`"

let waves () =
  print_endline "    ._      ._      ._      ._";
  print_endline "_.-._)`\\_.-._)`\\_.-._)`\\_.-._)`\\_.-_"

let smile_whale () =
  print_endline
    ("           __)\\_  \n" ^ "      (\\_.-'    a`-.\n"
   ^ " jgs  (/~~````(/~^^`")

let chest () = print_msg "chest" text_art
