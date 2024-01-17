extends Node2D

var built = false
var new_position
var speed = 100

var miner_on_goldspot = false
var direction = Vector2(1,1)

var gold_HP = 10
var miner_HP = 10

var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if built:
		$Area2D/RangeIndicator.visible = false
		return true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 2 * delta)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false

func _on_area_2d_body_entered(body):
	if built:
		if body.is_in_group("Gold"):
			#direction = (body.position - position).normalized() #ziel suche
			body.destruct_gold()
			body.destroy_gold()

func _on_area_2d_body_exited(body):
	if body.is_in_group("Gold"):
		miner_on_goldspot = false
		body.preserve_gold()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click"):
		#print("clicked")
		selected = true


func _on_search_radius_body_entered(body):
	if body.is_in_group("Enemy"):
		#print("enemy near")
		body.position.move_toward(Vector2(1,1), 1)

func attacked():
	miner_HP -= 1
	#print("Miner Hp", miner_HP)
	if miner_HP == 0:
		queue_free()



func _on_area_2d_mouse_entered():
	$Area2D/RangeIndicator.visible = true


func _on_area_2d_mouse_exited():
	$Area2D/RangeIndicator.visible = false
