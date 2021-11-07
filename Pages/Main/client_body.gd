extends Control

var _tab_reference: TabReference
var _client_dao: ClientDao


onready var te_name := find_node("*TeName") as TextEdit
onready var te_id_number := find_node("*TeIdNumber") as TextEdit
onready var te_tax_number := find_node("*TeTaxNumber") as TextEdit
onready var te_civil_status := find_node("*TeCivilStatus") as TextEdit
onready var te_street := find_node("*TeStreet") as TextEdit
onready var te_zip_code := find_node("*TeZipCode") as TextEdit
onready var te_city := find_node("*TeCity") as TextEdit
onready var te_county := find_node("*TeCounty") as TextEdit


# Custom init function for scenes
func init(tab_reference: TabReference) -> Control:
	_tab_reference = tab_reference
	_client_dao = _tab_reference.get_dao() as ClientDao
	return self


func _ready() -> void:
	_populate_fields_from_dao()
	_set_edit_mode(_tab_reference.get_edit_mode())


func _set_edit_mode(is_in_edit_mode: bool) -> void:
	te_name.readonly = not is_in_edit_mode
	te_id_number.readonly = not is_in_edit_mode
	te_tax_number.readonly = not is_in_edit_mode
	te_civil_status.readonly = not is_in_edit_mode
	te_street.readonly = not is_in_edit_mode
	te_zip_code.readonly = not is_in_edit_mode
	te_city.readonly = not is_in_edit_mode
	te_county.readonly = not is_in_edit_mode


func _populate_fields_from_dao() -> void:
	te_name.text = _client_dao.name
	te_id_number.text = _client_dao.id_number
	te_tax_number.text = _client_dao.tax_number
	te_civil_status.text = _client_dao.civil_status
	te_street.text = _client_dao.street
	te_zip_code.text = _client_dao.zip_code
	te_city.text = _client_dao.city
	te_county.text = _client_dao.county


func _str(data, default: String = "") -> String:
	return data if data != null else default
