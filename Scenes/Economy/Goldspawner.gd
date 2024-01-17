extends Node2D

@onready var excluded_shape: CollisionShape2D = $ExcludedArea/ExcludedShape

var spawn_interval: float = randf_range(7, 12)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(spawn_interval)
	#print("added gs")
	spawn_gold() #starting gold 
	spawn_gold()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func spawn_gold():
	var gold_spawn_point: Vector2

	if excluded_shape:
		#var excluded_rect = Rect2(660, 360, 1300, 730)# excluded area
		while true:
			var rand_x = randi_range(10, 1250)
			var rand_y = randi_range(10, 700)
			gold_spawn_point = Vector2(rand_x, rand_y)
			if(rand_x < 250 || rand_x > 1000)&&(rand_y<100 || rand_y > 500):
				break
	else:
		print("Error: ExcludedShape not found.")
		
	var gold_instance = load("res://Scenes/Economy/Gold.tscn").instantiate()
	gold_instance.position = gold_spawn_point #fixbar durch übergabe des rand spawnpunkts in spawn grpup und dann hier nur minimale manipulation am wert
	#print (enemy_instance.speed)
	#print (enemy_instance.position)
	add_child(gold_instance)

func _on_timer_timeout():
	spawn_gold()
	#print("gold spawned")
