extends "res://Scripts/block/code_Block.gd"
@export var side = "Move Right"
func _ready():
	block_type = "move"
	if $VBoxContainer/MarginContainer/Content:
		content = $VBoxContainer/MarginContainer/Content
		content.visible = false
	$VBoxContainer/Label.text = side
