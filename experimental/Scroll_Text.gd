# Tried to create vertically scrolling text for credits page an accidentally discovered this thing. Think it may come in handy later.
# This has been hidden as it doesn't really belong here, but there isn't a good place to put it at the moment.

extends Label

var example_text = "This is an interesting way to display text\nWould probably look cool on the CRT monitor."

func _ready() -> void:
	scroll_text(example_text)

func scroll_text(input_text:String) -> void:
	visible_characters = 0
	text = input_text
	
	for scroll_text in text.length():
		visible_characters += 1
		await get_tree().create_timer(0.1).timeout
