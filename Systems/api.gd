extends Node


func create_client() -> void:
	var id := ClientDao.new().insert()
	if id > 0:
		UiSystem.open_client(id)


func create_lawsuite() -> void:
	#TODO: Create lawsuite and open it
	pass
