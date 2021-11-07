class_name BaseDao
extends Reference

# Number of properties on base class Reference
const REFERENCE_PROERTY_COUNT = 3


static func get_table_name() -> String:
	return "Undefined"


signal updated()
signal deleted()


func get_id() -> String:
	return str(get("id"))


func set_id(id: int) -> void:
	set("id", id)


func updated() -> void:
	emit_signal("updated")


func deleted() -> void:
	emit_signal("deleted")


func as_dictionary(exclude_id: bool = false) -> Dictionary:
	var dict := {}
	var props := get_property_list()
	for i in range(REFERENCE_PROERTY_COUNT, props.size()):
		if exclude_id && props[i].name == "id":
			continue
		dict[props[i].name] = get(props[i].name)
	return dict


func get_all_rows() -> Array:
	var all_rows = []
	var unparsed_rows = Database.select_rows(get_table_name(), "")
	
	for row in unparsed_rows:
		# Creates a new instance of the same class
		var instance = load(get_script().get_path()).new()
		instance.from_dictionary(row)
		all_rows.append(instance)
	return all_rows


func from_dictionary(dict: Dictionary) -> void:
	for key in dict.keys():
		set(key, dict[key])


#func select_by_id(id: int) -> bool:
#	var rows = Database.select_rows(get_table_name(), "id=" + str(id))
#	if rows.size() > 0:
#		from_dictionary(rows[0])
#		return true
#	else:
#		return false


func equals(other_dao) -> bool:
	return (
			other_dao.get_script().get_path() == get_script().get_path() 
			and get_id() == other_dao.get_id()
		)
