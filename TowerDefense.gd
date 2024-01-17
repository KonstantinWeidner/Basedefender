extends Node

func _ready():
	get_node("Menu/TextureButton").pressed.connect(on_new_game_pressed)
	#get_node("DeathScreen/Margin/VB/NewGame").pressed.connect(start_new_game)
	$DeathScreen.visible = false

func deathscreen_vis():
	$DeathScreen.visible = true
func menu_vis():
	$Menu.visible = false

func on_new_game_pressed():
	get_node("Menu").queue_free()
	var game_scene = load("res://Scenes/game_scene.tscn").instantiate()
	add_child(game_scene)

func start_new_game():
	get_node("DeathScreen").queue_free()
	#var game_scene = load("res://Scenes/game_scene.tscn").instantiate()
	#add_child(game_scene)
