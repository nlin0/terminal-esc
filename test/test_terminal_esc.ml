(* Testing Inventory Functions*)
open OUnit2
open Terminal_esc
open Inventory

let inventory = Inventory.create_inventory ()

let inventory_test =
  "checking the basic properties of our inventory"
  >::: [
         ("a trivial test" >:: fun _ -> assert_equal 8 8);
         ( "check first health" >:: fun _ ->
           assert_equal
             (Inventory.get_item_slot inventory 0)
             { health_dmg_max = 100; empty = false; item = "health-bar" } );
         ( "check slot added okay" >:: fun _ ->
           assert_equal
             (Inventory.add_item inventory
                { health_dmg_max = 50; empty = false; item = "bow" })
             "Successful!";
           assert_equal (Inventory.get_next_empty inventory) 2;
           assert_equal false (Inventory.item_slot_empty inventory 1);
           assert_equal (Inventory.item_slot_name inventory 1) "bow";
           assert_equal (Inventory.item_slot_dmg inventory 1) 50 );
         ( "get just health" >:: fun _ ->
           assert_equal (Inventory.get_health inventory) 100 );
         ( "check add item, slots" >:: fun _ ->
           assert_equal
             (Inventory.add_item inventory
                { health_dmg_max = 50; empty = false; item = "sword" })
             "Successful!";
           assert_equal (Inventory.get_next_empty inventory) 3;
           assert_equal
             (Inventory.add_item inventory
                { health_dmg_max = 50; empty = false; item = "knife" })
             "Successful!";
           assert_equal (Inventory.get_next_empty inventory) 4;
           assert_equal
             (Inventory.add_item inventory
                { health_dmg_max = 50; empty = false; item = "gun" })
             "Successful!";
           assert_equal (Inventory.get_next_empty inventory) (-1);
           assert_equal
             (Inventory.add_item inventory
                { health_dmg_max = 50; empty = false; item = "bow" })
             "Full, Unsuccessful" );
         ("a trivial test" >:: fun _ -> assert_equal 8 8);
         ( "remove test where item is in inventory" >:: fun _ ->
           assert_equal (Inventory.remove_item inventory "bow") "Successful";
           assert_equal (Inventory.check_item inventory "bow") false );
         ( "remove test where item is NOT in inventory" >:: fun _ ->
           assert_equal
             (Inventory.remove_item inventory "HEHEAHWHW")
             "Item not found, unsuccessful" );
       ]

(*let item_test (number, dmg_num) = for _ = 1 to number do ignore
  (Inventory.add_item inventory { health_dmg_max = dmg_num; empty = false; item
  = "bow" }) done; let health_check = Inventory.get_health inventory = 100 in
  let item_check = Inventory.item_slot_name inventory number = "bow" in let
  dmg_check = Inventory.item_slot_dmg inventory number = dmg_num in let
  empty_check = Inventory.item_slot_empty inventory number = false in let
  next_slot_check = if number = 5 then Inventory.get_next_empty inventory = -1
  else Inventory.get_next_empty inventory = number in health_check (*item_check
  && dmg_check && empty_check && next_slot_check*)

  let create_other_invent = let random_num = QCheck2.Gen.int_bound 4 in let
  random_dmg = QCheck2.Gen.int_bound 99 in QCheck2.Gen.pair random_num
  random_dmg

  let prop_inventory_test = QCheck_runner.to_ounit2_test (QCheck2.Test.make
  ~count:5 ~name:"rando dmg size" create_other_invent item_test)*)

let tests =
  "Tests for Set"
  >::: [
         inventory_test;
         (*prop_inventory_test; ("a trivial test" >:: fun _ -> assert_equal 8
           8);*)
       ]

let () = run_test_tt_main tests

(* DEBUGGING print_endline ("0" ^ Inventory.item_slot_name inventory 0);
   print_endline ("1" ^ Inventory.item_slot_name inventory 1); print_endline
   ("2" ^ Inventory.item_slot_name inventory 2); print_endline ("3" ^
   Inventory.item_slot_name inventory 3); print_endline ("4" ^
   Inventory.item_slot_name inventory 4);*)
