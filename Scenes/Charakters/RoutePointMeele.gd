extends Node2D

@onready var point1 = $Point1.position

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false

func _on_point_1_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click"):
		#print("clicked")
		selected = true
