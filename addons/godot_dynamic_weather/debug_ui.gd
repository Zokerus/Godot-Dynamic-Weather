extends CanvasLayer
class_name DebugGUI

@export var weather_manager: WeatherManager
@onready var lblClock: Label = $MarginContainer/lblClock

func _process(_delta: float) -> void:
	# nur im Debug-Build aktiv
	if not OS.is_debug_build():
		visible = false
		return
	
	if weather_manager and weather_manager.has_method("get_time_hhmm"):
		lblClock.text = weather_manager.get_time_hhmm()
	else:
		lblClock.text = "--:--"

func _unhandled_input(event: InputEvent) -> void:
	# nur im Debug-Build toggelbar
	if OS.is_debug_build() and event.is_action_pressed("toggle_debug_ui"):
		visible = !visible
