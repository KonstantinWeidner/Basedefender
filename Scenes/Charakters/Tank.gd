extends Node2D

var enemy_array: Array[Enemy] = []
var enemy: Enemy
var built = false
var projectile_scene: PackedScene = preload("res://Scenes/Charakters/Attacken/Projectile.tscn")

var HP_Tank = 20


func _ready():
	set_process(false)
	if built:
		set_process(true)
		$Path2D/PathFollow2D/AnimatedSprite2D/Area2D/RangeIndicator.visible = false
		return true

func _process(delta):
	$Path2D/PathFollow2D.progress += 70 * delta


func _on_area_2d_body_entered(body):
	if built:
		if body.is_in_group("Enemy"):
			body.kill()
			var deathVisual = load("res://Scenes/Charakters/Attacken/Projectile.tscn").instantiate()
			deathVisual.position = body.position
			
			GameData.money += 10
			HP_Tank -= 1
			
			if  HP_Tank == 0:
				queue_free()


func _on_area_2d_mouse_entered():
	$Path2D/PathFollow2D/AnimatedSprite2D/Area2D/RangeIndicator.visible = true


func _on_area_2d_mouse_exited():
	$Path2D/PathFollow2D/AnimatedSprite2D/Area2D/RangeIndicator.visible = false
