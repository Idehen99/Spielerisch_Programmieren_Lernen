extends AnimatedSprite2D
var color = "Blue"
var anima = "idleDown"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

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
			return [4, true, "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/1. Idle/Clothers/Farm/" + color +".png"]
		"walk":
			return [6, true, "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/2. Walk/Clothers/Farm/" + color +".png"]
		"run":
			return [8, true, "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/3. Run/Clothers/Farm/" + color +".png"]
		"axe":
			return [6, false, "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/5. Axe and Sickle/Clothers/Farm/" + color +".png"]

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
