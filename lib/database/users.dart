import 'package:lucidum_legalis/database/database.dart';
import 'package:moor/moor.dart';

part 'users.g.dart';

class Users extends Table {
  TextColumn get username => text()();
  TextColumn get displayName => text()();
  TextColumn get password => text().nullable()();

  @override
  Set<Column> get primaryKey => {username};
}

@UseDao(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(AppDatabase db) : super(db);

  Future<User> getUuser() => select(users).getSingle();

  Future<void> createOrUpdateUser(Insertable<User> user) =>
      into(users).insertOnConflictUpdate(user);
}
