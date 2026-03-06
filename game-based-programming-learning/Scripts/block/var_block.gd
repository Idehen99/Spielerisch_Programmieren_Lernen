extends "res://Scripts/block/code_Block.gd"

enum VarModus { INPUT, OBJECT }
@export var modus: VarModus = VarModus.INPUT
@export var sensor_name: String = "sensor1" # Name für die Area2D-Erkennung

var current_value = 0 # Für Zahlen
var sensor_state = false # Für Objekte (True/False)

@onready var line_edit = $HBoxContainer/LineEdit # Nur sichtbar im Input-Modus
@onready var Baki =$HBoxContainer/Baki
func _ready():
	block_type = "var"
	if modus == VarModus.OBJECT:
		line_edit.visible = false
		Baki.visible = true
		Baki.text = sensor_name
	else:
		line_edit.visible = true
		Baki.visible = false
		

# Diese Funktion wird vom Builder aufgerufen
func get_block_value():
	if modus == VarModus.INPUT:
		return line_edit.text.to_int()
	else:
		# Gibt den Namen zurück, damit der Runner in vars[sensor_name] nachsehen kann
		return sensor_name

func _on_line_edit_text_changed(new_text):
	current_value = new_text.to_int()
	
