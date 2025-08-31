extends Node3D
class_name DemoController

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_demo"):
		get_tree().quit()
