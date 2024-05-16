open Utils
(** Constants stores the npcs and text arts for the game *)

type art = Yojson.Basic.t

(* json path for running dune exec or testing. change accordingly *)
let run_json file_name =
  (* for running dune exec. Uncomment to use dune exec *)
  "data/" ^ file_name ^ ".json"

  (* for testing, uncomment to test. You may have to replace with full file path
     to data/ first *)
  (* "../data/" ^ file_name ^ ".json" *)

let art_text = load_json (run_json "constants")
let logo () = print_msg "logo" art_text

(* tutorial *)
let chicken () =
  print_endline ("   \\\\ \n" ^ "   (o>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "  _|_")

let happy_chicken () =
  print_endline ("   \\\\ \n" ^ "   (^>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "o _|_")

let dead_chicken () =
  print_endline ("   \\\\ \n" ^ "   (x>\n" ^ "\\_//)\n" ^ " \\_/_)\n" ^ "  _|_")

let chest () = print_msg "chest" art_text
let bug () = print_endline "\\(\")/\n-( )-\n/(_)\\ "
let robo_bun () = print_endline "\n   (\\____/)\n    (_oo_)\n = (        )=\n"
