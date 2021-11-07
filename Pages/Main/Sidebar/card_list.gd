extends VBoxContainer


enum CurrentView {clients, lawsuites}


const ClientCard = preload("res://Pages/Main/Sidebar/ClientCard.tscn")


var _current_view
var _client_daos: Array
var _lawsuite_daos: Array


func _init() -> void:
	_client_daos = ClientDao.new().get_all_rows()
	#TODO: Get all lawsuite daos
	
	if UiSystem.connect("clients_list_requested", self, "_on_clients_list_requested") != OK:
		print_debug("Failed to connect clients_list_requested signal")
	if UiSystem.connect("lawsuites_list_requested", self, "_on_lawsuites_list_requested") != OK:
		print_debug("Failed to connect lawsuites_list_requested signal")
	if Database.connect("dao_inserted", self, "_on_database_dao_inserted") != OK:
		print_debug("Failed to connect dao_inserted signal")


func _on_clients_list_requested() -> void:
	if _current_view == CurrentView.clients:
		return

	_current_view = CurrentView.clients
	_remove_children()
	for client in _client_daos:
		add_child(ClientCard.instance().init(client))


func _on_lawsuites_list_requested() -> void:
	if _current_view == CurrentView.lawsuites:
		return
	
	_current_view = CurrentView.lawsuites
	_remove_children()
	var label := Label.new()
	label.text = "Display lawsuites"
	add_child(label)


func _remove_children() -> void:
	for child in get_children():
		child.queue_free()


func _on_database_dao_inserted(dao: BaseDao) -> void:
	if dao is ClientDao:
		_client_daos.append(dao)
		if _current_view == CurrentView.clients:
			var card = ClientCard.instance().init(dao)
			add_child(card)
		else:
			UiSystem.show_clients_list()
	else:
		print_debug("TODO Implement lawsuite")
