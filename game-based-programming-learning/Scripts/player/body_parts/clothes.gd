extends AnimatedSprite2D
@onready var color = Settings.Clothes
var anima = "idleUp"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

var loaded_frames = {} # Dictionary für alle Animationsnamen
func change(action,anim_name: String):
		var framespath = get_path_for_current_style(action, anim_name)
		var frames = framespath[0]
		var loop = framespath[1]
		var path = framespath[2]
		set_texture(path, anim_name, frames, loop)



func change2(_action, anim_name: String):
	if sprite_frames.has_animation(anim_name):
		if animation != anim_name:  # Animation nur starten, wenn sie nicht schon läuft
			play(anim_name)



func get_path_for_current_style(action:String , _anim: String):
	color = Settings.Clothes
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
	if sprite_frames == null:
		sprite_frames = SpriteFrames.new()

	var speed := 5
	var keep_loop := loop
	var old_regions: Array = []
	if sprite_frames.has_animation(anim_name):
		speed = sprite_frames.get_animation_speed(anim_name)
		keep_loop = sprite_frames.get_animation_loop(anim_name)
		var old_count = sprite_frames.get_frame_count(anim_name)
		for i in range(old_count):
			var old_tex = sprite_frames.get_frame_texture(anim_name, i)
			if old_tex is AtlasTexture:
				old_regions.append(old_tex.region)
			else:
				old_regions.append(Rect2(Vector2.ZERO, old_tex.get_size()))
		sprite_frames.remove_animation(anim_name)
	sprite_frames.add_animation(anim_name)
	var texture = load(sheet_path)
	for i in range(framesN):
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		if i < old_regions.size():
			atlas.region = old_regions[i]
		else:
			atlas.region = Rect2(i * 32, 0, 32, 32) # Fallback
		sprite_frames.add_frame(anim_name, atlas)
	sprite_frames.set_animation_loop(anim_name, keep_loop)
	sprite_frames.set_animation_speed(anim_name, speed)
	if animation == anim_name:
		play(anim_name)
