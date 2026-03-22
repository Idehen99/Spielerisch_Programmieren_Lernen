extends AnimatedSprite2D

# Die Variable, die bestimmt, ob der Spieler die Axt überhaupt besitzt
@export var unlocked := false

# Wir laden die Skin-Einstellung wie in den anderen Skripten
@onready var skin = Settings.Skins

func _ready() -> void:
	# Synchronisiere den Status beim Start mit deiner Global/Settings Datei
	# Ich nehme an, die Variable heißt dort 'axeUnlocked'
	if Settings.axeUnlocked:
		unlocked = Settings.axeUnlocked
	
	# Initial auf 'non' setzen, damit die Axt unsichtbar ist
	if sprite_frames.has_animation("non"):
		play("non")

# Diese Funktion wird vom Player-Skript aufgerufen (wie bei Hair, Eyes, etc.)
func change(action: String, anim_name: String):
	# Die Axt nutzt meist denselben Pfad wie die 'Axe and Sickle' Animationen
	var framespath = get_path_for_axe(action)
	var frames = framespath[0]
	var loop = framespath[1]
	var path = framespath[2]
	set_texture(path, anim_name, frames, loop)

func change2(action: String, anim_name: String):
	# LOGIK: Nur abspielen, wenn unlocked UND die Aktion wirklich "axe" ist
	if unlocked and action == "axe":
		if sprite_frames.has_animation(anim_name):
			play(anim_name)
	else:
		# Ansonsten immer die "non"-Animation (leerer Sprite)
		if sprite_frames.has_animation("non"):
			play("non")

func get_path_for_axe(_action: String):
	return [6, false, "res://Assets/Farm RPG - Tiny Asset Pack - (All in One)/Character and Portrait/Character/PNG/5. Axe and Sickle/Weapons/" + "3" + ".png"]

# Die Textur-Logik bleibt identisch zu deinen anderen Parts
func set_texture(sheet_path: String, anim_name: String, framesN: int, _loop: bool):
	if sprite_frames == null:
		sprite_frames = SpriteFrames.new()
	
	# Falls 'non' noch nicht existiert, erstellen wir einen leeren Frame
	if not sprite_frames.has_animation("non"):
		sprite_frames.add_animation("non")
	
	var speed = 8 # Axt-Animationen sind oft etwas schneller
	if sprite_frames.has_animation(anim_name):
		sprite_frames.remove_animation(anim_name)
	
	sprite_frames.add_animation(anim_name)
	var texture = load(sheet_path)
	for i in range(framesN):
		var atlas = AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(i * 32, 0, 32, 32)
		sprite_frames.add_frame(anim_name, atlas)
	
	sprite_frames.set_animation_loop(anim_name, false)
	sprite_frames.set_animation_speed(anim_name, speed)
