extends Node2D

var HP = 10
var miner = load("res://Scenes/Charakters/Miner.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
var healthbar
var miner_in_range = false

func _ready():
	healthbar = $Healthbar
	healthbar.visible = false
	 # Replace with function body.
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Miner"):
		print("miner in range")

func preserve_gold():
	miner_in_range = false
func destruct_gold():
	miner_in_range = true

func destroy_gold():
	healthbar.visible = true
	while miner_in_range:
		healthbar.value = HP
		await get_tree().create_timer(1.0).timeout
		HP -= 1
		GameData.money += 10
		if HP == 0:
			queue_free()	
