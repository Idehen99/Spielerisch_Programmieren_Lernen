extends Node2D

var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if get_tree().get_first_node_in_group("codelevel") and counter< 1:
		await get_tree().get_first_node_in_group("codelevel").finished_level(5)
		$"../Texttrigger".monitoring = false
		$"../Texttrigger".monitoring = true
		counter+=1
	Settings.fire = false
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and counter < 1:
		$Timer.start(5)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Timer.stop()
