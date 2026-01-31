extends Node2D

@export var tree = "Mahagonay"
@export var limit = 3 #hit total till the tree gives an wood block
@export var recovery = 10 #seconds till the tree recovers from an axe hit
var counter = 0


func _on_timer_timeout() -> void:
	counter = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("axe"):
		if counter == 0:
			$Timer.start(recovery)
		counter+=1
		$AnimatedSprite2D.animation.start()
