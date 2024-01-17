extends Node2D

var enemy_array: Array[Enemy] = []
var enemy: Enemy
var built = false
var projectile_scene: PackedScene = preload("res://Scenes/Charakters/Attacken/Projectile.tscn")

var HP_Meele = 12

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 70

func _ready():
	#set_process(false)
	if built:
		return true#set_process(true)
	$AnimatedSprite2D/Area2D/CollisionShape2D/RangeIndicator.visible = false
	#print("meele spawned")

func _on_area_2d_body_entered(body):
	if built:
		if body.is_in_group("Enemy"):
			body.kill()
			#print("enemy hit")
			#var deathVisual = load("res://Scenes/Charakters/Attacken/Projectile.tscn").instantiate()
			#deathVisual.position = body.position
			
			GameData.money += 10
			HP_Meele -= 1
			if  HP_Meele == 0:
				get_parent().queue_free()


func _on_area_2d_mouse_entered():
	$AnimatedSprite2D/Area2D/CollisionShape2D/RangeIndicator.visible = true


func _on_area_2d_mouse_exited():
	$AnimatedSprite2D/Area2D/CollisionShape2D/RangeIndicator.visible = false
