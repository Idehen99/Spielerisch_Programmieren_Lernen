extends CharacterBody2D


enum Modus {IDLE, AXE, RUN, WALK}
enum Direction {UP, DOWN, LEFT, RIGHT}

@export var speed := 100


var modus: Modus = Modus.IDLE
var dir = Direction.UP
var sprite
var direction
var mode

func _ready() -> void:
	if Settings.Gender=="Female":
		sprite=$FemaleSprite
		$MaleSprite.visible = false
	else:
		sprite=$MaleSprite
		$FemaleSprite.visible = false
	


func _physics_process(delta):
	var x = Input.get_axis("ui_left", "ui_right")
	var y = Input.get_axis("ui_up", "ui_down")
	var input_vector = Vector2(x,y)
	if input_vector != Vector2(0,0):
		if input_vector.y < 0:
			dir = Direction.UP
			sprite.flip_h = false
		elif input_vector.y > 0:
			dir = Direction.DOWN
			sprite.flip_h = false
		elif input_vector.x > 0:
			dir = Direction.RIGHT
			sprite.flip_h = false
		else:
			dir = Direction.LEFT
			sprite.flip_h = true
				
		if Input.is_action_pressed("run"):
			modus = Modus.RUN
			velocity = input_vector.normalized() * speed * 1.5
		else:
			modus = Modus.WALK
			velocity = input_vector.normalized() * speed
		
	else:
		if Input.is_action_just_pressed("axe"):
			modus = Modus.AXE
		else:
			modus = Modus.IDLE
		velocity = Vector2.ZERO
		
	move_and_slide()
	
	match dir:
		Direction.UP:
			direction = "Up"
		Direction.DOWN:
			direction = "Down"
		Direction.RIGHT:
			direction = "Right"
		Direction.LEFT:
			direction = "Right"

	match modus:
		Modus.IDLE:
			mode = "idle"
		Modus.RUN:
			mode = "run"
		Modus.WALK:
			mode = "walk"
		Modus.AXE:
			mode = "axe"
	
	sprite.play(mode + direction)
