extends Node


const DatabaseCore = preload("res://Data/Database/database_core.gd")
const Migrations = preload("res://Data/Database/migrations.gd")


signal dao_inserted(dao)


onready var _db: DatabaseCore


func _init() -> void:
	_db = DatabaseCore.new()
	if not Migrations.migrate(_db):
		#TODO: Show error message dialog
		print_debug("Migration Failed. Abort!")
		get_tree().quit()


func select_rows(table: String, conditions: String, selected_columns: Array = ["*"]) -> Array:
	return _db.sqlite.select_rows(table, conditions, selected_columns)


func insert_dao(dao: BaseDao) -> bool:
	var ok = _db.sqlite.insert_row(dao.get_table_name(), dao.as_dictionary(true))
	if ok:
		dao.set_id(last_insert_rowid())
		emit_signal("dao_inserted", dao)
	return ok


func update_dao(dao: BaseDao) -> bool:
	dao.update_requested()
	var ok = _db.sqlite.update_rows(
			dao.get_table_name(), 
			"id=" + dao.get_id(), 
			dao.as_dictionary()
		)
	if ok:
		dao.updated()
	return ok


func delete_dao(dao: BaseDao) -> bool:
	dao.delete_requested()
	var ok = _db.sqlite.delete_rows(dao.get_table_name(), "id=" + dao.get_id())
	if ok:
		dao.deleted()
	return ok


func last_insert_rowid() -> int:
	return _db.sqlite.last_insert_rowid
