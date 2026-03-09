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

			# Im match child.block_type unter "if":
			"if":
				# Wir speichern die Referenz auf das 'child' (den UI-Block) direkt mit!
				program.append({
					"type": "if",
					"block_node": child, # Das ist der Verweis auf das UI-Element
					"body_true": build_program(child.content_true),
					"body_false": build_program(child.content_false)
				})
			
			"return":
				program.append({
					"type": "return"
				})
				
	return program
