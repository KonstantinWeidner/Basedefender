extends CharacterBody2D
class_name Enemy

var spawn_interval: float = 2.0
var target_position = Vector2(625, 325)
var speed: float = randf_range(0.4, 0.9)

var new_position
var alive: bool = true



func _ready():
	pass

func _process(delta):	
	position = position.move_toward(target_position, speed)

func change_target():
	pass

func kill(): # des funktioniert, muss nur berechnung so ändern das zombie stehen bleibt
	#alive = false
	queue_free()
	#print("killed")
	GameData.score += 5
	if GameData.score > GameData.Highscore:
		GameData.Highscore += 5


func _on_area_2d_body_entered(body):
	if body.is_in_group("Castle"):
		kill()
		GameData.CastleHP -= 1
		GameData.timer = 0
		#print("hit")
		
func _on_search_circle_area_entered(area):
	if area.is_in_group("Miner"):
		target_position = area.get_parent().position
		area.get_parent().attacked()
		await get_tree().create_timer(3.0).timeout
		target_position = Vector2(625, 325)

func _on_search_circle_area_exited(area):
	if area.is_in_group("Miner"):                                                                                             
		target_position = Vector2(625, 325)
