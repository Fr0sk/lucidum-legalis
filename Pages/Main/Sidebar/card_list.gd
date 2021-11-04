extends VBoxContainer


const ClientCard = preload('res://Pages/Main/Sidebar/ClientCard.tscn')


func _init() -> void:
	if UiSystem.connect('clients_list_requested', self, '_on_clients_list_requested') != OK:
		print_debug('Failed to connect clients_list_requested signal')
	if UiSystem.connect('lawsuites_list_requested', self, '_on_lawsuites_list_requested') != OK:
		print_debug('Failed to connect lawsuites_list_requested signal')


func _on_clients_list_requested() -> void:
	_remove_children()
	var num_cards = rand_range(1, 30)
	for _i in range(num_cards):
		var card = ClientCard.instance()
		add_child(card)


func _on_lawsuites_list_requested() -> void:
	_remove_children()
	var label := Label.new()
	label.text = 'Display lawsuites'
	add_child(label)


func _remove_children() -> void:
	for child in get_children():
		child.queue_free()
