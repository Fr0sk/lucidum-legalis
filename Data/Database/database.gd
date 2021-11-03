extends Node


const DatabaseCore = preload('res://Data/Database/database_core.gd')
const Migrations = preload('res://Data/Database/migrations.gd')


onready var _db: DatabaseCore


func _ready() -> void:
	_db = DatabaseCore.new()
	if not Migrations.migrate(_db):
		#TODO: Show error message dialog
		print_debug('Migration Failed. Abort!')
		get_tree().quit()


func insert_row(table: String, row: Dictionary) -> bool:
	return _db.sqlite.insert_row(table, row)


func select_rows(table: String, conditions: String, selected_columns: Array = ["*"]) -> Array:
	return _db.sqlite.select_rows(table, conditions, selected_columns)


func update_rows(table: String, conditions: String, row: Dictionary) -> bool:
	return _db.sqlite.update_rows(table, conditions, row)


func delete_rows(table: String, conditions: String) -> bool:
	return _db.sqlite.delete_rows(table, conditions)
