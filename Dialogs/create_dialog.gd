extends WindowDialog


func _ready() -> void:
	if UiSystem.connect("create_dialog_requested", self, "_on_create_dialog_requested") != OK:
		print_debug("Failed to connect create_dialog_requested signal")


func _on_create_dialog_requested() -> void:
	popup_centered()


func _on_create_client_pressed() -> void:
	Api.create_client()
	visible = false


func _on_create_lawsuite_pressed() -> void:
	Api.create_lawsuite()
	visible = false
