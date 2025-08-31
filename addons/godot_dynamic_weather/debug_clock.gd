extends CanvasLayer
class_name DebugClock

@export var weather_manager: WeatherManager
@onready var lblClock: Label = $MarginContainer/lblClock

func _process(_delta: float) -> void:
	if weather_manager and weather_manager.has_method("get_time_hhmm"):
		lblClock.text = weather_manager.get_time_hhmm()
	else:
		lblClock.text = "--:--"
