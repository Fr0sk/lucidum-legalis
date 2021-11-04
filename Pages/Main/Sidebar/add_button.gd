extends Button


func _ready() -> void:
	if connect('pressed', self, '_on_pressed') != OK:
		print_debug('Failed to connect pressed signal')


func _on_pressed() -> void:
	UiSystem.show_create_dialog()
