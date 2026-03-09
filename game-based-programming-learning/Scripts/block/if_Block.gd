extends "res://Scripts/block/code_Block.gd"

# --- Variablen für den Builder ---
var condition_left = ""
var condition_op = "=="
var condition_right = ""

# --- Referenzen auf die UI-Nodes ---
@onready var slot_l = $VBoxContainer/HBoxContainer/SlotLeft
@onready var slot_r = $VBoxContainer/HBoxContainer/SlotRight

@onready var content_true = $VBoxContainer/MarginContainer_True/ContentTrue
@onready var content_false = $VBoxContainer/MarginContainer_False/ContentFalse

@onready var label_if = $VBoxContainer/HBoxContainer/Label
@onready var label_then = $VBoxContainer/HBoxContainer/Label2

func _ready():
	block_type = "if"
	
	# UI Texte setzen
	label_if.text = "Wenn ("
	label_then.text = ") ist."
	
	# Initialisierung der Container-Sichtbarkeit
	if content_true: content_true.visible = true
	if content_false: content_false.visible = true

# --- Daten-Extraktion ---

## Diese Funktion wird vom Builder aufgerufen, BEVOR er das 'program'-Dictionary baut.
# In deinem if-Block Script:

func update_slot_values():
	condition_left = false
	condition_right = true
	
	if slot_l.get_child_count() > 0:
		var block = slot_l.get_child(0)
		if block.has_method("get_block_value"):
			condition_left = block.get_block_value()
	if slot_r.get_child_count() > 0:
		var block = slot_r.get_child(0)
		if block.has_method("get_block_value"):
			condition_right = block.get_block_value()

# --- Drag & Drop Logik ---

func _can_drop_data(_pos, data):
	# Wir akzeptieren nur Objekte vom Typ CodeBlock
	return data is CodeBlock and data != self

func _drop_data(_pos, block):
	var mouse_pos = get_global_mouse_position()
	print(block.block_type, "sus")
	# 1. Check: Soll der Block in den linken Slot?
	if slot_l.get_global_rect().has_point(mouse_pos) and block.block_type == "var":
		_add_to_slot(slot_l, block)
	
	# 2. Check: Soll der Block in den rechten Slot?
	elif slot_r.get_global_rect().has_point(mouse_pos) and block.block_type == "var":
		_add_to_slot(slot_r, block)
	
	# 3. Check: In die Inhalts-VBoxen (True/False)
	else:
		# Wir finden heraus, ob die Maus über oder unter dem "Sonst"-Label ist
		var label_else_y = $VBoxContainer/Label_Else.global_position.y
		
		if block.get_parent():
			block.get_parent().remove_child(block)
			
		if mouse_pos.y < label_else_y:
			content_true.add_child(block)
		else:
			content_false.add_child(block)
	
	# Nach jedem Drop die Werte intern synchronisieren
	update_slot_values()

## Hilfsfunktion zum sauberen Einsortieren in die Slots
func _add_to_slot(slot, block):
	# Falls schon ein Block drin ist, brechen wir ab (oder du löschst das alte Kind)
	if slot.get_child_count() > 0:
		return
	
	if block.get_parent():
		block.get_parent().remove_child(block)
		
	slot.add_child(block)
	
	# Optische Anpassung: Der Block soll den Slot ausfüllen
	block.custom_minimum_size = Vector2(60, 30) # Beispielwerte
	block.size_flags_horizontal = Control.SIZE_EXPAND_FILL

# --- Signal-Verarbeitung ---

func _on_option_button_item_selected(index: int) -> void:
	var btn = $VBoxContainer/HBoxContainer/OptionButton
	var text = btn.get_item_text(index)
	
	match text:
		"Gleich", "==":
			condition_op = "=="
		"Nicht_Gleich", "!=":
			condition_op = "!="
		"Größer_als", ">":
			condition_op = ">"
		"Kleiner_als", "<":
			condition_op = "<"
		_:
			condition_op = "=="
