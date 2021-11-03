extends Node


const DatabaseCore = preload('res://Data/Database/database_core.gd')
const Migrations = preload('res://Data/Database/migrations.gd')


onready var _db: DatabaseCore


func _ready() -> void:
	_db = DatabaseCore.new()
	Migrations.migrate(_db)


func insert_row(table: String, row: Dictionary) -> bool:
	return _db.sqlite.insert_row(table, row)
