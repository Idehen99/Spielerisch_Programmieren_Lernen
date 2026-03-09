extends CanvasLayer
@onready var repeat = preload("res://Scenes/Interface/blocks/for_Block.tscn")
var decide = preload("res://Scenes/Interface/blocks/if_Block.tscn")
var stop = preload("res://Scenes/Interface/blocks/return_Block.tscn")
var left = preload("res://Scenes/Interface/blocks/move_left_Block.tscn")
var right = preload("res://Scenes/Interface/blocks/move_right_Block.tscn")
var down = preload("res://Scenes/Interface/blocks/move_down_block.tscn")
var up = preload("res://Scenes/Interface/blocks/move_up_block.tscn")
var Vari = preload("res://Scenes/Interface/blocks/var_Block.tscn")
@export var specialName = "Prototyp"
@export var boolName = "True"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _create(block):
	var block2 = block.instantiate()
	block2.position = $Blocks.position
	block2.scale = Vector2(2,2)
	add_child(block2)
	return block2


func _on_for_pressed() -> void:
	_create(repeat)


func _on_if_pressed() -> void:
	_create(decide)


func _on_return_pressed() -> void:
	_create(stop)


func _on_left_pressed() -> void:
	_create(left)


func _on_right_pressed() -> void:
	_create(right)


func _on_down_pressed() -> void:
	_create(down)


func _on_up_pressed() -> void:
	_create(up)


func _on_var_input_pressed() -> void:
	_create(Vari)

enum VarModus { INPUT, OBJECT }
func _on_var_object_pressed() -> void:
	var aria = _create(Vari)
	aria.special = true
	aria.sensor_name = specialName
	aria.add_to_group("objectBool")
	aria.change_type()
	


func _on_var_true_pressed() -> void:
	var aria = _create(Vari)
	aria.special = true
	aria.sensor_name = boolName
	aria.change_sensor_state(true)
	aria.change_type()
