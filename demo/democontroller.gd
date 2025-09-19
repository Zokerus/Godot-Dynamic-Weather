extends Node3D
class_name DemoController

var weather_manager: WeatherManager

func _ready():
	var candidates = get_tree().get_nodes_in_group("WeatherManager")
	if candidates.size() > 0:
		weather_manager = candidates[0]

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_demo"):
		get_tree().quit()
