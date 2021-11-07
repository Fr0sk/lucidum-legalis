extends Button


func _init() -> void:
	if connect("pressed", self, "_on_pressed") != OK:
		print_debug("Error connecting pressed signal")
	if UiSystem.connect("clients_list_requested", self, "_on_show_clients", [true]) != OK:
		print_debug("Error connecting clients_list_requested signal")
	if UiSystem.connect("lawsuites_list_requested", self, "_on_show_clients", [false]) != OK:
		print_debug("Error connecting lawsuites_list_requested signal")


func _on_pressed() -> void:
	UiSystem.show_clients_list()


func _on_show_clients(show_clients: bool) -> void:
	flat = show_clients
	pressed = show_clients
