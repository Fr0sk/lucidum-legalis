extends Node

signal tab_created(tab_reference)
signal tab_selected(tab_idx, tab_reference)
signal tab_closed(tab_idx)
signal clients_list_requested()
signal lawsuites_list_requested()
signal create_dialog_requested()
signal tab_ref_updated(tab_idx, tab_reference)

const ClientTabBody := preload("res://Pages/Main/ClientBody/ClientBody.tscn")

var _tabs := []
var _selected_tab := -1
var _create_dialog


func _ready() -> void:
	show_clients_list()


func open_tab(dao: BaseDao, edit_mode: bool = false) -> void:
	if not dao is ClientDao:
		print_debug("Unrecognized DAO type")
		return
	
	# First search for already open tab
	for i in range(_tabs.size()):
		if _tabs[i].get_dao().equals(dao):
			select_tab(i)
			return
	
	# If tab not in stack, open a new one
	var ref = TabReference.new(dao, edit_mode)
	if ref.connect("edit_mode_changed", self, "_on_edit_mode_changed", [ref]) != OK:
		print_debug("Failed to connect signal")
	if ref.get_dao().connect("updated", self, "_on_tab_ref_updated", [ref]) != OK:
		print_debug("Failed to connect signal")
	if ref.get_dao().connect("deleted", self, "_on_dao_deleted", [ref]) != OK:
		print_debug("Failed to connect signal")
	
	_tabs.append(ref)
	emit_signal("tab_created", ref)
	select_tab(_tabs.size() -1)


func close_tab(tab_idx: int) -> void:
	if tab_idx >= 0 && tab_idx < _tabs.size():
		_tabs.remove(tab_idx)
		emit_signal("tab_closed", tab_idx)


func select_tab(tab_idx: int) -> void:
	if tab_idx >= 0 && tab_idx < _tabs.size():
		_selected_tab = tab_idx
		emit_signal("tab_selected", _selected_tab, _tabs[_selected_tab])
	else:
		_selected_tab = -1
		emit_signal("tab_selected", _selected_tab, null)


func find_tab_index(ref: TabReference) -> int:
	return _tabs.find(ref, -1)


func reposition_selected_tab(tab_idx_to: int) -> void:
	if tab_idx_to >= 0 && tab_idx_to < _tabs.size():
		var ref = _tabs[_selected_tab]
		_tabs.remove(_selected_tab)
		_tabs.insert(tab_idx_to, ref)


func get_selected_tab() -> TabReference:
	if _selected_tab >= 0 && _selected_tab < _tabs.size():
		return _tabs[_selected_tab]
	else:
		return null


func show_clients_list() -> void:
	emit_signal("clients_list_requested")


func show_lawsuites_list() -> void:
	emit_signal("lawsuites_list_requested")


func show_create_dialog() -> void:
	emit_signal("create_dialog_requested")


func _on_tab_ref_updated(ref: TabReference) -> void:
	var idx := _tabs.find(ref)
	if idx >= 0:
		emit_signal("tab_ref_updated", idx, ref)


func _on_edit_mode_changed(_edit_mode: bool, ref: TabReference) -> void:
	_on_tab_ref_updated(ref)


func _on_dao_deleted(ref: TabReference) -> void:
	var idx := _tabs.find(ref)
	if idx >= 0:
		close_tab(idx)
