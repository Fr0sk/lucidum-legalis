import 'package:drift/drift.dart';
import 'package:lucidum_legalis/database/tables/lawsuites.dart';
import 'package:lucidum_legalis/database/user_database.dart';

part 'lawsuite_dao.g.dart';

@DriftAccessor(tables: [Lawsuites])
class LawsuiteDao extends DatabaseAccessor<UserDatabase>
    with _$LawsuiteDaoMixin {
  LawsuiteDao(UserDatabase db) : super(db);

  // Creates
  Future<int> insertLawsuite(Insertable<Lawsuite> lawsuite) =>
      into(lawsuites).insert(lawsuite);

  // Reads
  Stream<List<Lawsuite>> watchAllLawsuites() => select(lawsuites).watch();

  Stream<Lawsuite> watchLawsuiteById(int id) =>
      (select(lawsuites)..where((lawsuite) => lawsuite.id.equals(id)))
          .watchSingle();

  Future<Lawsuite> getLawsuiteById(int id) =>
      (select(lawsuites)..where((lawsuite) => lawsuite.id.equals(id)))
          .getSingle();

  // Updates
  Future<void> updateLawsuite(Lawsuite lawsuite) =>
      update(lawsuites).replace(lawsuite);

  // Deletes
  Future<void> deleteLawsuite(Lawsuite lawsuite) =>
      delete(lawsuites).delete(lawsuite);

  Future<void> deleteLawsuiteById(int id) =>
      (delete(lawsuites)..where((lawsuite) => lawsuite.id.equals(id))).go();
}
