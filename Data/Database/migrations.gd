const DatabaseCore = preload("res://Data/Database/database_core.gd")


static func migrate(db: DatabaseCore) -> bool:
	var success = false
	match db.get_user_version():
		0:
			_v0(db)
			success = db.set_user_version(1)
		_: # Default case: Database is updated
			return true
	
	if success:
		return migrate(db)
	else:
		return success


static func _v0(db: DatabaseCore) -> void:
	if not db.create_table("Clients", {
		"id": {"data_type": "int", "not_null": true, "primary_key": true, "auto_increment": true},
		"name": {"data_type": "text", "not_null": true, "default": "''"},
		"type": {"data_type": "int", "not_null": true, "default": "0"},
		"id_number": {"data_type": "text"},
		"tax_number": {"data_type": "text"},
		"civil_status": {"data_type": "text"},
		"street": {"data_type": "text"},
		"zip_code": {"data_type": "text"},
		"city": {"data_type": "text"},
		"county": {"data_type": "text"}
	}):
		print_debug("Error creating database table")
	
	if not db.create_table("Lawsuites", {
		"id": {"data_type": "int", "not_null": true, "primary_key": true, "auto_increment": true},
		"name": {"data_type": "text", "not_null": true, "default": "''"},
		"state": {"data_type": "int", "not_null": true, "default": "0"},
		"against": {"data_type": "text"},
		"code": {"data_type": "text"},
		"process_number": {"data_type": "text"},
		"district": {"data_type": "text"},
		"court": {"data_type": "text"},
		"judgement": {"data_type": "text"},
		"form": {"data_type": "text"}
	}):
		print_debug("Error creating database table")
	
	if not db.create_table("ClientsLawsuites", {
		"id": {"data_type": "int", "not_null": true, "primary_key": true, "auto_increment": true},
		"client_id": {"data_type": "int", "not_null": true, "foreign_key": "Clients.id"},
		"lawsuite_id": {"data_type": "int", "not_null": true, "foreign_key": "Lawsuites.id"}
	}):
		print_debug("Error creating database table")
	
	if not db.create_table("ClientNotes", {
		"id": {"data_type": "int", "not_null": true, "primary_key": true, "auto_increment": true},
		"title": {"data_type": "text"},
		"content": {"data_type": "text"},
		"client_id": {"data_type": "int", "not_null": true, "foreign_key": "Clients.id"}
	}):
		print_debug("Error creating database table")
	
	if not db.create_table("LawsuiteNotes", {
		"id": {"data_type": "int", "not_null": true, "primary_key": true, "auto_increment": true},
		"title": {"data_type": "text"},
		"content": {"data_type": "text"},
		"lawsuite_id": {"data_type": "int", "not_null": true, "foreign_key": "Lawsuites.id"}
	}):
		print_debug("Error creating database table")
	
	if not db.create_table("Contacts", {
		"id": {"data_type": "int", "not_null": true, "primary_key": true, "auto_increment": true},
		"type": {"data_type": "int", "not_null": true, "default": "0"},
		"contact": {"data_type": "text"},
		"client_id": {"data_type": "int", "not_null": true, "foreign_key": "Clients.id"}
	}):
		print_debug("Error creating database table")

