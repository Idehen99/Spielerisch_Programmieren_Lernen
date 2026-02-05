extends "res://Scripts/block/code_Block.gd"
@export var side = "Move Right"
func _ready():
	block_type = "move"
	content.visible = false
	$VBoxContainer/Label.text = side
