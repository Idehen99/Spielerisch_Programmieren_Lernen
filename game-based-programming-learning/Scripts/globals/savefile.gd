extends Node

func get_save_path(slot: int) -> String:
	return "user://savegame_slot_%d.save" % slot

# --- Save komplette Daten ---
func save_all(slot: int, data: Dictionary):
	var file = FileAccess.open(get_save_path(slot), FileAccess.WRITE)
	if file:
		file.store_var(data)
		file.close()

# --- Load komplette Daten ---
func load_all(slot: int) -> Dictionary:
	var path = get_save_path(slot)
	if not FileAccess.file_exists(path):
		return {}
	var file = FileAccess.open(path, FileAccess.READ)
	var data = file.get_var()
	file.close()
	return data

# --- Einzelne Variable speichern ---
func save_variable(slot: int, key: String, value):
	var data = load_all(slot)
	data[key] = value
	save_all(slot, data)

# --- Einzelne Variable laden ---
func load_variable(slot: int, key: String, default_value = null):
	var data = load_all(slot)
	return data.get(key, default_value)
