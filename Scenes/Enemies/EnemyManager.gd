extends Node2D

var spawn_interval: float = 2.0
var lastSpawn: float = 0

func _ready():
		# Starte den Timer für das Spawn-Intervall
	$Timer.start(spawn_interval)
	print ("ready called")
	#wenn game over timer.stop

func spawn_enemy():
	var rand_x = randf_range(64, 960)
	var rand_y = randf_range(512, 64)
	var enemy_spawn_point =  Vector2(rand_x, rand_y) #spawnpoit randomizer
	
	#print("Spawning enemy at:", enemy_spawn_point)
	var enemy_instance = load("res://Scenes/Enemies/Enemy.tscn").instantiate()
	enemy_instance.position = enemy_spawn_point
	add_child(enemy_instance)

func _on_timer_timeout():
	#print("Timer timeout - Spawning enemy")
	spawn_enemy()  # Übergebe hier den korrekten Spawn-Punkt
	#print("Spawned enemy")
