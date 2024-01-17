extends Node2D

var enemy_array: Array[Enemy] = []
var enemy: Enemy
var built = false

var projectile_scene: PackedScene = preload("res://Scenes/Charakters/Attacken/Projectile.tscn")
var deathVisual = load("res://Scenes/Charakters/Attacken/Projectile.tscn").instantiate()

func _ready():
	if built:
		$Area2D/RangeIndicator.visible = false
		return true

func _on_area_2d_body_entered(body):
	if built:
		if body.is_in_group("Enemy"):
			body.kill()
			#deathVisual.position = (body.position - position)
			#add_child(deathVisual)
			#print(body.position)
			#print(deathVisual.position)
			GameData.money += 10
			#get_tree().create_timer(2)
			#remove_child(deathVisual)
			#print(GameData.money)

func _on_area_2d_mouse_entered():
	$Area2D/RangeIndicator.visible = true


func _on_area_2d_mouse_exited():
	$Area2D/RangeIndicator.visible = false
