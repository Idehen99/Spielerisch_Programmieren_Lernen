extends Area2D

@export var text = "Hallo Spieler. Willkommen in meinem Dorf. Pass gut auf."
@export var ab_wann = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.levelFinished != ab_wann:
		monitoring = false
	else:
		monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().get_first_node_in_group("textbox").start_dialog(text)
