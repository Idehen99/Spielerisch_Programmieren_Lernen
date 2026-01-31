extends Node
var Gender = "Male"
var Spielstand = 0
var saveData = {"new":true}
var new = false

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
	
