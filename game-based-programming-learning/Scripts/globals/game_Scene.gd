extends Node
@onready  var runner := $ProgramRunner
@onready var code_area := $UI/CodeEditor
@onready var level_container := $LevelContainer

func _ready():
	load_level("res://Levels/Level_01.tscn")

func load_level(path):
	level_container.get_children().map(func(c): c.queue_free())
	var level = load(path).instantiate()
	level_container.add_child(level)
