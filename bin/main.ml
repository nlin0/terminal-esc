open Terminal_esc
open Utils

(* load nested json *)
let intro = load_json (Constants.run_json "intro")

let introduction () =
  (* print intro message from nested 'start' json *)
  let first_opt = get_nested "option1" intro in
  print_msg "prompt" first_opt;

  match String.lowercase_ascii (read_line ()) with
  | "yes" ->
      clear_screen ();
      Terminal_esc.Rpg.start ()
  | "no" ->
      clear_screen ();
      print_msg "no" first_opt;
      exit 0
  | _ -> exit 0

let () =
  let start_msgs = get_nested "start" intro in
  (* grab 'start' json from nested json*)
  Constants.logo ();
  print_msg "greet_msg" start_msgs;
  introduction ()
