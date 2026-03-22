extends Node2D
@export var type = "wood"
@export var chosen_one = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play(type)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_identify_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and chosen_one:
		$Timer.start(5)


func _on_timer_timeout() -> void:
	Settings.axeUnlocked = true
	if get_tree().get_first_node_in_group("player").has_method("_free_him"):
		get_tree().get_first_node_in_group("player")._free_him()

func _on_identify_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and chosen_one:
		$Timer.stop()


func _on_pick_up_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and chosen_one:
		$PickUpTimer.start(5)


func _on_pick_up_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and chosen_one:
		$PickUpTimer.stop()


func _on_pick_up_timer_timeout() -> void:
	visible = false
