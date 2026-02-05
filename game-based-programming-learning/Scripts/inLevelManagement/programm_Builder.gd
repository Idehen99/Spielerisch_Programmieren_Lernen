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
				else:
					program.append({
						"type": "move",
						"dir": "left"
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

	return program
