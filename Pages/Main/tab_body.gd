extends PanelContainer


func _ready() -> void:
	if UiSystem.connect('tab_selected', self, '_on_tab_selected') != OK:
		print_debug('Error connecting signal')


func _on_tab_selected(_idx: int, ref: TabReference) -> void:
	if ref != null:
		for child in get_children():
			remove_child(child)
		add_child(ref.body)
		visible = true
	else:
		visible = false

