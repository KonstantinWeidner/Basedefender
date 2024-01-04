extends CharacterBody2D


var target_position = Vector2(600,300)
var speed: float = 50

func _ready():
	set_process(true)

func _process(delta):	
	var direction = (target_position - position).normalized()
	var new_position = position + direction * speed * delta
	position = new_position

func collisionCastle():
	#get_tree().get_nodes_in_group()
	pass

func _on_area_2d_area_entered(area):
	#print("collision")#irgendwie castle connecten
	pass
