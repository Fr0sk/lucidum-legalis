class_name ClientDao
extends BaseDao


enum ClientType { person, company }


static func get_table_name() -> String:
	return "Clients"


var id: int = 0
var name: String = tr("New Client")
var type: int = ClientType.person
var id_number: String 
var tax_number: String
var civil_status: String
var street: String
var zip_code: String
var city: String
var county: String
