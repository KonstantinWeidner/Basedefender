extends Node2D


var target_position = Vector2(600,300)
var speed: float = 50

func _ready():
	set_process(true)

func _process(delta):	
	var direction = (target_position - position).normalized()
	var new_position = position + direction * speed * delta
	position = new_position

func kill_zombie():
	for child in get_children(): #funktioniert garnicht
		$Zombie2.remove_from_group
		#print("test")
