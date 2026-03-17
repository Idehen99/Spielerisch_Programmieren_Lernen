extends Control

signal ready_for_next_sentence
signal dialog_finished

@onready var text_label = $RichTextLabel

var sentences = []
var current_sentence = ""
var sentence_index = 0

var char_index = 0
var typing_speed = 0.03
var typing = false


func start_dialog(text : String):
	self.visible=true
	sentences = split_into_sentences(text)
	sentence_index = 0
	show_sentence()


func split_into_sentences(text):
	var result = []
	var parts = text.split(".")
	
	for p in parts:
		p = p.strip_edges()
		if p != "":
			result.append(p + ".")
	
	return result


func show_sentence():
	if sentence_index >= sentences.size():
		emit_signal("dialog_finished")
		self.visible = false
		return
	
	current_sentence = sentences[sentence_index]
	text_label.text = current_sentence
	
	char_index = 0
	text_label.visible_characters = 0
	
	typing = true
	type_text()


func type_text():
	while typing and char_index <= current_sentence.length():
		text_label.visible_characters = char_index
		char_index += 1
		await get_tree().create_timer(typing_speed).timeout
	
	typing = false
	emit_signal("ready_for_next_sentence")


func _input(event):
	if event.is_action_pressed("next_dialog"):
		
		if typing:
			text_label.visible_characters = current_sentence.length()
			typing = false
		
		else:
			sentence_index += 1
			show_sentence()
