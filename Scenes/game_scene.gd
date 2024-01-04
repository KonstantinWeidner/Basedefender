extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type

var current_wave = 0
var enemies_in_wave = 0

var enemy_manager_scene: PackedScene = preload("res://Scenes/Enemies/EnemyManager.tscn")
var enemy_manager_instance = enemy_manager_scene.instantiate()
var enemy_spawn_point: Vector2
	
func _ready():
	map_node = get_node("Map1")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	#start_next_wave()
	
	add_child(enemy_manager_instance)	#adds enemy manager which spawns enemy

func _process(delta):
	if build_mode:
		update_character_preview()

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

## Building Functions

func initiate_build_mode(character_type):
	if build_mode:
		cancel_build_mode()
	build_type = character_type
	build_mode = true
	get_node("UI").set_character_preview(build_type, get_global_mouse_position())

func update_character_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TileMap").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TileMap").map_to_local(current_tile)
	
	get_node("UI").update_character_preview(tile_position)
	build_valid = true
	build_location = tile_position

func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/CharPreview").free()

func verify_and_build():
	if build_valid:
		#test if player has enough moneten TBA
		var new_character = load("res://Scenes/Charakters/" + build_type + ".tscn").instantiate()
		new_character.position = build_location
		new_character.built = true
		map_node.get_node("Charakters").add_child(new_character, true)

## Enemie spawning Functions - not used atm

func start_next_wave():#not used atm
	var wave_data = retrieve_wave_data()
	await (get_tree().create_timer(1)).timeout
	spawn_enemies(wave_data)

func retrieve_wave_data():#not used atm
	var wave_data = [["Zombie", 0.7], ["Zombie", 0.1]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):#not used atm
	for i in wave_data:
		var new_enemy = load("res://Scenes/Enemies/" + i[0] + ".tscn").instantiate()
		map_node.get_node("Path").add_child(new_enemy, true)
		await(get_tree().create_timer(i[1])).timeout
		

