extends AnimatedSprite2D
var color = "Ginger"
var who = "Iridessa"
var anima = "idleDown"

func _ready() -> void:
	#$"../EyeTimer".start(10)
	#$"../HairTimer".start(35)
	pass

func _process(_delta: float) -> void:
	pass

func set_eye_color(anim, sheet_path):
	var frames = SpriteFrames.new()
	frames.add_animation(anim)

	var texture = load(sheet_path)

	for i in range(4): # z.B. 4 Frames
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(i * 32, 0, 32, 32)
		frames.add_frame(anim, atlas)

	sprite_frames = frames
	play(anim)	

func _on_hair_timer_timeout() -> void:
	match who:
		"Iridessa":
			who="Fawn"
		"Fawn":
			who="Lyria"
		"Lyria":
			who="Sebastian"
		"Sebastian":
			who="Standard"
		"Standard":
			who="Josh"
		"Josh":
			who="Silvermist"
		"Silvermist":
			who="Iridessa"

func _on_eye_timer_timeout() -> void:
	set_eye_color(anima,"res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/1. Idle/Hair's/"+ who + "/" + color + ".png")
	match color:
		"Blonde":
			color="Brown"
		"Black":
			color="Blonde"
		"Brown":
			color="Ginger"
		"Ginger":
			color="Black"

var loaded_frames = {} # Dictionary für alle Animationsnamen
func change(action,anim_name: String):
	if not loaded_frames.has(anim_name):
		var framespath = get_path_for_current_style(action, anim_name)
		var frames = framespath[0]
		var loop = framespath[1]
		var path = framespath[2]
		set_texture(path, anim_name, frames, loop)
		loaded_frames[anim_name] = true
		
func change2(_action, anim_name: String):
	if sprite_frames.has_animation(anim_name):
			play(anim_name)




func get_path_for_current_style(action:String , _anim: String):
	match action:
		"idle":
			return [6, true ,"res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/1. Idle/Hair's/"+ who + "/" + color + ".png"]
		"walk":
			return [6, true, "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/2. Walk/Hair's/"+ who + "/" + color + ".png"]
		"run":
			return [6, true, "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/3. Run/Hair's/"+ who + "/" + color + ".png"]
		"axe":
			return [6, false , "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/5. Axe and Sickle/Hair's/"+ who + "/" + color + ".png"]

func set_texture(sheet_path: String, anim_name: String, framesN: int, loop: bool):

	# Falls noch kein SpriteFrames existiert → einmal erstellen
	if sprite_frames == null:
		sprite_frames = SpriteFrames.new()

	# Falls Animation schon existiert → nichts doppelt hinzufügen
	if sprite_frames.has_animation(anim_name):
		return

	# Neue Animation hinzufügen
	sprite_frames.add_animation(anim_name)

	var texture = load(sheet_path)

	for i in range(framesN):
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(i * 32, 0, 32, 32)
		sprite_frames.add_frame(anim_name, atlas)

	sprite_frames.set_animation_loop(anim_name, loop)
	sprite_frames.set_animation_speed(anim_name, 5)
