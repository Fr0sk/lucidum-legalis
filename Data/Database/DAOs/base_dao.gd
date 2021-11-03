extends Reference
class_name BaseDao

# Number of properties on base class Reference
const REFERENCE_PROERTY_COUNT = 3


func get_table_name() -> String:
	return 'Undefined'

func as_dictionary(exclude_id: bool = false) -> Dictionary:
	var dict := {}
	var props := get_property_list()
	for i in range(REFERENCE_PROERTY_COUNT, props.size()):
		if exclude_id && props[i].name == 'id':
			continue
		dict[props[i].name] = get(props[i].name)
	return dict


func insert() -> bool:
	return Database.insert_row(get_table_name(), as_dictionary(true))
