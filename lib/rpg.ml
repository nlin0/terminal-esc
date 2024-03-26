open Yojson

(* NOTE: DELETE THE DUNE FILE IN THE ROOT AFTER WE ARE DONE TESTING *)

(* let () = (* to_alst and load_json IS IN UTILS. Do we wanna keep them in diff
   files (?) *) let intro = load_json "text_dat/intro.json" in let start =
   get_nested "start" intro in let start_prompt = get_val "instructions" start
   in let () = print_endline "test" in print_endline (Yojson.Basic.to_string
   start_prompt)

   (* use dune utop to test... this prints above the utop interface for some
   reason though ;-; *) *)
open Constants

let beginning () =
  let json = Yojson.Basic.from_file "./text_dat/beginning.json" in
  let open Yojson.Basic.Util in
  let body = json |> member "body" |> to_string in
  print_endline body;
  print_endline Constants.chicken;
  let rec prompt () =
    print_endline
      "\n\
       What strange fate has intertwined your destiny with that of this \
       mysterious feathered visitor?";
    print_endline
      "Press the space bar then Enter to roll the dice. Roll less than 5 to \
       pet, or 5 and above to make a lethal move.\n";
    let input = read_line () in
    if input = " " then
      match Random.int 10 + 1 with
      | n when n < 5 ->
          print_endline "You decide to pet. A wise and kind choice."
      | _ ->
          print_endline
            "You make a lethal move. The consequences of this action will \
             unfold in time."
    else (
      print_endline "Please press the space bar then Enter to roll the dice.";
      prompt ())
  in
  prompt ()
