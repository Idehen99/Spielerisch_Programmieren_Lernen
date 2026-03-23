extends Node2D
@export var mcHomeSmoke = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mcHomeSmoke and Settings.fire:
		$AnimatedSprite2D.play("fireLit")
	else:
		$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
