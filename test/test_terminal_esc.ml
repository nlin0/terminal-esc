open OUnit2
open Terminal_esc
open Inventory
open Utils

(* ---------- INVENTORY TESTS ---------- *)

let item_slot_test _ =
  let inventory1 = Inventory.create_inventory () in
  assert_equal
    (Inventory.get_item_slot inventory1 0)
    { health_dmg_max = 100; empty = false; item = "health-bar" }

let create_item1 _ =
  let inventory11 = Inventory.create_inventory () in
  let _ = Inventory.add_item inventory11 (Inventory.create_item (-25) "bow") in
  assert_equal
    (Inventory.get_item_slot inventory11 1)
    { health_dmg_max = -25; empty = false; item = "bow" }

let create_item2 _ =
  let inventory11 = Inventory.create_inventory () in
  let _ = Inventory.add_item inventory11 (Inventory.create_item 20 "egg") in
  assert_equal
    (Inventory.get_item_slot inventory11 1)
    { health_dmg_max = 20; empty = false; item = "egg" }

let item_slot_test_non_health _ =
  let inventory10 = Inventory.create_inventory () in
  let _ =
    Inventory.add_item inventory10
      { health_dmg_max = -25; empty = false; item = "bow" }
  in
  assert_equal
    (Inventory.get_item_slot inventory10 1)
    { health_dmg_max = -25; empty = false; item = "bow" }

let get_health_test _ =
  let inventory2 = Inventory.create_inventory () in
  assert_equal (Inventory.get_health inventory2) 100

let add_item_test1 _ =
  let inventory3 = Inventory.create_inventory () in

  assert_equal
    (Inventory.add_item inventory3
       { health_dmg_max = -25; empty = false; item = "bow" })
    "Item has been added to Inventory!";
  assert_equal (Inventory.get_next_empty inventory3) 2;
  assert_equal false (Inventory.item_slot_empty inventory3 1);
  assert_equal (Inventory.item_slot_name inventory3 1) "bow";
  assert_equal (Inventory.item_slot_dmg inventory3 1) (-25)

let add_item_test2 _ =
  let inventory4 = Inventory.create_inventory () in

  let _ = Inventory.add_item inventory4 (Inventory.create_item (-25) "bow") in
  assert_equal
    (Inventory.add_item inventory4
       { health_dmg_max = -28; empty = false; item = "sword" })
    "Item has been added to Inventory!";
  assert_equal (Inventory.get_next_empty inventory4) 3;
  assert_equal false (Inventory.item_slot_empty inventory4 2);
  assert_equal (Inventory.item_slot_name inventory4 2) "sword";
  assert_equal (Inventory.item_slot_dmg inventory4 2) (-28)

let add_item_test3 _ =
  let inventory5 = Inventory.create_inventory () in

  let _ = Inventory.add_item inventory5 (Inventory.create_item (-25) "bow") in
  let _ = Inventory.add_item inventory5 (Inventory.create_item (-28) "sword") in
  assert_equal
    (Inventory.add_item inventory5
       { health_dmg_max = -10; empty = false; item = "knife" })
    "Item has been added to Inventory!";
  assert_equal (Inventory.get_next_empty inventory5) 4;
  assert_equal false (Inventory.item_slot_empty inventory5 3);
  assert_equal (Inventory.item_slot_name inventory5 3) "knife";
  assert_equal (Inventory.item_slot_dmg inventory5 3) (-10)

let add_item_test4 _ =
  let inventory6 = Inventory.create_inventory () in

  let _ = Inventory.add_item inventory6 (Inventory.create_item (-25) "bow") in
  let _ = Inventory.add_item inventory6 (Inventory.create_item (-28) "sword") in
  let _ = Inventory.add_item inventory6 (Inventory.create_item (-10) "knife") in
  assert_equal
    (Inventory.add_item inventory6
       { health_dmg_max = -90; empty = false; item = "gun" })
    "Item has been added to Inventory!";
  assert_equal (Inventory.get_next_empty inventory6) (-1);
  assert_equal false (Inventory.item_slot_empty inventory6 4);
  assert_equal (Inventory.item_slot_name inventory6 4) "gun";
  assert_equal (Inventory.item_slot_dmg inventory6 4) (-90)

let add_item_test5 _ =
  let inventory7 = Inventory.create_inventory () in

  let _ = Inventory.add_item inventory7 (Inventory.create_item (-25) "bow") in
  let _ = Inventory.add_item inventory7 (Inventory.create_item (-28) "sword") in
  let _ = Inventory.add_item inventory7 (Inventory.create_item (-10) "knife") in
  let _ = Inventory.add_item inventory7 (Inventory.create_item (-90) "gun") in
  assert_equal
    (Inventory.add_item inventory7
       { health_dmg_max = 80; empty = false; item = "machine" })
    "Your Inventory is Full."

let check_next_empty_valid _ =
  let inventory = Inventory.create_inventory () in

  let _ = Inventory.add_item inventory (Inventory.create_item (-25) "bow") in
  let _ = Inventory.add_item inventory (Inventory.create_item (-28) "sword") in
  let _ = Inventory.add_item inventory (Inventory.create_item (-10) "knife") in

  assert_equal (Inventory.get_next_empty inventory) 4

let check_next_empty_invalid _ =
  let inventory = Inventory.create_inventory () in

  let _ = Inventory.add_item inventory (Inventory.create_item (-25) "bow") in
  let _ = Inventory.add_item inventory (Inventory.create_item (-28) "sword") in
  let _ = Inventory.add_item inventory (Inventory.create_item (-10) "knife") in
  let _ = Inventory.add_item inventory (Inventory.create_item (-90) "gun") in

  assert_equal (Inventory.get_next_empty inventory) (-1)

let test_remove _ =
  let inventory8 = Inventory.create_inventory () in
  assert_equal
    (Inventory.add_item inventory8
       { health_dmg_max = 50; empty = false; item = "bow" })
    "Item has been added to Inventory!";
  assert_equal (Inventory.check_item inventory8 "bow") true;
  assert_equal (Inventory.get_next_empty inventory8) 2;
  assert_equal (Inventory.remove_item inventory8 "bow") "Successful";
  assert_equal (Inventory.check_item inventory8 "bow") false

let test_remove_failure _ =
  let inventory9 = Inventory.create_inventory () in
  assert_equal
    (Inventory.remove_item inventory9 "HEHEAHWHW")
    "Item not found, unsuccessful"

let inventory_test =
  "checking the basic properties of our inventory"
  >::: [
         "check first health" >:: item_slot_test;
         "creating an item test 1 (neg)" >:: create_item1;
         "creating an item test 2 (pos)" >:: create_item2;
         "check slot, nonhealth" >:: item_slot_test_non_health;
         "get just health" >:: get_health_test;
         "check add item, check item, damage, slot, slots1" >:: add_item_test1;
         "check add item, check item, damage, slot, slots2" >:: add_item_test2;
         "check add item, check item, damage, slot, slots3" >:: add_item_test3;
         "check add item, check item, damage, slot, slots4" >:: add_item_test4;
         "check add item, check item, damage, slot, slots5, N/A"
         >:: add_item_test5;
         "check_next_empty_valid" >:: check_next_empty_valid;
         "check_next_empty_invalid" >:: check_next_empty_invalid;
         "remove test where item is in inventory" >:: test_remove;
         "remove test where item is NOT in inventory" >:: test_remove_failure;
       ]

(* ---------- UTILS TESTS ---------- *)

let remove_quotes_test _ =
  assert_equal "hello" (remove_quotes "\"hello\"");
  assert_equal "\"hello" (remove_quotes "\"hello");
  assert_equal "hello\"" (remove_quotes "hello\"")

(* let test_json = load_json "test_json" let test2_json = load_json "test2_json"

   let get_nested_test _ = let nested = get_nested "test2" test_json in
   assert_equal nested test2_json *)

let utils_test =
  "tests for Utils module"
  >::: [
         "utils quotes test" >:: remove_quotes_test;
         (* "utils json load and nested test" >:: get_nested_test; *)
       ]

let tests = "Tests for Set" >::: [ inventory_test; utils_test ]
let () = run_test_tt_main tests
