extends Control
@onready var Gender = "Male"
@onready var SkinColor = "1"
@onready var ClothColor = "Blue"
@onready var EyeColor = "Black"
@onready var HairColor = "Black"
@onready var Hairstyle = "Josh"


func _ready() -> void:
	#if Settings.current_scene != "no_scene":
	$CanvasLayer/HBoxContainer/Play.visible = false
	#else:
		#$CanvasLayer/HBoxContainer/LetsGo.visible = false
	change_design()

func _process(_delta: float) -> void:
	pass

func change_design():
	var GenderSkin 
	var GenderCloth
	var HairColorStyle
	var Eyes = $ActualDesignNode2D/Eyes
	
	match Gender:
		"Female":
			$ActualDesignNode2D/MaleSkin.visible = false
			$ActualDesignNode2D/FemaleSkin.visible = true
			GenderSkin = $ActualDesignNode2D/FemaleSkin
			GenderCloth = $ActualDesignNode2D/FemaleSkin/FemaleClothes
		"Male":
			$ActualDesignNode2D/MaleSkin.visible = true
			$ActualDesignNode2D/FemaleSkin.visible = false
			GenderSkin = $ActualDesignNode2D/MaleSkin
			GenderCloth = $ActualDesignNode2D/MaleSkin/MaleClothes
	match SkinColor:
		"1":
			GenderSkin.play("1")
		"2":
			GenderSkin.play("2")
		"3":
			GenderSkin.play("3")
		"4":
			GenderSkin.play("4")
	match ClothColor:
		"Blue":
			GenderCloth.play("Blue")
		"Green":
			GenderCloth.play("Green")
		"Pink":
			GenderCloth.play("Pink")
		"Purple":
			GenderCloth.play("Purple")
		"Red":
			GenderCloth.play("Red")
	match HairColor:
		"Black":
			$ActualDesignNode2D/Eyes/Black.visible = true
			$ActualDesignNode2D/Eyes/Blonde.visible = false
			$ActualDesignNode2D/Eyes/Brown.visible = false
			$ActualDesignNode2D/Eyes/Ginger.visible = false
			HairColorStyle = $ActualDesignNode2D/Eyes/Black
		"Blonde":
			$ActualDesignNode2D/Eyes/Black.visible = false
			$ActualDesignNode2D/Eyes/Blonde.visible = true
			$ActualDesignNode2D/Eyes/Brown.visible = false
			$ActualDesignNode2D/Eyes/Ginger.visible = false
			HairColorStyle = $ActualDesignNode2D/Eyes/Blonde
		"Brown":
			$ActualDesignNode2D/Eyes/Black.visible = false
			$ActualDesignNode2D/Eyes/Blonde.visible = false
			$ActualDesignNode2D/Eyes/Brown.visible = true
			$ActualDesignNode2D/Eyes/Ginger.visible = false
			HairColorStyle = $ActualDesignNode2D/Eyes/Brown
		"Ginger":
			$ActualDesignNode2D/Eyes/Black.visible = false
			$ActualDesignNode2D/Eyes/Blonde.visible = false
			$ActualDesignNode2D/Eyes/Brown.visible = false
			$ActualDesignNode2D/Eyes/Ginger.visible = true
			HairColorStyle = $ActualDesignNode2D/Eyes/Ginger
	match Hairstyle:
		"Fawn":
			HairColorStyle.play("Fawn")
		"Iridessa":
			HairColorStyle.play("Iridessa")
		"Josh":
			HairColorStyle.play("Josh")
		"Lyria":
			HairColorStyle.play("Lyria")
		"Sebastian":
			HairColorStyle.play("Sebastian")
		"Silvermist":
			HairColorStyle.play("Silvermist")
	match EyeColor:
		"Black":
			Eyes.play("Black")
		"Blue":
			Eyes.play("Blue")
		"Green":
			Eyes.play("Green")
		"Brown":
			Eyes.play("Brown")
	Settings.Clothes = ClothColor
	Settings.Skins = SkinColor
	Settings.EyeColor = EyeColor
	Settings.HairColor = HairColor
	Settings.HairStyle = Hairstyle
	Settings.axeUnlocked = false
	Settings.fire = false
	Settings.levelFinished = 0
	Settings.weizensack = false
	
	
	
func _on_boy_pressed() -> void:
	Gender = "Male"
	change_design()
func _on_girl_pressed() -> void:
	Gender = "Female"
	change_design()
func _on_black_pressed() -> void:
	HairColor = "Black"
	change_design()
func _on_blonde_pressed() -> void:
	HairColor = "Blonde"
	change_design()
func _on_brown_pressed() -> void:
	HairColor = "Brown"
	change_design()
func _on_ginger_pressed() -> void:
	HairColor = "Ginger"
	change_design()
func _on_fawn_button_up() -> void:
	Hairstyle = "Fawn"
	change_design()
func _on_iridessa_pressed() -> void:
	Hairstyle = "Iridessa"
	change_design()
func _on_josh_pressed() -> void:
	Hairstyle = "Josh"
	change_design()
func _on_lyria_pressed() -> void:
	Hairstyle = "Lyria"
	change_design()
func _on_sebastian_pressed() -> void:
	Hairstyle = "Sebastian"
	change_design()
func _on_silvermist_pressed() -> void:
	Hairstyle = "Silvermist"
	change_design()
func _on_black_Eye_pressed() -> void:
	EyeColor = "Black"
	change_design()
func _on_blue_Eye_pressed() -> void:
	EyeColor = "Blue"
	change_design()
func _on_brown_Eye_pressed() -> void:
	EyeColor = "Brown"
	change_design()
func _on_green_Eye_pressed() -> void:
	EyeColor = "Green"
	change_design()
func _on_one_pressed() -> void:
	SkinColor = "1"
	change_design()
func _on_two_pressed() -> void:
	SkinColor = "2"
	change_design()
func _on_three_pressed() -> void:
	SkinColor = "3"
	change_design()
func _on_four_pressed() -> void:
	SkinColor = "4"
	change_design()
func _on_blue_pressed() -> void:
	ClothColor = "Blue"
	change_design()
func _on_green_pressed() -> void:
	ClothColor = "Green"
	change_design()
func _on_pink_pressed() -> void:
	ClothColor = "Pink"
	change_design()
func _on_purple_pressed() -> void:
	ClothColor = "Purple"
	change_design()
func _on_red_pressed() -> void:
	ClothColor = "Red"
	change_design()


func _on_lets_go_pressed() -> void:
	var level = "res://Scenes/level/level_1.tscn"
	var player_pos = Vector2(407.0,485.0)
	var gender = Settings.Gender
	var  all_data = {
		"actual_scene":level,
		"player_pos": player_pos,
		"inventory": "inventory",
		"new": false,
		"gender":gender,
		"hair_color": Settings.HairColor,
		"hair_style": Settings.HairStyle,
		"eye_color": Settings.EyeColor,
		"clothes": Settings.Clothes,
		"skins": Settings.Skins,
		"fire": Settings.fire,
		"axeUnlocked": Settings.axeUnlocked,
		"levelFinished":Settings.levelFinished,
		"weizensack":Settings.weizensack
	}
	
	Savefile.save_all(Settings.Spielstand, all_data)
	Settings.saveData = Savefile.load_all(Settings.Spielstand)
	Settings.update_from_save()
	var scene = Savefile.load_variable(1,"actual_scene", "n")
	get_tree().change_scene_to_file(scene)
	#Savefile.load_all(Settings.Spielstand)
	#Settings.changeling()
	


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(Settings.current_scene)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/main_menu.tscn")
