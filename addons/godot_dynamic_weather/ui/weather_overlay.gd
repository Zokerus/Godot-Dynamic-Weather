@tool
extends CanvasLayer

var weather_manager: WeatherManager
var visible_overlay: bool = false

func _ready():
	visible = false
	# WeatherManager automatisch suchen
	var candidates = get_tree().get_nodes_in_group("WeatherManager")
	if candidates.size() > 0:
		weather_manager = candidates[0]

func _process(delta: float) -> void:
	if not weather_manager:
		return
	if not visible:
		return

	$Panel/VBox/TimeLabel.text = "Time: %s" % weather_manager.get_time_hhmm()
	$Panel/VBox/DayLengthLabel.text = "Day Length: %ds" % int(weather_manager.seconds_per_day)
	$Panel/VBox/AdvanceLabel.text = "Auto Advance: %s" % str(weather_manager.auto_advance)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_weather_overlay"):
		visible_overlay = !visible_overlay
		visible = visible_overlay
