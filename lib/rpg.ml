open Yojson
open Constants

(* NOTE: DELETE THE DUNE FILE IN THE ROOT AFTER WE ARE DONE TESTING *)


let start () =
  print_endline "todo"

let beginning1 () =
  Constants.happy_chicken;
  print_endline
    "\n\
     The chicken clucks contentedly, rewarding you with a shimmering golden \
     egg. You've gained 1 Gold Egg!\n"

let beginning2 () =
  Constants.happy_chicken;
  print_endline
    "\n\
     The lifeless chicken now serves a new purpose: a solemn gain. You've \
     gained 1 Chicken Breast!\n"

let beginning () =
  let json = Yojson.Basic.from_file "./text_dat/beginning.json" in
  let open Yojson.Basic.Util in
  let body = json |> member "body" |> to_string in
  print_endline body;
  Constants.happy_chicken;
  let rec prompt () =
    print_endline
      "\n\
       What strange fate has intertwined your destiny with that of this \
       mysterious feathered visitor?";
    print_endline
      "Press 1 then Enter to pet the chicken. Alternatively, enter 2 to make a \
       lethal move.\n";
    let input = read_line () in
    match input with
    | "1" ->
        print_endline "You decide to pet. A wise and kind choice.\n";
        beginning1 ()
    | "2" ->
        print_endline
          "You make a lethal move. The consequences of this action will unfold \
           in time.\n";
        beginning2 ()
    | _ ->
        print_endline "That's not an option! Please rethink your choice.\n";
        prompt ()
  in
  prompt ()
