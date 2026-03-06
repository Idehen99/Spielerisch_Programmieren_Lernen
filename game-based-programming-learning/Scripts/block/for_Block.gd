extends "res://Scripts/block/code_Block.gd"

@export var var_name = "i"
@export var from = 0
@export var to = 3

func _ready():
	block_type = "for"
	if $VBoxContainer/MarginContainer/Content:
		content = $VBoxContainer/MarginContainer/Content
		content.visible = true
	$VBoxContainer/HBoxContainer/Label.text = "Wiederhole ( " 

func _can_drop_data(_pos, data):
	modulate = Color(1, 1, 1, 0.7)
	return data is CodeBlock and data != self

func _drop_data(_pos, block):
	modulate = Color(1, 1, 1, 1)
	block.get_parent().remove_child(block)
	content.add_child(block)

func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1, 1, 1, 1)


func _on_line_edit_text_changed(new_text: String) -> void:
	to = new_text.to_int()


func _on_content_child_entered_tree(node: Node) -> void:
	#$VBoxContainer/MarginContainer/Content.size.y = $VBoxContainer/MarginContainer/Content.size.y + node.size.y
	pass

func _on_content_child_exiting_tree(node: Node) -> void:
	pass # Replace with function body.
