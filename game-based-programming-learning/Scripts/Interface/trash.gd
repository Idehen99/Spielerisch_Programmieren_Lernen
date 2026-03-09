extends Panel

func _can_drop_data(_pos, data):
	if data is CodeBlock:
		modulate = Color(1,0.5,0.5) # rot
		return true
	return false


func _drop_data(_pos, data):
	modulate = Color(1,1,1)
	if data is CodeBlock:
		data.queue_free()


func _notification(what):
	if what == NOTIFICATION_DRAG_END:
		modulate = Color(1,1,1)
