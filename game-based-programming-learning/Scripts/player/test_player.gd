extends CharacterBody2D # CharacterBody ist gut für Kollision, wir nutzen aber kein velocity

@export var step_size := 64.0 # Die Pixel-Breite eines Feldes

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
