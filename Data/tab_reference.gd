class_name TabReference
extends Reference

const ClientIcon := preload("res://Assets/Icons/client.svg")
const ClientEditIcon := preload("res://Assets/Icons/client-edit.svg")

signal edit_mode_changed(edit_mode)

var title: String
var icon: Texture

var _body: Control setget , get_body
var _dao: BaseDao setget , get_dao
var _edit_mode: bool setget set_edit_mode, get_edit_mode


func _init(dao: BaseDao, edit_mode: bool) -> void:
	_dao = dao
	_edit_mode = edit_mode
	_load_data_from_dao()


func get_dao() -> BaseDao:
	return _dao


func get_body() -> Control:
	return _body


func set_edit_mode(edit_mode: bool) -> void:
	if edit_mode != _edit_mode:
		_edit_mode = edit_mode
		_load_data_from_dao()
		emit_signal("edit_mode_changed", _edit_mode)


func get_edit_mode() -> bool:
	return _edit_mode


func toggle_edit_mode() -> void:
	set_edit_mode(not _edit_mode)


func _load_data_from_dao() -> void:
	if _dao is ClientDao:
		_load_client(_dao as ClientDao)


func _load_client(client_dao: ClientDao) -> void:
	if _edit_mode:
		title = client_dao.name + "(*)"
		icon = ClientEditIcon
	else:
		title = client_dao.name
		icon = ClientIcon
	_body = UiSystem.ClientTabBody.instance().init(self)
