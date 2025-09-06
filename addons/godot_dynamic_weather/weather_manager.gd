@tool
extends Node3D
class_name WeatherManager

@export var sun_pivot: Node3D        # Parent-Node für Neigung
@export var sun: DirectionalLight3D  # Das eigentliche Licht

## Debug-Option: Uhr einblenden
@export var show_debug_ui: bool = true

## Wettertypen (werden später genutzt für Übergänge, Effekte usw.)
enum WeatherType { CLEAR, CLOUDY, RAIN, STORM, SNOW, FOG }

## Aktueller Wetterzustand
var current_weather: WeatherType = WeatherType.CLEAR

## Signale für externe Systeme (z. B. Debug-UI, Gameplay)
signal time_changed(time: float)
signal sunrise
signal sunset

## Tageszeit (0.0 = Mitternacht, 12.0 = Mittag, 23.99 = fast Mitternacht)
@export_range(0.0, 24.0, 0.01)
var time_of_day: float = 12.0:
	get:
		return _time_of_day
	set(value):
		_time_of_day = fposmod(value, 24.0)
		_update_sun_rotation()
		emit_signal("time_changed", _time_of_day)

var _time_of_day: float = 12.0

## Soll die Zeit automatisch fortschreiten?
@export var auto_advance: bool = true

## Dauer eines Spieltags in Real-Sekunden (z. B. 600 = 10 Minuten)
@export var seconds_per_day: float = 600.0

## Innere Steuerung
var _paused: bool = false

## Konfigurierbare Auf- und Untergangszeiten
@export_range(0.0, 24.0, 0.1) var sunrise_hour: float = 6.0
@export_range(0.0, 24.0, 0.1) var sunset_hour: float = 18.0
@export_range(0.0, 90.0, 1.0) var max_altitude: float = 60.0

var _was_daytime: bool = false

func _ready() -> void:
	if not sun:
		push_warning("WeatherManager: Sun (DirectionalLight3D) is not assigned.")
	set_process(true)
	if sun_pivot:
		sun_pivot.rotation_degrees.z = 90.0 - max_altitude

	# DebugClock-Sichtbarkeit beim Start steuern
	var debug_ui := get_tree().current_scene.get_node_or_null("DebugGUI")
	if debug_ui:
		debug_ui.visible = show_debug_ui

func _process(delta: float) -> void:
	if not _paused and auto_advance:
		_update_time(delta)

func _update_time(delta: float) -> void:
	if seconds_per_day <= 0.0:
		return
	# Anteil des Tages, der in dieser Frame vergangen ist
	var fraction_of_day := delta / seconds_per_day
	var hours_passed := fraction_of_day * 24.0
	setTimeOfDay(time_of_day + hours_passed)
	_check_sun_events()
	
func _update_sun_rotation() -> void:
	if not sun:
		return
		
	var day_length = sunset_hour - sunrise_hour
	if day_length <= 0.0:
		return

	if time_of_day < sunrise_hour or time_of_day >= sunset_hour:
		# Nacht: 360°–540° → wrap auf 0°–180°
		var night_length = (24.0 - sunset_hour) + sunrise_hour
		var night_progress: float
		if time_of_day >= sunset_hour:
			night_progress = (time_of_day - sunset_hour) / night_length
		else:
			night_progress = (time_of_day + (24.0 - sunset_hour)) / night_length
		var angle = lerp(360.0, 540.0, night_progress)
		sun.rotation_degrees.x = fposmod(angle, 360.0)
	else:
		# Tag: 180° = Sunrise → 360° = Sunset
		var progress = (time_of_day - sunrise_hour) / day_length
		var angle = lerp(180.0, 360.0, progress)
		sun.rotation_degrees.x = angle
				
## Public API
func setTimeOfDay(value: float) -> void:
	time_of_day = value

func setTimescale(day_length_seconds: float) -> void:
	seconds_per_day = max(day_length_seconds, 0.1)

func pause() -> void:
	_paused = true

func resume() -> void:
	_paused = false

## Hilfsfunktion für DebugClock
func get_time_hhmm() -> String:
	var total_minutes := int(round(time_of_day * 60.0)) % (24 * 60)
	var hh := total_minutes / 60
	var mm := total_minutes % 60
	return "%02d:%02d" % [hh, mm]

func _check_sun_events() -> void:
	var is_daytime := time_of_day >= sunrise_hour and time_of_day < sunset_hour
	if is_daytime and not _was_daytime:
		emit_signal("sunrise")
	elif not is_daytime and _was_daytime:
		emit_signal("sunset")
	_was_daytime = is_daytime
