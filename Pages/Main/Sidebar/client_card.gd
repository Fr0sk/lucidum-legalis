extends Button


var _client_dao: ClientDao

onready var _status_color := $HBox/MarginContainer/StatusColor
onready var _selected_border := $SelectedBorder


func init(client_dao: ClientDao) -> Button:
	_client_dao = client_dao
	return self


func _ready() -> void:
	if connect("pressed", self, "_on_pressed") != OK:
		print_debug("Failed to connect pressed signal")
	if _client_dao.connect("updated", self, "_on_updated") != OK:
		print_debug("Failed to connect updated signal")
	if _client_dao.connect("deleted", self, "_on_deleted") != OK:
		print_debug("Failed to connect deleted signal")
	if UiSystem.connect("tab_selected", self, "_on_tab_selected") != OK:
		print_debug("Failed to connect tab_selected signal")
	
	# Get the selected status on creating
	var selected_tab := UiSystem.get_selected_tab() as TabReference
	if selected_tab != null:
		_selected_border.visible = selected_tab.get_dao() == _client_dao


func _on_updated() -> void:
	#TODO: Update fields
	pass


func _on_deleted() -> void:
	queue_free()


func _on_pressed() -> void:
	UiSystem.open_tab(_client_dao)


func _on_tab_selected(_idx: int, ref: TabReference) -> void:
	_selected_border.visible = ref.get_dao() == _client_dao
