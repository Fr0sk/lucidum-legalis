import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/tables/lawsuite_againsts.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';

part 'lawsuite_dao.g.dart';

@DriftAccessor(tables: [Lawsuites, LawsuiteAgainsts])
class LawsuiteDao extends DatabaseAccessor<UserDatabase>
    with _$LawsuiteDaoMixin {
  LawsuiteDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertLawsuite(Insertable<Lawsuite> lawsuite) =>
      into(lawsuites).insert(lawsuite);

  Future<int> insertAgainst(Insertable<LawsuiteAgainst> against) =>
      into(lawsuiteAgainsts).insert(against);

  // Reads
  Future<List<Lawsuite>> getAll() => select(lawsuites).get();

  Stream<List<Lawsuite>> watchAllLawsuites() => select(lawsuites).watch();

  Stream<Lawsuite> watchLawsuiteById(int id) =>
      (select(lawsuites)..where((lawsuite) => lawsuite.id.equals(id)))
          .watchSingle();

  Future<Lawsuite> getLawsuiteById(int id) =>
      (select(lawsuites)..where((lawsuite) => lawsuite.id.equals(id)))
          .getSingle();

  Future<List<LawsuiteAgainst>> get allAgainst =>
      select(lawsuiteAgainsts).get();

  Stream<List<LawsuiteAgainst>> get watchAllAgainst =>
      select(lawsuiteAgainsts).watch();

  // Updates
  Future<bool> updateLawsuite(Insertable<Lawsuite> lawsuite) =>
      update(lawsuites).replace(lawsuite);

  Future<bool> updateAgainst(Insertable<LawsuiteAgainst> against) =>
      update(lawsuiteAgainsts).replace(against);

  // Deletes
  Future<int> deleteLawsuite(Lawsuite lawsuite) =>
      delete(lawsuites).delete(lawsuite);

  Future<void> deleteLawsuiteById(int id) =>
      (delete(lawsuites)..where((lawsuite) => lawsuite.id.equals(id))).go();

  Future<void> deleteAgainstById(int id) =>
      (delete(lawsuiteAgainsts)..where((against) => against.id.equals(id)))
          .go();
}
