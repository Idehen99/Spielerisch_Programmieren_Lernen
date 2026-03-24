extends Node2D

var follow = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if follow and get_tree().get_first_node_in_group("player"):
		position = get_tree().get_first_node_in_group("player").position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		follow = true
	if body.is_in_group("cornsack") and get_tree().get_first_node_in_group("codeLevelPremium"):
		get_tree().get_first_node_in_group("codeLevelPremium")._finished_level()
