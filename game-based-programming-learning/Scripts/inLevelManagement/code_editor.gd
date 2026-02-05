extends Panel
class_name CodeEditor

@onready var code_container = $ScrollContainer/codeContainer

func add_block(block):
	code_container.add_child(block)

func _can_drop_data(_pos, data):
	return data is CodeBlock


func _drop_data(_pos, block):
	if block.get_parent():
		block.get_parent().remove_child(block)
		code_container.add_child(block)
