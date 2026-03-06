extends Node

func build_program(container):
	var program := []

	for child in container.get_children():
		if not child is CodeBlock:
			continue

		match child.block_type:
			"move":
				if child.Side == "Move Right":
					program.append({
						"type": "move",
						"dir": "right"
					})
				elif child.Side == "Move Left":
					program.append({
						"type": "move",
						"dir": "left"
					})
				elif child.Side == "Move Up":
					program.append({
						"type": "move",
						"dir": "up"
					})
				elif child.Side == "Move Down":
					program.append({
						"type": "move",
						"dir": "down"
					})

			"for":
				var body = build_program(child.content)
				program.append({
					"type": "for",
					"var": child.var_name,
					"from": child.from,
					"to": child.to,
					"body": body
				})

			"if":
				# WICHTIG: Erst die Werte aus den Slots in die Variablen laden!
				child.update_slot_values() 

				var body_true = build_program(child.content_true)
				var body_false = build_program(child.content_false)

				program.append({
					"type": "if",
					"condition": {
						"left": child.condition_left,  
						"op": child.condition_op,      
						"right": child.condition_right 
					},
					"body_true": body_true,
					"body_false": body_false
				})

	return program
