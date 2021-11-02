extends Node


signal tab_created(tab_reference)
signal tab_selected(tab_idx, tab_reference)
signal tab_closed(tab_idx)


var _tabs := []
var _selected_tab := -1


var _id := 0
func open_client(id: int) -> void:
	var ref = TabReference.new()
	ref.id = _id
	ref.title = 'Tab #'+ str(_id)
	var body = Label.new()
	body.text = 'This is tab with id: ' + str(_id)
	ref.body = body
	_id += 1
	
	_tabs.append(ref)
	emit_signal('tab_created', ref)
	select_tab(_tabs.size() - 1)


func open_lawsuite(id: int) -> void:
	pass


func close_tab(tab_idx: int) -> void:
	if tab_idx >= 0 && tab_idx < _tabs.size():
		_tabs.remove(tab_idx)
		emit_signal('tab_closed', tab_idx)


func select_tab(tab_idx: int) -> void:
	if tab_idx >= 0 && tab_idx < _tabs.size():
		_selected_tab = tab_idx
		emit_signal('tab_selected', _selected_tab, _tabs[_selected_tab])
	else:
		_selected_tab = -1
		emit_signal('tab_selected', _selected_tab, null)


func reposition_selected_tab(tab_idx_to: int) -> void:
	if tab_idx_to >= 0 && tab_idx_to < _tabs.size():
		var ref = _tabs[_selected_tab]
		_tabs.remove(_selected_tab)
		_tabs.insert(tab_idx_to, ref)


