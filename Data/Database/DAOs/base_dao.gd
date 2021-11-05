extends Reference
class_name BaseDao

# Number of properties on base class Reference
const REFERENCE_PROERTY_COUNT = 3


static func get_table_name() -> String:
	return 'Undefined'


signal updated()
signal deleted()


func _init() -> void:
	if Database.connect('updated', self, '_on_database_updated') != OK:
		print_debug('Failed to connect updated signal')
	if Database.connect('deleted', self, '_on_database_deleted') != OK:
		print_debug('Failed to connect deleted signal')


func get_id() -> String:
	return str(get('id'))


func as_dictionary(exclude_id: bool = false) -> Dictionary:
	var dict := {}
	var props := get_property_list()
	for i in range(REFERENCE_PROERTY_COUNT, props.size()):
		if exclude_id && props[i].name == 'id':
			continue
		dict[props[i].name] = get(props[i].name)
	return dict


func from_dictionary(dict: Dictionary) -> void:
	for key in dict.keys():
		set(key, dict[key])


func insert() -> int:
	if Database.insert_row(get_table_name(), as_dictionary(true)):
		return Database.last_insert_rowid()
	else:
		return 0


func select_by_id(id: int) -> bool:
	var rows = Database.select_rows(get_table_name(), 'id=' + str(id))
	if rows.size() > 0:
		from_dictionary(rows[0])
		return true
	else:
		return false


func update() -> bool:
	return Database.update_rows(get_table_name(), 'id=' + get_id(), as_dictionary())


func delete() -> bool:
	#TODO: Disable instead of delete?
	return Database.delete_by_id(get_table_name(), get_id())


func _on_database_updated(table_name: String, id: String) -> void:
	if table_name == get_table_name() && id == get_id():
		emit_signal('updated')


func _on_database_deleted(table_name: String, id: String) -> void:
	if table_name == get_table_name() && id == get_id():
		emit_signal('deleted')
