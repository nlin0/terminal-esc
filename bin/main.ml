open Terminal_esc.Constants
open Terminal_esc.Rpg

let () =
  print_endline Terminal_esc.Constants.logo;
  print_endline
    "Welcome to Terminal Escape.\n\
    \ You are trapped in the depths of your system's terminal. Your job is to \
     escape, but it will not be easy. The labryinth that is your system's \
     terminal is filled with scary bugs, viruses and dangerous traps. \
     Throughout these tunnels you will find weapons and goods to arm yourself.\n\
    \ However, even armed, you are not safe from the choices you make.";
  print_endline "\n Are you ready to escape?";
  match String.lowercase_ascii (read_line ()) with
  | "yes" -> Terminal_esc.Rpg.beginning ()
  | "no" ->
      print_endline
        "You decide to not escape your system's terminal. You survive for 3 \
         days and starve to death since there is no food in your computer. \
         GAME OVER"
  | _ -> exit 0
