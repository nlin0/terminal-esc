open Yojson
open Utils

(* NOTE: DELETE THE DUNE FILE IN THE ROOT AFTER WE ARE DONE TESTING *)


let () = 
  (* to_alst and load_json IS IN UTILS. Do we wanna keep them in diff files (?) *)
  let intro = load_json "text_dat/intro.json" in 
  let start = get_nested "start" intro in
  let start_prompt = get_val "instructions" start in
  let () = print_endline "test" in 
  print_endline ( Yojson.Basic.to_string start_prompt)
  

