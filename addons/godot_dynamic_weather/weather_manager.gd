@tool
extends Node3D
class_name WeatherManager

@export var sun: DirectionalLight3D

## Debug-Option: Uhr einblenden
@export var show_debug_ui: bool = true

## Wettertypen (werden später genutzt für Übergänge, Effekte usw.)
enum WeatherType { CLEAR, CLOUDY, RAIN, STORM, SNOW, FOG }

## Aktueller Wetterzustand
var current_weather: WeatherType = WeatherType.CLEAR

## Tageszeit (0.0 = Mitternacht, 12.0 = Mittag, 23.99 = fast Mitternacht)
var _time_of_day := 12.0
@export_range(0.0, 24.0, 0.01)
var time_of_day: float:
	get:
		return _time_of_day
	set(value):
		_time_of_day = value
		_update_sun_rotation()

## Geschwindigkeit, mit der der Tag vergeht (z. B. 60 = 1 Echtsekunde = 1 Minute im Spiel)
@export var time_scale := 60.0

## Innere Zeitvariable für laufende Simulation
var _time_accumulator := 0.0

func _ready() -> void:
	if not sun:
		push_warning("WeatherManager: Sun (DirectionalLight3D) is not assigned.")
	set_process(true)
	# DebugClock-Sichtbarkeit beim Start steuern
	var debug_ui := get_tree().current_scene.get_node_or_null("DebugGUI")
	if debug_ui:
		debug_ui.visible = show_debug_ui

func _process(delta: float) -> void:
	_update_time(delta)
	_update_sun_rotation()

func _update_time(delta: float) -> void:
	_time_accumulator += delta * time_scale
	var time_increment = _time_accumulator / 60.0  # Minuten in Stunden umrechnen
	_time_accumulator -= time_increment * 60.0
	time_of_day = fmod(time_of_day + time_increment, 24.0)

func _update_sun_rotation() -> void:
	if not sun:
		return

	# Tageszeit auf Winkel (0° = Mitternacht, 180° = Mittag)
	var angle := (time_of_day / 24.0) * 360.0 + 90
	sun.rotation_degrees.x = angle

## Hilfsfunktion für DebugClock
func get_time_hhmm() -> String:
	var total_minutes := int(round(time_of_day * 60.0)) % (24 * 60)
	var hh := total_minutes / 60
	var mm := total_minutes % 60
	return "%02d:%02d" % [hh, mm]
