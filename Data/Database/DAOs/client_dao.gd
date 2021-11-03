extends BaseDao
class_name ClientDao

enum ClientType { person, company }

var id: int = 0
var name: String = ''
var type: int = ClientType.person
var idNumber: String
var taxNumber: String
var civilStatus: String
var street: String
var zipCode: String
var city: String
var county: String

func get_table_name() -> String:
	return 'Clients'
