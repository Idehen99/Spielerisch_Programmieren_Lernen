class_name CodeEditor
extends Panel

@onready var code_container = $MarginContainer/ScrollContainer/codeContainer

func _get_drag_data(_pos):
	var preview = duplicate()
	set_drag_preview(preview)
	return self

func add_block(block):
	code_container.add_child(block)

func _can_drop_data(_pos, data):
	return data is CodeBlock


func _drop_data(_pos, block):
	block.get_parent().remove_child(block)
	code_container.add_child(block)
