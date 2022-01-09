import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/contacts.dart';
import 'package:lucidum_legalis/database/user_database.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients, Contacts])
class ClientDao extends DatabaseAccessor<UserDatabase> with _$ClientDaoMixin {
  ClientDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertClient(Insertable<Client> client) =>
      into(clients).insert(client);

  Future<int> insertContact(Insertable<Contact> contact) =>
      into(contacts).insert(contact);

  // Reads
  Future<List<Client>> getAll() => select(clients).get();
  Stream<List<Client>> watchAllClients() => select(clients).watch();

  Stream<Client> watchClientById(int id) =>
      (select(clients)..where((client) => client.id.equals(id))).watchSingle();

  Future<Client> getClientById(int id) =>
      (select(clients)..where((client) => client.id.equals(id))).getSingle();

  Future<List<Contact>> getAllContacts(int clientId) =>
      (select(contacts)..where((tbl) => tbl.clientId.equals(clientId))).get();

  Stream<List<Contact>> watchAllContacts(int clientId) =>
      (select(contacts)..where((tbl) => tbl.clientId.equals(clientId))).watch();

  // Updates
  Future<bool> updateClient(Insertable<Client> client) =>
      update(clients).replace(client);

  Future<bool> updateContact(Insertable<Contact> contact) =>
      update(contacts).replace(contact);

  // Deletes
  Future<int> deleteClient(Client client) {
    delete(contacts)
      ..where((tbl) => tbl.clientId.equals(client.id))
      ..go();
    return delete(clients).delete(client);
  }

  Future<int> deleteClientById(int id) {
    delete(contacts)
      ..where((tbl) => tbl.clientId.equals(id))
      ..go();
    return (delete(clients)..where((client) => client.id.equals(id))).go();
  }

  Future<int> deleteContact(Contact contact) =>
      delete(contacts).delete(contact);

  Future<int> deleteContactById(int id) =>
      (delete(contacts)..where((tbl) => tbl.id.equals(id))).go();
}
