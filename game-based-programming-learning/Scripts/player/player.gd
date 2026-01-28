extends CharacterBody2D

enum Modus { IDLE, AXE, RUN, WALK }
enum Direction { UP, DOWN, LEFT, RIGHT }

@export var speed := 100

var modus: Modus = Modus.IDLE
var dir: Direction = Direction.DOWN

var sprite
var direction_str := "Down"
var mode_str := "idle"

var is_busy := false   # blockiert Input bei AXE

func _ready() -> void:
	if !Settings.saveData["new"]:
		$".".global_position = Settings.saveData["player_pos"]
		Settings.Gender = Settings.saveData["gender"]
	if Settings.Gender == "Female":
		sprite = $FemaleSprite
		$MaleSprite.visible = false
	else:
		sprite = $MaleSprite
		$FemaleSprite.visible = false

	# wichtig: Animation-Finished-Signal verbinden
	sprite.animation_finished.connect(_on_animation_finished)


# -------------------------
# INPUT → STATE (Events!)
# -------------------------
func _input(event):
	if event.is_action_pressed("axe") and not is_busy:
		set_modus(Modus.AXE)


func set_modus(new_modus: Modus) -> void:
	if is_busy:
		return

	modus = new_modus

	if modus == Modus.AXE:
		is_busy = true


# -------------------------
# PHYSICS → BEWEGUNG
# -------------------------
@onready var flower_tiles = $"../FlowerTileMap"
@onready var player_node = $"."

func _process(delta):
	flower_tiles.material.set_shader_parameter("player_pos", player_node.global_position)
	flower_tiles.material.set_shader_parameter("tilemap_pos", flower_tiles.global_position)
	if is_busy:
		velocity = Vector2.ZERO
		move_and_slide()
		update_animation()
		return

	var input_vector = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if input_vector != Vector2.ZERO:
		update_direction(input_vector)

		if Input.is_action_pressed("run"):
			set_modus(Modus.RUN)
			velocity = input_vector.normalized() * speed * 1.5
		else:
			set_modus(Modus.WALK)
			velocity = input_vector.normalized() * speed
	else:
		set_modus(Modus.IDLE)
		velocity = Vector2.ZERO

	move_and_slide()
	update_animation()


# -------------------------
# RICHTUNG (smooth)
# -------------------------
func update_direction(input_vector: Vector2) -> void:
	if abs(input_vector.x) > abs(input_vector.y):
		if input_vector.x > 0:
			dir = Direction.RIGHT
			sprite.flip_h = false
		else:
			dir = Direction.LEFT
			sprite.flip_h = true
	else:
		if input_vector.y < 0:
			dir = Direction.UP
			sprite.flip_h = false
		else:
			dir = Direction.DOWN
			sprite.flip_h = false


# -------------------------
# ANIMATION
# -------------------------
func update_animation() -> void:
	match dir:
		Direction.UP: direction_str = "Up"
		Direction.DOWN: direction_str = "Down"
		Direction.RIGHT, Direction.LEFT:
			direction_str = "Right"

	match modus:
		Modus.IDLE: mode_str = "idle"
		Modus.WALK: mode_str = "walk"
		Modus.RUN: mode_str = "run"
		Modus.AXE: mode_str = "axe"

	sprite.play(mode_str + direction_str)


# -------------------------
# AXE ENDE → IDLE
# -------------------------
func _on_animation_finished():
	if modus == Modus.AXE:
		is_busy = false
		set_modus(Modus.IDLE)
