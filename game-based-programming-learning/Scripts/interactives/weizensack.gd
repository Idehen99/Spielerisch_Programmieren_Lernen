extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var groupies = get_tree().get_nodes_in_group("objectBool")
		for groupie in groupies:
			groupie.change_sensor_state(true)
		$Timer.start(5)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		var groupies = get_tree().get_nodes_in_group("objectBool")
		for groupie in groupies:
			groupie.change_sensor_state(false)
		$Timer.stop()

func _on_timer_timeout() -> void:
	visible = false
	Settings.weizensack = true
	if get_tree().get_first_node_in_group("codelevel"):
		get_tree().get_first_node_in_group("codelevel")._finished_level()
