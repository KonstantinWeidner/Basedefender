extends Node2D

var spawn_interval: float = 2.5
var lastSpawn: float = 0
var group_size: int = 1  # Anzahl der Zombies pro Gruppe
var enemy_spawn_point: Vector2
var exisiting = true

func _ready():
		# Starte den Timer für das Spawn-Intervall
	$Timer.start(spawn_interval)
	#print ("ready called")
	#wenn game over timer.stop
	while exisiting:
		await get_tree().create_timer(25).timeout
		group_size += 1
	

func deleted():
	exisiting = false

func spawn_enemy_group():
	for i in range(group_size):
		spawn_enemy()
		#print(group_size)

func spawn_enemy():
	var excluded_rect = Rect2(10,10, 1280, 700)# excluded area
	
	while true:
		var rand_x = randi_range(-50, 1450)
		var rand_y = randi_range(-50, 770)
		enemy_spawn_point = Vector2(rand_x, rand_y)
		if excluded_rect.has_point(enemy_spawn_point):
			break
		else:
			var enemy_instance = load("res://Scenes/Enemies/Enemy.tscn").instantiate()
			enemy_instance.position = enemy_spawn_point #fixbar durch übergabe des rand spawnpunkts in spawn grpup und dann hier nur minimale manipulation am wert
			add_child(enemy_instance)
	#print (enemy_instance.speed)
	#print (enemy_instance.position)

func _on_timer_timeout():
	#print("Timer timeout - Spawning enemy")
	spawn_enemy_group()  # Übergebe hier den korrekten Spawn-Punkt
	#print("Spawned enemy")
