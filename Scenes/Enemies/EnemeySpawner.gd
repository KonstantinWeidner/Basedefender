extends Node2D

var enemy_scene: PackedScene
var target_sprite: NodePath
var spawn_interval: float = 2.0
var spawn_timer: float = 0.0

func _process(delta):
	# Timer für das Spawnen von Gegnern
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_enemy_group()
		spawn_timer = 0.0

func spawn_enemy_group():
	for i in range(5):  # Anzahl der Gegner in der Gruppe
		var enemy_instance = enemy_scene.instance()
		enemy_instance.target_position = rand_point_on_map()
		add_child(enemy_instance)

func rand_point_on_map() -> Vector2:
	# Zufällige Startposition auf der Karte
	return Vector2(randf_range(100, 700), randf_range(100, 500))
