extends Tabs


var _hovered_tab := -1


func _ready() -> void:
	if MainTabSystem.connect('tab_created', self, '_on_tab_created') != OK:
		print_debug('Error connecting signal')
	if MainTabSystem.connect('tab_selected', self, '_on_tab_selected') != OK:
		print_debug('Error connecting signal')
	if MainTabSystem.connect('tab_closed', self, '_on_tab_closed') != OK:
		print_debug('Error connecting signal')


# Adds a new tab when the MainTabSystem creates it
func _on_tab_created(ref: TabReference) -> void:
	add_tab(ref.title, ref.icon)


# Updates the selected tab when the MainTabSystem changes it
func _on_tab_selected(idx: int, _ref: TabReference) -> void:
	set_current_tab(idx)


# Removes the tab when the MainTabSystem closes it 
func _on_tab_closed(idx: int) -> void:
	remove_tab(idx)
	MainTabSystem.select_tab(current_tab)


# Handles the close tab button request
func _on_tab_close(tab: int) -> void:
	MainTabSystem.close_tab(tab)


# Closes the current hovered tab with the middle mouse button
func _on_tabs_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_pressed() && event.button_index == BUTTON_MIDDLE:
		_on_tab_close(_hovered_tab)


# Saves the current tab hovered to handle close requests
func _on_tab_hover(tab: int) -> void:
	_hovered_tab = tab


# Requests the MainTabSystem to change the selected tab
func _on_tab_changed(tab: int) -> void:
	MainTabSystem.select_tab(tab)


# Requests the MainTabSystem to reposition the selected tab to a new index
func _on_reposition_active_tab_request(idx_to: int) -> void:
	MainTabSystem.reposition_selected_tab(idx_to)
