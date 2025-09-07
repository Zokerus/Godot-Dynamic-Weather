@tool
extends EditorPlugin

var dock

func _enter_tree():
	# Dock laden
	dock = preload("res://addons/godot_dynamic_weather/ui/WeatherDock.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)

	# Szene-Wechsel beobachten (EditorPlugin hat dieses Signal!)
	scene_changed.connect(_on_scene_changed)

	# Falls schon eine Szene offen ist, direkt binden
	if get_tree().current_scene:
		_on_scene_changed(get_tree().current_scene)

func _exit_tree():
	if dock:
		remove_control_from_docks(dock)
		dock.free()
		dock = null

func _on_scene_changed(scene: Node):
	if dock:
		dock.bind_weather_manager()
