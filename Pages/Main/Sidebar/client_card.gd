extends Button


var client := ClientDao.new()


func _ready() -> void:
	if client.connect('updated', self, '_on_updated') != OK:
		print_debug('Failed to connect updated signal')
	if client.connect('deleted', self, '_on_deleted') != OK:
		print_debug('Failed to connect deleted signal')


func _on_updated() -> void:
	#TODO: Update fields
	pass


func _on_deleted() -> void:
	queue_free()


func load_client_by_id(id: int) -> void:
	if not client.select_by_id(id):
		print_debug('Invalid Client ID ' + str(id))
		queue_free()
