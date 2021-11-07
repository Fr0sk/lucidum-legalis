const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")


var sqlite = SQLite.new()
var db_name := "app.db"


func _init() -> void:
	sqlite.path = FileSystem.get_app_folder().get_current_dir() + "/" + db_name
	sqlite.foreign_keys = true
	sqlite.open_db()


func get_schema_version() -> int:
	sqlite.query("PRAGMA schema_version")
	return sqlite.query_result[0]["schema_version"]


func get_user_version() -> int:
	sqlite.query("PRAGMA user_version")
	return sqlite.query_result[0]["user_version"]


func set_user_version(version: int) -> bool:
	return sqlite.query("PRAGMA user_version=" + str(version))


func create_table(table_name: String, table_dictionary: Dictionary) -> bool:
	return sqlite.create_table(table_name, table_dictionary)
