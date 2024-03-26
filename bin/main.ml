open Terminal_esc.Constants
open Terminal_esc.Rpg

let () =
  print_endline Terminal_esc.Constants.logo;
  print_endline "Welcome to Terminal Escape.";
  print_endline
    "You are trapped in the depths of your system's terminal. Your job is to \
     escape, but it will not be easy. The labryinth that is your system's \
     terminal is filled with strange bugs, strange creatures, and dangerous \
     traps. Throughout your journey you will find weapons and goods to arm \
     yourself. However, even armed, you are not safe from the choices you \
     make.";
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
