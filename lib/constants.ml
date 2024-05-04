open Utils
(** Constants stores the npcs and text arts for the game *)

type art = Yojson.Basic.t

let text_art = load_json "../data/constants.json"

let logo () = print_msg "logo" text_art

let chicken () =
  print_endline ("   \\\\ \n" ^ "   (o>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "  _|_")

let happy_chicken () =
  print_endline ("   \\\\ \n" ^ "   (^>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "o _|_")

let dead_chicken () =
  print_endline ("   \\\\ \n" ^ "   (x>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "  _|_")

(*room 3*)
let smile_whale () =
  print_endline
    ("           __)\\_  \n" ^ "      (\\_.-'    a`-.\n"
   ^ " jgs  (/~~````(/~^^`")
