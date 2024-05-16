open Inventory

let item_doc = Utils.load_json "data/items.json"

let print_item item =
  if item.empty then print_endline "This slot is empty."
  else begin
    print_endline ("\n" ^ item.item ^ ":");
    Utils.print_msg item.item item_doc
  end
