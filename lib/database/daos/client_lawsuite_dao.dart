import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';

import '../tables/clients_lawsuites.dart';

part 'client_lawsuite_dao.g.dart';

@DriftAccessor(tables: [ClientsLawsuites, Lawsuites, Clients])
class ClientLawsuiteDao extends DatabaseAccessor<UserDatabase>
    with _$ClientLawsuiteDaoMixin {
  ClientLawsuiteDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertAssociation(Insertable<ClientLawsuite> clientLawsuite) =>
      into(clientsLawsuites).insert(clientLawsuite);

  // Reads
  Stream<List<ClientLawsuite>> watchAllAssociations() =>
      select(clientsLawsuites).watch();

  Stream<List<ClientLawsuite>> watchAssociationsByClientId(int clientId) =>
      (select(clientsLawsuites)..where((row) => row.clientId.equals(clientId)))
          .watch();

  Stream<List<ClientLawsuite>> watchAssociationsByLawsuiteId(int lawsuiteId) =>
      (select(clientsLawsuites)
            ..where((row) => row.clientId.equals(lawsuiteId)))
          .watch();

  Stream<List<Lawsuite>> watchLawsuitesByClientId(int clientId) {
    final query = (select(clientsLawsuites)
          ..where((row) => row.clientId.equals(clientId)))
        .join([
      innerJoin(lawsuites, lawsuites.id.equalsExp(clientsLawsuites.lawsuiteId))
    ]);

    return query
        .watch()
        .map((rows) => rows.map((row) => row.readTable(lawsuites)).toList());
  }

  Stream<List<Client>> watchClientsByLawsuiteId(int lawsuiteId) {
    final query = (select(clientsLawsuites)
          ..where((row) => row.lawsuiteId.equals(lawsuiteId)))
        .join([
      innerJoin(clients, clients.id.equalsExp(clientsLawsuites.clientId))
    ]);

    return query
        .watch()
        .map((rows) => rows.map((row) => row.readTable(clients)).toList());
  }

  // Updates

  // Deletes
  Future<int> deleteAssociation(ClientLawsuite clientLawsuite) =>
      delete(clientsLawsuites).delete(clientLawsuite);

  Future<int> deleteAssociationByIds(int clientId, int lawsuiteId) =>
      (delete(clientsLawsuites)
            ..where((tbl) =>
                tbl.clientId.equals(clientId) &
                tbl.lawsuiteId.equals(lawsuiteId)))
          .go();
}
