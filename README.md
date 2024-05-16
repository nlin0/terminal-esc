# terminal esc

Nicole Lin (njl55), Jolly Zheng (jz767), Analeah Real (ar979)

## about the game

Welcome to terminal escape! Currently, the features we have implemented include:

- battle system
- chest rng
- weapon system with rarest weapon giving the most damage boost
- choice affects your outcomes
- rng for damage, healing, and item gathering
- text art corresponding to some events
- randomized events/scenarios
- randomized descriptions/encounter text
- radnomized enemies (there's only 2)

After the tutorial, there is a random chance for the following to occur:

- 25% battle (turn based, enemies drop loot)
- 35% chest (needs a key to open, can contain food/weapon, or nothing)
- 40% scenario (5 total scenarios, options that give you rewards, death, or the escape path!)

After encountering all the scenarios, you win the game! Otherwise, do your best to make the right choices and surivive enemy attacks as you roll through each of the 5 scenarios.

The game is currently very difficult to beat, but it is possible if you are lucky and clever. Good luck!

## running the game

There is an error with file paths that we could not fix with debugging or OH.

To run the game, make sure that in `lib/constants.ml`, in the the very first function, we have that

```ocaml
"data/" ^ file_name ^ ".json"
```

is uncommented. So it should look like this:

```ocaml
let run_json file_name =
  (* for running dune exec. Uncomment to use dune exec *)
  "data/" ^ file_name ^ ".json"

(* for testing, uncomment to test. You may have to replace with full file path to data/ first *)

(* "../data/" ^ file_name ^ ".json" *)

```

If the function looks like the above. Then you can run the game with `dune exec bin/main.exe`.

## testing the game

To test the game, make sure that

```ocaml
"../data/" ^ file_name ^ ".json"
```

is uncommented. So it should look like this:

```ocaml
let run_json file_name =
  (* for running dune exec. Uncomment to use dune exec *)
  (* "data/" ^ file_name ^ ".json" *)

(* for testing, uncomment to test. You may have to replace with full file path to data/ first *)

"../data/" ^ file_name ^ ".json"
```

However, you likely have to replace "../data/" with the full path to /data. So it should look something like this:

```ocaml
"/Users/username/cs3110/terminal_esc/data" ^ file_name ^ ".json"
```

From there, you can run `dune test`. There will be the "Fatal Error" warning, but the tests will still run.. It will look something like this:

```
File "lib/dune", line 1, characters 0-162:
1 | (library
2 |  (inline_tests)
3 |  (name terminal_esc)
4 |  (modules utils rpg rng inventory constants battle items)
5 |  (libraries yojson)
6 |  (preprocess
7 |   (pps ppx_inline_test)))
Fatal error: exception Sys_error("../data/constants.json: No such file or directory")
Raised by primitive operation at Stdlib.
...
...
...
...
...
..................................................
Ran: 50 tests in: 0.11 seconds.
OK
```

In case of failure to display test has passed, please dune clear and then dune test again. Please note, to run the game after you test. You HAVE to change modify the function back to it's original form:

```ocaml
let run_json file_name =
  (* for running dune exec. Uncomment to use dune exec *)
  "data/" ^ file_name ^ ".json"

(* for testing, uncomment to test. You may have to replace with full file path to data/ first *)

(* "../data/" ^ file_name ^ ".json" *)
```
