extends Node


const DatabaseCore = preload('res://Data/Database/database_core.gd')
const Migrations = preload('res://Data/Database/migrations.gd')


signal inserted(table_name, inserted_id)
signal updated(table_name, row_id)
signal deleted(table_name, row_id)


onready var _db: DatabaseCore


func _ready() -> void:
	_db = DatabaseCore.new()
	if not Migrations.migrate(_db):
		#TODO: Show error message dialog
		print_debug('Migration Failed. Abort!')
		get_tree().quit()


func insert_row(table: String, row: Dictionary) -> bool:
	var ok = _db.sqlite.insert_row(table, row)
	if ok:
		emit_signal('inserted', table, last_insert_rowid())
	return ok


func select_rows(table: String, conditions: String, selected_columns: Array = ['*']) -> Array:
	return _db.sqlite.select_rows(table, conditions, selected_columns)


func update_rows(table: String, conditions: String, row: Dictionary) -> bool:
	var ok = _db.sqlite.update_rows(table, conditions, row)
	if ok:
		emit_signal('updated', table, row.get('id'))
	return ok


func delete_rows(table: String, conditions: String) -> bool:
	var ok = _db.sqlite.delete_rows(table, conditions)
	if ok:
		emit_signal('deleted', table, null)
	return ok


func delete_by_id(table: String, id: String) -> bool:
	var ok = _db.sqlite.delete_rows(table, 'id=' + id)
	if ok:
		emit_signal('deleted', table, id)
	return ok


func last_insert_rowid() -> int:
	return _db.sqlite.last_insert_rowid
