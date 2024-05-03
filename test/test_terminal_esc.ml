(* Testing Inventory Functions*)
open OUnit2
open Terminal_esc
open Inventory

let nothing_inventory = Inventory.create_inventory ()

let inventory_test =
  "checking the basic properties of our inventory"
  >::: [
         ( "check first health" >:: fun _ ->
           assert_equal
             (Inventory.get_item_slot nothing_inventory 0)
             { health_points = 100; empty = false; item = "health-bar" } );
         ( "check_slot" >:: fun _ ->
           Inventory.add_item nothing_inventory
             { health_points = 50; empty = false; item = "bow" };
           assert_equal (Inventory.get_item_slot nothing_inventory 1).empty true
         );
         ( "get just health" >:: fun _ ->
           assert_equal (Inventory.get_health nothing_inventory) 100 );
       ]

let all = "whole test suite" >::: [ inventory_test ]
let () = run_test_tt_main all
