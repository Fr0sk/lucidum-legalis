extends Button


func _init() -> void:
	if connect("pressed", self, "_on_pressed") != OK:
		print_debug("Error connecting pressed signal")
	if UiSystem.connect("clients_list_requested", self, "_on_show_lawsuites", [false]) != OK:
		print_debug("Error connecting clients_list_requested signal")
	if UiSystem.connect("lawsuites_list_requested", self, "_on_show_lawsuites", [true]) != OK:
		print_debug("Error connecting lawsuites_list_requested signal")


func _on_pressed() -> void:
	UiSystem.show_lawsuites_list()


func _on_show_lawsuites(show_clients: bool) -> void:
	flat = show_clients
	pressed = show_clients
