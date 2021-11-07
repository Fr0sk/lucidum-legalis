tool
class_name ResponsiveGridContainer
extends GridContainer


export var break_point: int = 576 setget set_break_point
export var s_cols: int = 1 setget set_s_cols
export var l_cols: int = 2 setget set_l_cols


func _ready() -> void:
	if connect("item_rect_changed", self, "_redraw") != OK:
		print_debug("Failed to connectt item_rect_changed signal")


func set_break_point(new_break_point: int) -> void:
	break_point = new_break_point
	_redraw()


func set_s_cols(new_s_cols: int) -> void:
	s_cols = new_s_cols
	_redraw()


func set_l_cols(new_l_cols: int) -> void:
	l_cols = new_l_cols
	_redraw()


func _redraw() -> void:
	if get_rect().size.x < break_point:
		columns = s_cols
	else:
		columns = l_cols
