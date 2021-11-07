extends Node


var _app_folder := Directory.new() setget , get_app_folder


func _init() -> void:
	var path = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "/" + ProjectSettings.get_setting("application/config/name")
	if not _app_folder.dir_exists(path):
		if _app_folder.make_dir_recursive(path) != OK:
			print_debug("Error creating application directory")
	if _app_folder.open(path) != OK:
		print_debug("Error opening application directory")


func get_app_folder() -> Directory:
	return _app_folder
