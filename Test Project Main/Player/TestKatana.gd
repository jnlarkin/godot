extends Sprite

onready var character = get_node("Player/Medieval-Sheet")


	# look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		move_to_mouse()
		
func move_to_mouse() -> void:
	var tween := create_tween()
	var target_rotation = 0.7
	var sword_position = Vector2.ZERO
	
	tween.tween_property(character, "rotation", target_rotation, 0.1)
	tween.tween_property(character, "global_position", global_position+Vector2(8,0), 0.1)
	tween.tween_property(character, "global_position", global_position+Vector2(-0.02,0), 0.1)
	
	tween.tween_property(self, "rotation", 0.1, 0.1)
	
