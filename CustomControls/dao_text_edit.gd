tool
class_name DaoTextEdit
extends TextEdit

export(String) var dao_key: String
export(String) var get_tab_reference_method_name := "get_tab_reference"


var _tab_ref: TabReference


func _ready() -> void:
	# Gets the TabReference reference
	var parent := _find_parent_with_get_tab_reference_method(get_parent())
	if parent == null:
		print_debug("Failed to find a parent with " + get_tab_reference_method_name + " method")
		return
	_tab_ref = parent.call(get_tab_reference_method_name) as TabReference
	
	# Setup the signals for updating
	if _tab_ref.connect("edit_mode_changed", self, "_on_edit_mode_changed") != OK:
		print_debug("Failed to connect signal")
	if _tab_ref.get_dao().connect("updated", self, "_load_data_from_dao") != OK:
		print_debug("Failed to connect signal")
	if _tab_ref.get_dao().connect("update_requested", self, '_on_dao_update_requested') != OK:
		print_debug("Failed to connect signal")
	
	# Initializes the field
	readonly = not _tab_ref.get_edit_mode()
	_load_data_from_dao()


# Finds the closest parent with the get_tab_reference_method_name method
func _find_parent_with_get_tab_reference_method(node: Node) -> Node:
	if node.has_method(get_tab_reference_method_name):
		return node
	else:
		if node != get_tree().root:
			return _find_parent_with_get_tab_reference_method(node.get_parent())
		else:
			return null


func _on_edit_mode_changed(edit_mode: bool) -> void:
	_load_data_from_dao()
	readonly = not edit_mode


func _load_data_from_dao() -> void:
	var new_text = _tab_ref.get_dao().get(dao_key)
	if new_text != null and new_text is String:
		text = new_text


# Updates the DAO field before saving
func _on_dao_update_requested() -> void:
	_tab_ref.get_dao().set(dao_key, text)
