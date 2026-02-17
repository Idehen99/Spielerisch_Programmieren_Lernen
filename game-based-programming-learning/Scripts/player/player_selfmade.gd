extends CharacterBody2D

enum Modus { IDLE, AXE, RUN, WALK }
enum Direction { UP, DOWN, RIGHT, LEFT}

@export var speed := 100

var modus: Modus = Modus.IDLE
var dir: Direction = Direction.DOWN

var direction_str = "Down"
var mode_str = "idle"

var is_busy := false

@onready var parts = [
	$Hair,
	$Eyes,
	$Skins,
	$Clothes
]

func _ready() -> void:
	if Settings.saveData.has("new") and !Settings.saveData["new"]:
		if Settings._on_changed_scene_positioning($"."):
			pass
		else:
			$".".global_position = Settings.saveData["player_pos"]
	for p in parts:
		p.animation_finished.connect(_on_animation_finished)
	for m in Modus:
		for d in Direction:
			var mode
			var dire
			print(m,d,Modus.IDLE,m=="IDLE")
			match d:
				"UP": dire = "Up"
				"DOWN": dire = "Down"
				"RIGHT":
					dire = "Right"
				"LEFT": continue
			match m:
				"IDLE": mode = "idle"
				"WALK": mode = "walk"
				"RUN": mode = "run"
				"AXE": mode = "axe"
			var anim_name = mode + dire
			$Hair.change(mode, anim_name)
			$Eyes.change(mode, anim_name)
			$Skins.change(mode, anim_name)
			$Clothes.change(mode, anim_name)


# -------------------------
# INPUT
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
# BEWEGUNG
# -------------------------
func _process(_delta):
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
# RICHTUNG
# -------------------------
func update_direction(input_vector: Vector2) -> void:
	if abs(input_vector.x) > abs(input_vector.y):
		if input_vector.x > 0:
			dir = Direction.RIGHT
			flip_parts(false)
		else:
			dir = Direction.LEFT
			flip_parts(true)
	else:
		if input_vector.y < 0:
			dir = Direction.UP
			flip_parts(false)
		else:
			dir = Direction.DOWN
			flip_parts(false)

func flip_parts(value: bool):
	for p in parts:
		p.flip_h = value

# -------------------------
# ANIMATION
# -------------------------
var last_anim_name := ""  # speichert die aktuell abgespielte Animation

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

	var anim_name = mode_str + direction_str

	if anim_name != last_anim_name:
		for p in parts:
			p.change2(mode_str, anim_name)  # Animation wechseln nur bei Änderung
		last_anim_name = anim_name


# -------------------------
# AXE ENDE
# -------------------------
func _on_animation_finished():
	if modus == Modus.AXE:
		is_busy = false
		set_modus(Modus.IDLE)
