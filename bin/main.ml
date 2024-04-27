open Terminal_esc
open Constants
open Utils
open Rpg

let () =
  Constants.logo;
  print_endline "Welcome to Terminal Escape.";
  (* intro *)
  print_endline "\nAre you ready to escape? (yes/no)\n";
  match String.lowercase_ascii (read_line ()) with
  | "yes" -> Terminal_esc.Rpg.beginning ()
  | "no" ->
      print_endline
        "\n\
         You decide to not escape your system's terminal. You survive for 3 \
         days and starve to death since there is no food in your computer. \
         GAME OVER";
      exit 0
  | _ -> exit 0
