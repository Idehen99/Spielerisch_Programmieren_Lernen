class_name CodeBlock
extends Panel
@export var Side = "Move Left"
@export var block_type = "moveLeft"
@export var has_body = false

@onready var content 

func _ready():
	if $VBoxContainer/MarginContainer/Content:
		content = $VBoxContainer/MarginContainer/Content
		content.visible = has_body

func _get_drag_data(_pos):
	var preview = duplicate()
	set_drag_preview(preview)
	return self
