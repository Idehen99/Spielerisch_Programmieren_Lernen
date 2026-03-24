extends CharacterBody2D

enum Modus { IDLE, AXE, RUN, WALK }
enum Direction { UP, DOWN, RIGHT, LEFT}

@export var speed := 100
@export var step_size = 16.0
@export var axe_unlocked = false

var modus: Modus = Modus.IDLE
var dir: Direction = Direction.DOWN

var direction_str = "Down"
var mode_str = "idle"

var is_busy := false
var free_to_walk = false
@onready var parts = [
	$CollisionShape2D/Hair,
	$CollisionShape2D/Eyes,
	$CollisionShape2D/Skins,
	$CollisionShape2D/Clothes, 
	$Axe
]

var axeCounter = 0

func _ready() -> void:
	if Settings.saveData.has("new") and !Settings.saveData["new"]:
		if Settings._on_changed_scene_positioning($"."):
			pass
		else:
			$".".global_position = Settings.saveData["player_pos"]
	#for p in parts:
		#p.animation_finished.connect(_on_animation_finished)
	for m in Modus:
		for d in Direction:
			var mode
			var dire
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
			$CollisionShape2D/Hair.change(mode, anim_name)
			$CollisionShape2D/Eyes.change(mode, anim_name)
			$CollisionShape2D/Skins.change(mode, anim_name)
			$CollisionShape2D/Clothes.change(mode, anim_name)



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
	elif !is_busy:
		set_modus(Modus.IDLE)
		velocity = Vector2.ZERO
	if free_to_walk:
		move_and_slide()
	update_animation()


func _free_him():
	free_to_walk = !free_to_walk
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
var last_anim_name = ""  # speichert die aktuell abgespielte Animation

func update_animation() -> void:
	match dir:
		Direction.UP: direction_str = "Up"
		Direction.DOWN: direction_str = "Down"
		Direction.RIGHT, Direction.LEFT:
			direction_str = "Right"

	match modus:
		Modus.IDLE: 
			mode_str = "idle"
			axeCounter = 0
		Modus.WALK: mode_str = "walk"
		Modus.RUN: mode_str = "run"
		Modus.AXE: 
			if axeCounter < 1:
				mode_str = "axe"
				axeCounter = 1
			else: mode_str = "idle"

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


func _on_area_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarLinks"):
		get_tree().get_first_node_in_group("VarLinks").change_sensor_state(true)


func _on_area_left_body_exited(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarLinks"):
		get_tree().get_first_node_in_group("VarLinks").change_sensor_state(false)


func _on_area_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarRechts"):
		get_tree().get_first_node_in_group("VarRechts").change_sensor_state(true)


func _on_area_right_body_exited(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarRechts"):
		get_tree().get_first_node_in_group("VarRechts").change_sensor_state(false)


func _on_area_up_body_entered(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarOben"):
		get_tree().get_first_node_in_group("VarOben").change_sensor_state(true)


func _on_area_up_body_exited(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarOben"):
		get_tree().get_first_node_in_group("VarOben").change_sensor_state(false)


func _on_area_down_body_entered(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarUnten"):
		get_tree().get_first_node_in_group("VarUnten").change_sensor_state(true)


func _on_area_down_body_exited(body: Node2D) -> void:
	if body.is_in_group("Blockade") and get_tree().get_first_node_in_group("VarUnten"):
		get_tree().get_first_node_in_group("VarUnten").change_sensor_state(false)
