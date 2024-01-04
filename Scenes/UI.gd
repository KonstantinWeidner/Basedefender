extends CanvasLayer

func set_character_preview(character_type, mouse_position):

	var drag_char = load("res://Scenes/Charakters/" + character_type + ".tscn").instantiate()
	drag_char.set_name("DragChar")
	
	var range_texture = Sprite2D.new()
	range_texture.position = Vector2(32,32)
	var scaling = GameData.char_data[character_type]["range"] / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://Assets/UI/RangeIndicator.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ad54ff3c")
	
	var control = Control.new()
	control.add_child(drag_char, true)
	control.add_child(range_texture, true)
	control.position = mouse_position
	control.set_name("CharPreview")
	add_child(control, true)
	move_child(get_node("CharPreview"), 0)

func update_character_preview(new_position):
	get_node("CharPreview").position = new_position
	
