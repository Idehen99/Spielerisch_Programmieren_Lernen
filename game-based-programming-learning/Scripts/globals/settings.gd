extends Node
var Gender = "Male"
var Spielstand = 0
var saveData = {"new":true}
var new = false
@onready var HairColor = "Black"
@onready var HairStyle = "Lyria"
var EyeColor = "Green"
var Clothes = "Purple"
var Skins = "1"
var axeUnlocked = false
var weizensack = false
var levelFinished = 0

var current_scene = "no_scene"
var fire = false


var sceneChange = false
var spawnPosition: Vector2

func _on_change_scene_spawn_position(vec: Vector2):
	spawnPosition = vec
	sceneChange = true

func _on_changed_scene_positioning(player: CharacterBody2D) -> bool:
	if sceneChange:
		player.global_position = spawnPosition
		sceneChange = false
		return true
	return false

# In Settings.gd (dein Singleton)
func update_from_save():
	if saveData.has("gender"): Gender = saveData["gender"]
	if saveData.has("hair_color"): HairColor = saveData["hair_color"]
	if saveData.has("hair_style"): HairStyle = saveData["hair_style"]
	if saveData.has("eye_color"): EyeColor = saveData["eye_color"]
	if saveData.has("clothes"): Clothes = saveData["clothes"]
	if saveData.has("skins"): Skins = saveData["skins"]
	if saveData.has("fire"): fire = saveData["fire"]
	if saveData.has("axeUnlocked"): axeUnlocked = saveData["axeUnlocked"]
	if saveData.has("levelFinished"): levelFinished = saveData["levelFinished"]
	if saveData.has("weizensack"): weizensack = saveData["weizensack"]
  
