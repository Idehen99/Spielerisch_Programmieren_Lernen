extends Area2D

@onready var bounds = $CollisionShape2D



func _ready():
	if get_tree().get_first_node_in_group("player"):
		var player = get_tree().get_first_node_in_group("player")
		var cam = player.get_node("Camera2D")
		_worked(cam)
	else:
		$Timer.start(3)
		
	


func _on_timer_timeout() -> void:
	if get_tree().get_first_node_in_group("player"):
		var player = get_tree().get_first_node_in_group("player")
		var cam = player.get_node("Camera2D")
		_worked(cam)
	else:
		$Timer.start(1)

func _worked(cam):
	var shape = bounds.shape as RectangleShape2D
	var size = shape.extents * 2
	var pos = bounds.global_position - shape.extents

	cam.limit_left   = pos.x
	cam.limit_top    = pos.y
	cam.limit_right  = pos.x + size.x
	cam.limit_bottom = pos.y + size.y
