extends Node2D

@onready var meele_char = load("res://Scenes/Charakters/Meele.tscn").instantiate()
@onready var point1 = load("res://Scenes/Charakters/RoutePointMeele.tscn").instantiate()
@onready var point2 = load("res://Scenes/Charakters/RoutePointMeele.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
var start_walking = true

var built = false

var start_position
var target_position

func _ready():	
	if built:
		meele_char.built = true
	add_child(meele_char)
	add_child(point1)
	point2.position = point1.position + Vector2(150,0)
	add_child(point2)

	start_position = point1.position
	target_position = point2.position
	return start_position; target_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	meele_char.position = meele_char.position.move_toward(target_position,1.5)
	
	if meele_char.position == target_position:
		#start_walking = false
		target_position = start_position
		
	if meele_char.position == start_position:
		start_position = point1.position
		target_position = point2.position
