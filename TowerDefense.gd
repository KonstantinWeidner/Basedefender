extends Node

func _ready():
	get_node("Menu/Margin/VB/NewGame").pressed.connect(on_new_game_pressed)
	
func on_new_game_pressed():
	get_node("Menu").queue_free()
	var game_scene = load("res://Scenes/game_scene.tscn").instantiate()
	add_child(game_scene)
