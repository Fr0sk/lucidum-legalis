extends Node


func create_client() -> void:
	var client_dao := ClientDao.new()
	if Database.insert_dao(client_dao):
		UiSystem.open_tab(client_dao, true) # Open a new tab in edit mode


func create_lawsuite(client_id: int = -1) -> void:
	#TODO: Create lawsuite
	if client_id >= 0:
		#TODO: Associate lawsuite with client
		pass
	#TODO: Open lawsuite
