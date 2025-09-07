@tool
extends VBoxContainer

var weather_manager: WeatherManager

func bind_weather_manager():
	# Suche global im SceneTree nach WeatherManager-Instanzen
	var candidates = get_tree().get_nodes_in_group("WeatherManager")
	if candidates.size() > 0:
		weather_manager = candidates[0]
		print("WeatherDock: bound to WeatherManager: %s" % weather_manager.name)
		_setup_ui()
	else:
		weather_manager = null
		print("WeatherDock: no WeatherManager found in scene")

func _setup_ui():
	if not weather_manager:
		return

	$TimeSlider.value = weather_manager.time_of_day
	$ToggleAdvance.button_pressed = weather_manager.auto_advance
	$TimeScale.value = weather_manager.seconds_per_day
	_update_time_label(weather_manager.time_of_day)

	# Signale verbinden (nur einmal!)
	if not $TimeSlider.value_changed.is_connected(_on_slider_changed):
		$TimeSlider.value_changed.connect(_on_slider_changed)
		$Buttons/BtnDawn.pressed.connect(func(): weather_manager.setTimeOfDay(6))
		$Buttons/BtnNoon.pressed.connect(func(): weather_manager.setTimeOfDay(12))
		$Buttons/BtnDusk.pressed.connect(func(): weather_manager.setTimeOfDay(18))
		$Buttons/BtnNight.pressed.connect(func(): weather_manager.setTimeOfDay(0))
		$ToggleAdvance.toggled.connect(_on_toggle_auto_advance)
		$TimeScale.value_changed.connect(_on_timescale_changed)
		weather_manager.time_changed.connect(_update_time_label)

func _on_slider_changed(value: float) -> void:
	if weather_manager:
		weather_manager.setTimeOfDay(value)

func _on_toggle_auto_advance(value: bool) -> void:
	if weather_manager:
		weather_manager.auto_advance = value

func _on_timescale_changed(value: float) -> void:
	if weather_manager:
		weather_manager.setTimescale(value)

func _update_time_label(time: float) -> void:
	if $TimeLabel and weather_manager:
		$TimeLabel.text = "Time: %s" % weather_manager.get_time_hhmm()
