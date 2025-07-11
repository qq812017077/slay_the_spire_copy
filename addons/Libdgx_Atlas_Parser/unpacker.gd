@tool
extends EditorPlugin

var panel: Panel

const AUTOLOAD_NAME = "libdgx_atlas_parser"
func _enable_plugin() -> void:
	# Add autoloads here.
	return 

func _disable_plugin() -> void:
	# Remove autoloads here.
	return


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	panel = preload("res://addons/Libdgx_Atlas_Parser/atlas_parser.tscn").instantiate()
	panel.editor_interface = get_editor_interface()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, panel)
	return

func _exit_tree() -> void:
#	pass
	# Clean-up of the plugin goes here.
	remove_control_from_docks(panel)
	panel.queue_free()
	return 
