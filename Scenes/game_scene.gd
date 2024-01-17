extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type

var enemy_manager_scene: PackedScene = preload("res://Scenes/Enemies/EnemyManager.tscn")
var enemy_manager_instance = enemy_manager_scene.instantiate()

var gold_manager_scene: PackedScene = preload("res://Scenes/Economy/Goldspawner.tscn")
var gold_manager_instance = gold_manager_scene.instantiate()
	
var gameover = false

var first_unit_placed = false


func _ready():
	Engine.max_fps = 60
	
	$UI/HUD/Miner/TextureRect.modulate = Color(0.988,0.878,0.58,1)
		
	map_node = get_node("Map1")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	
	#set labels true, only visible when hovered
	$UI/HUD/Mage/Label.visible = false
	$UI/HUD/Mage/ColorRect.visible = false
	
	$UI/HUD/Miner/Label.visible = false
	$UI/HUD/Miner/ColorRect.visible = false
	
	$UI/HUD/MeeleSpawner/Label.visible = false
	$UI/HUD/MeeleSpawner/ColorRect.visible = false
	
	$UI/HUD/Tank/Label.visible = false
	$UI/HUD/Tank/ColorRect.visible = false
	
	$DeathScreen.visible = false
	
	$UI/HUD/Timer.start()
	add_child(gold_manager_instance)
	#print(first_unit_placed)
	
	
	await get_tree().create_timer(30).timeout #so player has time to learn about units
	add_child(enemy_manager_instance)	#adds enemy manager which spawns enemy
	$UI/HUD/Miner/TextureRect.modulate = Color(1,1,1,1)
	#print("manager added")
	$UI/HUD/TimeTillStart.visible = false

func _process(delta):
	if build_mode:
		update_character_preview()
		
	get_node("UI").update_money()
	check_castle_Status()
	#print(first_unit_placed)
	$UI/HUD/TimeTillStart.text = (str(int($UI/HUD/Timer.time_left)) + " left till enemies arrive")
		#print(str(30-n))
	
	GameData.timer += 0.017
	if GameData.timer >= 15:
		if GameData.CastleHP < 10:
			GameData.CastleHP += 1
			GameData.timer = 0
			
	#print(GameData.timer)

func _physics_process(delta):
	update_health()

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

## Building Functions

func initiate_build_mode(character_type):
	# geld hier noch abfragen ggf dann kann man garnicht kaufen glaube ich
	if build_mode:
		cancel_build_mode()
	build_type = character_type
	build_mode = true
	build_valid = true
	get_node("UI").set_character_preview(build_type, get_global_mouse_position())

func update_character_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TileMap").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TileMap").map_to_local(current_tile)
	
	get_node("UI").update_character_preview(tile_position)
	#if tile_position != excluded_rect:
	build_location = tile_position

func _on_exclusion_body_mouse_entered():
	#while true:
	build_valid = false
	#build_mode = false
	#print(build_valid)
	#print("entered")


func _on_exclusion_body_mouse_exited():
	build_valid = true
	
func cancel_build_mode():
	build_mode = false
	build_valid = false
	get_node("UI/CharPreview").free()

func verify_and_build():	
	var new_character = load("res://Scenes/Charakters/" + build_type + ".tscn").instantiate()
	if build_valid && GameData.money >= GameData.char_data[build_type]["cost"]:
		#test if player has enough moneten TBA
		new_character.position = build_location
		new_character.built = true
		map_node.get_node("Charakters").add_child(new_character, true)
		GameData.money -= GameData.char_data[build_type]["cost"]
		first_unit_placed = true

func check_castle_Status():
	if GameData.CastleHP == 0:
		remove_child(gold_manager_instance)
		enemy_manager_instance.deleted()#should deactivate countdown after death
		remove_child(enemy_manager_instance)
		var deathscreen = $DeathScreen
		deathscreen.position = Vector2(0,0)
		deathscreen.visible = true
		$UI/HUD.visible = false
		$DeathScreen/Highscore.text = str("Score: ",GameData.score)
		$DeathScreen/HighscoreAllTime.text = str("Highcore: ",GameData.Highscore)
		$DeathScreen/TextureButton.pressed.connect(on_new_game_pressed)
		#print("defeat")

func on_new_game_pressed():
	get_tree().reload_current_scene()#reset everything
	GameData.money = 50
	GameData.score = 0
	GameData.CastleHP = 10

func update_health():
	var healthbar = $Castle/Healthbar
	healthbar.value = GameData.CastleHP
	#print(GameData.score)

	if GameData.CastleHP >= 10:
		healthbar.visible = false
	else:
		healthbar.visible = true

#label mage
func _on_mage_mouse_entered():
	$UI/HUD/Mage/Label.visible = true
	$UI/HUD/Mage/ColorRect.visible = true
func _on_mage_mouse_exited():
	$UI/HUD/Mage/Label.visible = false
	$UI/HUD/Mage/ColorRect.visible = false
#label miner
func _on_miner_mouse_entered():
	$UI/HUD/Miner/Label.visible = true
	$UI/HUD/Miner/ColorRect.visible = true
func _on_miner_mouse_exited():
	$UI/HUD/Miner/Label.visible = false
	$UI/HUD/Miner/ColorRect.visible = false
#label meele
func _on_meele_spawner_mouse_entered():
	$UI/HUD/MeeleSpawner/Label.visible = true # Replace with function body.
	$UI/HUD/MeeleSpawner/ColorRect.visible = true
func _on_meele_spawner_mouse_exited():
	$UI/HUD/MeeleSpawner/Label.visible = false
	$UI/HUD/MeeleSpawner/ColorRect.visible = false
#label tank
func _on_tank_mouse_entered():
	$UI/HUD/Tank/Label.visible = true
	$UI/HUD/Tank/ColorRect.visible = true
func _on_tank_mouse_exited():
	$UI/HUD/Tank/Label.visible = false
	$UI/HUD/Tank/ColorRect.visible = false


