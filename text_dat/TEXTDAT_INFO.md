# TEXT_DAT IDEAS

The purpose of this document is to write down possible ideas for text data, as well as organize thoughts and ideas on how to organize our json file.

Currently, what I have as starter is an inventory json, and a json for the first room (we can do a total of 3-5 rooms maybe?), which is just the start game text and the first set of options that we can give to the player.

The key is the choice that the player can make, and the value is the text that will be printed when the player chooses that choice. We are usng a nested json, so each new option will be it's new dictionary within intro.json.

We also don't have to name it option1 option2, etc, and I think it might be better to keep track of things if we give short, descriptive names. But I'm down for anything!

Also if we don't like this organization idea, its totally cool too! I just put it here as a start c:

## Yojson file documentation

[Documentation](https://ocaml-community.github.io/yojson/yojson/Yojson/index.htm")
[Github Repo]("https://github.com/ocaml-community/yojson")
