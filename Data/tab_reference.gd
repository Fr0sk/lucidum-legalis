extends Reference
class_name TabReference

enum TabType {CLIENT, LAWSUITE}


export var id: int
export var title: String
export var icon: Texture
var body: Control
var tab_type: int

func _init(type: int) -> void:
	self.tab_type = type
