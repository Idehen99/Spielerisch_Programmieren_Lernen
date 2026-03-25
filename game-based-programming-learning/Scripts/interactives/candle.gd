extends Node2D

@export var text = "Jetzt wo wir die Kerze haben müssen wir zum Kamin. Du kannst jetzt auch Wiederholungen benutzen. Damit kannst du Blöcke mehrfach benutzen. Setze einen Block in die Wiederholung. Und schreib in die Lücke wie oft der Block Wiederholt werden soll. Mit dem Ausschaltknopf oben Links kannst du das Level verlassen. Und jetzt auf zum Kamin."
@export var text2 = "Du hast es geschafft. Jetzt ist Mir wieder mollig warm. Lass uns wieder nach Draußen gehen. Benutze den Ausschaltknopf um das Level zu verlassen."
@onready var textbox = get_tree().get_first_node_in_group("textbox")
var catched = false


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_tree().get_first_node_in_group("player") and catched:
		self.position = get_tree().get_first_node_in_group("player").position + Vector2(3,-4)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		catched = true
		if get_tree().get_first_node_in_group("textbox"):
			textbox = get_tree().get_first_node_in_group("textbox")
			print(textbox)
			textbox.start_dialog(text)
			
		
		if get_tree().get_first_node_in_group("blockManager"):
			get_tree().get_first_node_in_group("blockManager").For = true
			get_tree().get_first_node_in_group("blockManager")._ready()
		#$AnimatedSprite2D.visible = false
		if get_tree().get_first_node_in_group("interpreter"):
			get_tree().get_first_node_in_group("interpreter").posi = self.position + Vector2(0,20)
		
	

func _on_fire_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("fire"):
		Settings.fire = true
		if body.sprite:
			body.sprite.play("default")
			get_tree().get_first_node_in_group("textbox").start_dialog(text2)
			


func _on_fire_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	if body.is_in_group("fire"):
		Settings.fire = true
		if get_tree().get_first_node_in_group("codelevel"):
			get_tree().get_first_node_in_group("codelevel")._finished_level()
		if body.sprite:
			body.sprite.play("default")
		if get_tree().get_first_node_in_group("textbox"):
			textbox = get_tree().get_first_node_in_group("textbox")
			print(textbox)
			textbox.start_dialog(text2)
