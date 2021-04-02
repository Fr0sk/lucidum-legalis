import 'package:lucidum_legalis/database/database.dart';
import 'package:moor/moor.dart';

part 'clients.g.dart';

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get idNumber => text().nullable()();
  TextColumn get taxNumber => text().nullable()();
  TextColumn get civilStatus => text().nullable()();
  // Address
  TextColumn get street => text().nullable()();
  TextColumn get zipCode => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get district => text().nullable()();
}

@UseDao(tables: [Clients])
class ClientDao extends DatabaseAccessor<AppDatabase> with _$ClientDaoMixin {
  ClientDao(AppDatabase db) : super(db);

  Future<List<Client>> getAllClients() => select(clients).get();
  Stream<List<Client>> watchAllClients() => select(clients).watch();

  Future<Client> getClient(int id) =>
      (select(clients)..where((t) => t.id.equals(id))).getSingle();

  Future<int> createClient(ClientsCompanion client) =>
      into(clients).insert(client);

  /*Future<void> createOrUpdateUser(Insertable<Client> client) =>
      into(client).insertOnConflictUpdate(client);*/
}
