extends Reference
class_name BaseDao

# Number of properties on base class Reference
const REFERENCE_PROERTY_COUNT = 3


func get_table_name() -> String:
	return 'Undefined'


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


func insert() -> bool:
	return Database.insert_row(get_table_name(), as_dictionary(true))


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
	return Database.delete_rows(get_table_name(), 'id=' + get_id())
