extends Node2D

var enemy_array = []
var built = false
var enemy

func _ready():
	if built:
		return true

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		turn()
	else:
		enemy = null

func turn():
	var enemy_position = get_global_mouse_position()
	get_node("MageText").look_at(Vector2(0,0)) #das später zu zielen bzw feuern ändern
	
func _on_area_2d_body_entered(body):
	enemy_array.append(body)
	print(enemy_array)

func _on_area_2d_body_exited(body):
	enemy_array.erase(body)

func select_enemy(): #sucht aktuell nach dem der an meisten fortgeschrittenm ist, noch zu nächster dran ändern
	#enemy = enemy_array
	pass
	
