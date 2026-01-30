extends Area2D

@onready var bounds = $CollisionShape2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var cam = player.get_node("Camera2D")

func _ready():
	var shape = bounds.shape as RectangleShape2D
	var size = shape.extents * 2
	var pos = bounds.global_position - shape.extents

	cam.limit_left   = pos.x
	cam.limit_top    = pos.y
	cam.limit_right  = pos.x + size.x
	cam.limit_bottom = pos.y + size.y
