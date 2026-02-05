class_name CodeBlock
extends Panel
@export var Side = "Move Left"
@export var block_type = "moveLeft"
@export var has_body = false

@onready var content = $VBoxContainer/MarginContainer/Content

func _ready():
	content.visible = has_body

func _get_drag_data(_pos):
	var preview = duplicate()
	set_drag_preview(preview)
	return self
