extends VBoxContainer


enum CurrentView {clients, lawsuites}


const ClientCard = preload('res://Pages/Main/Sidebar/ClientCard.tscn')


var _current_view


func _init() -> void:
	if UiSystem.connect('clients_list_requested', self, '_on_clients_list_requested') != OK:
		print_debug('Failed to connect clients_list_requested signal')
	if UiSystem.connect('lawsuites_list_requested', self, '_on_lawsuites_list_requested') != OK:
		print_debug('Failed to connect lawsuites_list_requested signal')
	if Database.connect('inserted', self, '_on_database_inserted') != OK:
		print_debug('Failed to connect inserted signal')


func _on_clients_list_requested() -> void:
	_current_view = CurrentView.clients
	_remove_children()
	var clients = ClientDao.new().get_all_rows()
	for client in clients:
		var card := ClientCard.instance()
		card.load_client_by_id(client.id)
		if  card.connect("pressed", self, "_on_client_pressed", [client.id]) != OK:
			print_debug("Failed to connect pressed signal")
		add_child(card)
	
	# TODO Load all client cards
	#var num_cards = rand_range(1, 30)
	#for _i in range(num_cards):
	#	var card = ClientCard.instance()
	#	add_child(card)


func _on_lawsuites_list_requested() -> void:
	_current_view = CurrentView.lawsuites
	_remove_children()
	var label := Label.new()
	label.text = 'Display lawsuites'
	add_child(label)


func _remove_children() -> void:
	for child in get_children():
		child.queue_free()


func _on_database_inserted(table_name: String, id: int) -> void:
	if _current_view == CurrentView.clients and table_name == ClientDao.get_table_name():
		var card := ClientCard.instance()
		card.load_client_by_id(id)
		add_child(card)
		
	#elif _current_view == CurrentView.lawsuites and table_name == ClientDao.get_table_name():
	else:
		print_debug('TODO Implement lawsuite')


func _on_client_pressed(id: int) -> void:
	UiSystem.open_client(id)
