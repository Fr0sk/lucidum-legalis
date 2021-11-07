extends Control

enum MenuButtonOptions {EDIT, SAVE, DISCARD, DELETE, CREATE_LAWSUITE}

var _tab_reference: TabReference
var _client_dao: ClientDao

onready var menu_button := $HBoxContainer/PanelContainer/MenuButton


# Custom init function for scenes
func init(tab_reference: TabReference) -> Control:
	_tab_reference = tab_reference
	_client_dao = _tab_reference.get_dao() as ClientDao
	return self


func _ready() -> void:
	if _tab_reference.connect("edit_mode_changed", self, "_on_edit_mode_changed") != OK:
		print_debug("Failed to connect signal")
	_on_edit_mode_changed(_tab_reference.get_edit_mode()) # Sets the default edit mode
	menu_button.get_popup().connect("id_pressed", self, "_on_menu_option_selected")


func get_tab_reference() -> TabReference:
	return _tab_reference


func _str(data, default: String = "") -> String:
	return data if data != null else default


func _on_menu_option_selected(id_pressed: int) -> void:
	match(id_pressed):
		MenuButtonOptions.EDIT:
			_tab_reference.toggle_edit_mode()
		MenuButtonOptions.DISCARD:
			_tab_reference.toggle_edit_mode()
		MenuButtonOptions.SAVE:
			if not Database.update_dao(_client_dao):
				print_debug("Failed to update DAO")
			_tab_reference.toggle_edit_mode()
		MenuButtonOptions.DELETE:
			print_debug("TODO: Implement confirm dialog")
			if not Database.delete_dao(_client_dao):
				print_debug("Failed to update DAO")
		MenuButtonOptions.CREATE_LAWSUITE:
			Api.create_lawsuite(_client_dao.id)


func _on_edit_mode_changed(edit_mode: bool) -> void:
	menu_button.get_popup().set_item_disabled(MenuButtonOptions.EDIT, edit_mode)
	menu_button.get_popup().set_item_disabled(MenuButtonOptions.SAVE, not edit_mode)
	menu_button.get_popup().set_item_disabled(MenuButtonOptions.DISCARD, not edit_mode)
