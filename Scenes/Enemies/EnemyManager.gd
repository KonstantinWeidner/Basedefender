extends Node2D

var spawn_interval: float = 2.0
var lastSpawn: float = 0
var group_size: int = 1  # Anzahl der Zombies pro Gruppe

func _ready():
		# Starte den Timer für das Spawn-Intervall
	$Timer.start(spawn_interval)
	print ("ready called")
	#wenn game over timer.stop

func spawn_enemy_group():
	for i in range(group_size):
		spawn_enemy()

func spawn_enemy():
	
	#print("Spawning enemy at:", enemy_spawn_point)
	var enemy_instance = load("res://Scenes/Enemies/Enemy.tscn").instantiate()
	
	var rand_x = randf_range(0, 960)
	var rand_y = randf_range(512, 0)
	var enemy_spawn_point =  Vector2(rand_x, rand_y) #spawnpoit randomizer
	
	enemy_instance.position = enemy_spawn_point #fixbar durch übergabe des rand spawnpunkts in spawn grpup und dann hier nur minimale manipulation am wert
	add_child(enemy_instance)

func _on_timer_timeout():
	#print("Timer timeout - Spawning enemy")
	spawn_enemy_group()  # Übergebe hier den korrekten Spawn-Punkt
	#print("Spawned enemy")
