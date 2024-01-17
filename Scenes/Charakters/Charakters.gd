extends Node2D

var enemy_array = []
var built = false
var enemy

var projectile_scene: PackedScene = preload("res://Scenes/Charakters/Attacken/Projectile.tscn")
var zombie = load("res://Scenes/Enemies/ZombieGroup.tscn").instantiate()

func _ready():
	if built:
		return true

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
	else:
		enemy = null

func _on_area_2d_body_entered(body):
	enemy_array.append(body)
	#print(enemy_array)
	print("enemy in range")
	zombie.kill_zombie()#funktioniert nicht


func select_enemy(): #funktioniert nicht
	if enemy_array.size() > 0:
		# Wähle den nächsten Zombie als Ziel
		enemy = enemy_array[0]
		var closest_distance = position.distance_to(enemy.position)

		for i in range(1, enemy_array.size()):
			var current_distance = position.distance_to(enemy_array[i].position)
			if current_distance < closest_distance:
				closest_distance = current_distance
				enemy = enemy_array[i]

		# Feuere den Feuerball auf den ausgewählten Zombie
		shoot_fireball()
		var zombie = load("res://Scenes/Enemies/ZombieGroup.tscn").instantiate()
		zombie.kill_zombie()
		#print("Zombie should die")

func shoot_fireball():#funktioniert nicht
	if enemy:
		var projectile_instance = projectile_scene.instantiate()
		projectile_instance.position = position
		add_child(projectile_instance)

		# Berechne die Richtung zum ausgewählten Gegner
		var projectile_direction = (enemy.position - position).normalized()

		# Starte die Bewegung des Feuerballs in Richtung des ausgewählten Gegners
		projectile_instance.start_movement(projectile_direction)


