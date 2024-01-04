extends CharacterBody2D

var speed = 100  # Geschwindigkeit des Gegners
var target_position: Vector2

func _ready():
	# Setze das Ziel für den Gegner
	target_position = get_parent().enemy_spawn_point

func _process(delta):
	# Berechne die Richtung zum Ziel
	var direction = (target_position - position).normalized()

	# Bewege den Gegner in Richtung des Ziels
	move_and_slide()
