class_name TabReference
extends Reference

signal edit_mode_changed(edit_mode)

export var title: String
export var icon: Texture

var _body: Control setget , get_body
var _dao: BaseDao setget , get_dao
var _edit_mode: bool setget set_edit_mode, get_edit_mode


func _init(dao: BaseDao, edit_mode: bool) -> void:
	_dao = dao
	_edit_mode = edit_mode
	
	if dao is ClientDao:
		title = dao.name
		_body = UiSystem.ClientTabBody.instance().init(self)


func get_dao() -> BaseDao:
	return _dao


func get_body() -> Control:
	return _body


func set_edit_mode(edit_mode: bool) -> void:
	if edit_mode != _edit_mode:
		_edit_mode = edit_mode
		emit_signal("edit_mode_changed", _edit_mode)


func get_edit_mode() -> bool:
	return _edit_mode
