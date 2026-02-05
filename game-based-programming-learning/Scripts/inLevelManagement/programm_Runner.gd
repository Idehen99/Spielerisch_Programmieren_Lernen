extends Node

var vars := {}
@onready var player

func _ready() -> void:
	if get_tree().get_first_node_in_group("player")!=null:
		player = get_tree().get_first_node_in_group("player")
	else:
		var play ="res://Scenes/Test/Test_Player.tscn"
		player = play.instantiate()
		add_child(player)
		print(player.get_groups())
		player.add_to_group("player")
	
func run_block_list(list):
	for cmd in list:
		match cmd.type:

			# In deinem ProgrammRunner Skript
			"move":
				if cmd.dir == "right":
					await player.move_step(Vector2.RIGHT)
				elif cmd.dir == "left":
					await player.move_step(Vector2.LEFT)

			"jump":
				await player.jump_animation()

			"for":
				for i in range(1, cmd.to + 1):
					vars[cmd.var] = i
					await run_block_list(cmd.body)

			"set_var":
				vars[cmd.name] = cmd.value

			"change_var":
				vars[cmd.name] += cmd.value

			"if":
				if evaluate(cmd.condition):
					run_block_list(cmd.body_true)
				else:
					run_block_list(cmd.body_false)

# 👇 HIER war sie vorher nicht
func evaluate(cond):
	var left = vars.get(cond.left, 0)
	var right = cond.right

	match cond.op:
		"<": return left < right
		">": return left > right
		"==": return left == right
		"!=": return left != right
	return false
