class_name SaveHelper
extends Object

static func initialize() -> void:
	# This function is called to initialize the SaveHelper.
	# It can be used to set up any necessary state or configurations.
	pass

	
static func get_save_dir() -> String:
	# Returns the directory where save files are stored.
	if Settings.isBeta:
		return "user://save_beta/"

	return "user://save/"
	
static func get_config(name) -> ConfigFile:
	var config_path = get_save_dir() + name + ".json"
	var config = ConfigFile.new()
	if config.load(config_path) != OK:
		push_error("Failed to load config file: " + config_path)
		return null
	
	return config
	
