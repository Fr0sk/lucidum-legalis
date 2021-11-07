extends Node


func create_client() -> void:
	var client_dao := ClientDao.new()
	if Database.insert_dao(client_dao):
		UiSystem.open_tab(client_dao, true) # Open a new tab in edit mode


func create_lawsuite() -> void:
	#TODO: Create lawsuite and open it
	pass
