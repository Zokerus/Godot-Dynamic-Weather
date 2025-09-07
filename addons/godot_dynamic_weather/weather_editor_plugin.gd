# Datei: addons/godot_dynamic_weather/weather_editor_plugin.gd
@tool
extends EditorPlugin

var dock

func _enter_tree():
	# Dock-Szene laden
	dock = preload("res://addons/godot_dynamic_weather/ui/WeatherDock.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)

func _exit_tree():
	if dock:
		remove_control_from_docks(dock)
		dock.free()
