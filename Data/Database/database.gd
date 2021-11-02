extends Node


const DatabaseCore = preload('res://Data/Database/database_core.gd')
const Migrations = preload('res://Data/Database/migrations.gd')


onready var _db: DatabaseCore


func _ready() -> void:
	_db = DatabaseCore.new()
	print('Schema: ' + str(_db.get_user_version()))
	Migrations.migrate(_db)
	print('Schema: ' + str(_db.get_user_version()))
