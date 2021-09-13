import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'client_dao.g.dart';

@UseDao(tables: [Clients])
class ClientDao extends DatabaseAccessor<UserDatabase> with _$ClientDaoMixin {
  ClientDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertClient(Insertable<Client> client) =>
      into(clients).insert(client);

  // Reads
  Stream<List<Client>> watchAllClients() => select(clients).watch();

  Stream<Client> watchClientById(int id) =>
      (select(clients)..where((client) => client.id.equals(id))).watchSingle();

  Future<Client> getClientById(int id) =>
      (select(clients)..where((client) => client.id.equals(id))).getSingle();

  // Updates
  Future<bool> updateClient(Insertable<Client> client) =>
      update(clients).replace(client);

  // Deletes
  Future<int> deleteClient(Client client) => delete(clients).delete(client);

  Future<int> deleteClientById(int id) =>
      (delete(clients)..where((client) => client.id.equals(id))).go();
}
