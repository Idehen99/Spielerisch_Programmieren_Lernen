extends Node

var vars = {}
@onready var player

func _ready() -> void:
	if get_tree().get_first_node_in_group("player")!=null:
		player = get_tree().get_first_node_in_group("player")
	else:
		var play = preload("res://Scenes/Test/Test_Player.tscn")
		player = play.instantiate()
		add_child(player)
		print(player.get_groups())
		player.add_to_group("player")
	
func run_block_list(list) -> bool:
	for cmd in list:
		match cmd.type:

			"move":
				if cmd.dir == "right":
					await player.move_step(Vector2.RIGHT)
				elif cmd.dir == "left":
					await player.move_step(Vector2.LEFT)
				elif cmd.dir == "up":
					await player.move_step(Vector2.UP)
				elif cmd.dir == "down":
					await player.move_step(Vector2.DOWN)

			"jump":
				await player.jump_animation()

			
			"for":
				var start_val = int(cmd.get("from", 1))
				var end_val = int(cmd.to)

				for i in range(start_val, end_val):
					vars[cmd.var] = i
					if await run_block_list(cmd.body):
						return true

			"set_var":
				vars[cmd.name] = cmd.value

			"change_var":
				vars[cmd.name] += cmd.value

			# Im match cmd.type unter "if":
			"if":
				var block = cmd.block_node
				block.update_slot_values()
				print(block.condition_left,block.condition_right)
				var live_condition = {
					"left": block.condition_left,
					"op": block.condition_op,
					"right": block.condition_right
				}
				if evaluate(live_condition):
					if await run_block_list(cmd.body_true):
						return true
				else:
					if await run_block_list(cmd.body_false):
						return true
			
			"return":
				return true
				
	return false
		
func evaluate(cond):
	var left = vars.get(cond.left, cond.left)
	var right = vars.get(cond.right, cond.right)
	match cond.op:
		"<": 
			if typeof(left) == typeof(right):
				return left < right
		">":
			if typeof(left) == typeof(right):
				return left > right
		"==": 
			if typeof(left) == typeof(right):
				return left == right
		"!=": 
			if typeof(left) == typeof(right):
				return left != right
			else: return true
	return false
