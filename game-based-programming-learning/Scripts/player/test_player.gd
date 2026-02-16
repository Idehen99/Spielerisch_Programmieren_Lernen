extends CharacterBody2D 

@export var step_size = 16.0 #weil TileMap = 16x16 pixel

func _ready() -> void:
	match Settings.Gender:
		"Male":
			$CollisionShape2D/FemaleSprite2D.visible=false
			$CollisionShape2D/MaleSprite2d.visible=true
		"Female":
			$CollisionShape2D/FemaleSprite2D.visible=true
			$CollisionShape2D/MaleSprite2d.visible=false

func move_step(direction: Vector2):
	# Wir erstellen einen Tween für eine flüssige Bewegung
	# Wenn du es sofort "beamen" willst, nutze: global_position += direction * step_size
	var tween = create_tween()
	var target_pos = global_position + (direction * step_size)
	
	# Bewegt den Player in 0.3 Sekunden zum Ziel
	tween.tween_property(self, "global_position", target_pos, 0.3).set_trans(Tween.TRANS_SINE)
	
	# Wir warten, bis die Animation fertig ist
	await tween.finished

func jump_animation():
	var tween = create_tween()
	# Kleiner Hüpfer-Effekt
	tween.tween_property(self, "position:y", position.y - 30, 0.15).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y", position.y, 0.15).set_ease(Tween.EASE_IN)
	await tween.finished
