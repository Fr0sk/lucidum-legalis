// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String username;
  final String displayName;
  final String password;
  User({@required this.username, @required this.displayName, this.password});
  factory User.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return User(
      username: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      displayName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}display_name']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return User(
      username: serializer.fromJson<String>(json['username']),
      displayName: serializer.fromJson<String>(json['displayName']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'username': serializer.toJson<String>(username),
      'displayName': serializer.toJson<String>(displayName),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({String username, String displayName, String password}) => User(
        username: username ?? this.username,
        displayName: displayName ?? this.displayName,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(username.hashCode, $mrjc(displayName.hashCode, password.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is User &&
          other.username == this.username &&
          other.displayName == this.displayName &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> username;
  final Value<String> displayName;
  final Value<String> password;
  const UsersCompanion({
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    @required String username,
    @required String displayName,
    this.password = const Value.absent(),
  })  : username = Value(username),
        displayName = Value(displayName);
  static Insertable<User> custom({
    Expression<String> username,
    Expression<String> displayName,
    Expression<String> password,
  }) {
    return RawValuesInsertable({
      if (username != null) 'username': username,
      if (displayName != null) 'display_name': displayName,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith(
      {Value<String> username,
      Value<String> displayName,
      Value<String> password}) {
    return UsersCompanion(
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  GeneratedTextColumn _username;
  @override
  GeneratedTextColumn get username => _username ??= _constructUsername();
  GeneratedTextColumn _constructUsername() {
    return GeneratedTextColumn(
      'username',
      $tableName,
      false,
    );
  }

  final VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  GeneratedTextColumn _displayName;
  @override
  GeneratedTextColumn get displayName =>
      _displayName ??= _constructDisplayName();
  GeneratedTextColumn _constructDisplayName() {
    return GeneratedTextColumn(
      'display_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn(
      'password',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [username, displayName, password];
  @override
  $UsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'users';
  @override
  final String actualTableName = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username'], _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name'], _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {username};
  @override
  User map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return User.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String idNumber;
  final String taxNumber;
  final String civilStatus;
  final String street;
  final String zipCode;
  final String city;
  final String district;
  Client(
      {@required this.id,
      @required this.name,
      this.idNumber,
      this.taxNumber,
      this.civilStatus,
      this.street,
      this.zipCode,
      this.city,
      this.district});
  factory Client.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Client(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      idNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_number']),
      taxNumber: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tax_number']),
      civilStatus: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}civil_status']),
      street:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}street']),
      zipCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}zip_code']),
      city: stringType.mapFromDatabaseResponse(data['${effectivePrefix}city']),
      district: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || idNumber != null) {
      map['id_number'] = Variable<String>(idNumber);
    }
    if (!nullToAbsent || taxNumber != null) {
      map['tax_number'] = Variable<String>(taxNumber);
    }
    if (!nullToAbsent || civilStatus != null) {
      map['civil_status'] = Variable<String>(civilStatus);
    }
    if (!nullToAbsent || street != null) {
      map['street'] = Variable<String>(street);
    }
    if (!nullToAbsent || zipCode != null) {
      map['zip_code'] = Variable<String>(zipCode);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      idNumber: idNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(idNumber),
      taxNumber: taxNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(taxNumber),
      civilStatus: civilStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(civilStatus),
      street:
          street == null && nullToAbsent ? const Value.absent() : Value(street),
      zipCode: zipCode == null && nullToAbsent
          ? const Value.absent()
          : Value(zipCode),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      idNumber: serializer.fromJson<String>(json['idNumber']),
      taxNumber: serializer.fromJson<String>(json['taxNumber']),
      civilStatus: serializer.fromJson<String>(json['civilStatus']),
      street: serializer.fromJson<String>(json['street']),
      zipCode: serializer.fromJson<String>(json['zipCode']),
      city: serializer.fromJson<String>(json['city']),
      district: serializer.fromJson<String>(json['district']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'idNumber': serializer.toJson<String>(idNumber),
      'taxNumber': serializer.toJson<String>(taxNumber),
      'civilStatus': serializer.toJson<String>(civilStatus),
      'street': serializer.toJson<String>(street),
      'zipCode': serializer.toJson<String>(zipCode),
      'city': serializer.toJson<String>(city),
      'district': serializer.toJson<String>(district),
    };
  }

  Client copyWith(
          {int id,
          String name,
          String idNumber,
          String taxNumber,
          String civilStatus,
          String street,
          String zipCode,
          String city,
          String district}) =>
      Client(
        id: id ?? this.id,
        name: name ?? this.name,
        idNumber: idNumber ?? this.idNumber,
        taxNumber: taxNumber ?? this.taxNumber,
        civilStatus: civilStatus ?? this.civilStatus,
        street: street ?? this.street,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
        district: district ?? this.district,
      );
  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('idNumber: $idNumber, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('civilStatus: $civilStatus, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode, ')
          ..write('city: $city, ')
          ..write('district: $district')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              idNumber.hashCode,
              $mrjc(
                  taxNumber.hashCode,
                  $mrjc(
                      civilStatus.hashCode,
                      $mrjc(
                          street.hashCode,
                          $mrjc(zipCode.hashCode,
                              $mrjc(city.hashCode, district.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.idNumber == this.idNumber &&
          other.taxNumber == this.taxNumber &&
          other.civilStatus == this.civilStatus &&
          other.street == this.street &&
          other.zipCode == this.zipCode &&
          other.city == this.city &&
          other.district == this.district);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> idNumber;
  final Value<String> taxNumber;
  final Value<String> civilStatus;
  final Value<String> street;
  final Value<String> zipCode;
  final Value<String> city;
  final Value<String> district;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.civilStatus = const Value.absent(),
    this.street = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.city = const Value.absent(),
    this.district = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.idNumber = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.civilStatus = const Value.absent(),
    this.street = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.city = const Value.absent(),
    this.district = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Client> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> idNumber,
    Expression<String> taxNumber,
    Expression<String> civilStatus,
    Expression<String> street,
    Expression<String> zipCode,
    Expression<String> city,
    Expression<String> district,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (idNumber != null) 'id_number': idNumber,
      if (taxNumber != null) 'tax_number': taxNumber,
      if (civilStatus != null) 'civil_status': civilStatus,
      if (street != null) 'street': street,
      if (zipCode != null) 'zip_code': zipCode,
      if (city != null) 'city': city,
      if (district != null) 'district': district,
    });
  }

  ClientsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> idNumber,
      Value<String> taxNumber,
      Value<String> civilStatus,
      Value<String> street,
      Value<String> zipCode,
      Value<String> city,
      Value<String> district}) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      idNumber: idNumber ?? this.idNumber,
      taxNumber: taxNumber ?? this.taxNumber,
      civilStatus: civilStatus ?? this.civilStatus,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (idNumber.present) {
      map['id_number'] = Variable<String>(idNumber.value);
    }
    if (taxNumber.present) {
      map['tax_number'] = Variable<String>(taxNumber.value);
    }
    if (civilStatus.present) {
      map['civil_status'] = Variable<String>(civilStatus.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('idNumber: $idNumber, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('civilStatus: $civilStatus, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode, ')
          ..write('city: $city, ')
          ..write('district: $district')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  final GeneratedDatabase _db;
  final String _alias;
  $ClientsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idNumberMeta = const VerificationMeta('idNumber');
  GeneratedTextColumn _idNumber;
  @override
  GeneratedTextColumn get idNumber => _idNumber ??= _constructIdNumber();
  GeneratedTextColumn _constructIdNumber() {
    return GeneratedTextColumn(
      'id_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _taxNumberMeta = const VerificationMeta('taxNumber');
  GeneratedTextColumn _taxNumber;
  @override
  GeneratedTextColumn get taxNumber => _taxNumber ??= _constructTaxNumber();
  GeneratedTextColumn _constructTaxNumber() {
    return GeneratedTextColumn(
      'tax_number',
      $tableName,
      true,
    );
  }

  final VerificationMeta _civilStatusMeta =
      const VerificationMeta('civilStatus');
  GeneratedTextColumn _civilStatus;
  @override
  GeneratedTextColumn get civilStatus =>
      _civilStatus ??= _constructCivilStatus();
  GeneratedTextColumn _constructCivilStatus() {
    return GeneratedTextColumn(
      'civil_status',
      $tableName,
      true,
    );
  }

  final VerificationMeta _streetMeta = const VerificationMeta('street');
  GeneratedTextColumn _street;
  @override
  GeneratedTextColumn get street => _street ??= _constructStreet();
  GeneratedTextColumn _constructStreet() {
    return GeneratedTextColumn(
      'street',
      $tableName,
      true,
    );
  }

  final VerificationMeta _zipCodeMeta = const VerificationMeta('zipCode');
  GeneratedTextColumn _zipCode;
  @override
  GeneratedTextColumn get zipCode => _zipCode ??= _constructZipCode();
  GeneratedTextColumn _constructZipCode() {
    return GeneratedTextColumn(
      'zip_code',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedTextColumn _city;
  @override
  GeneratedTextColumn get city => _city ??= _constructCity();
  GeneratedTextColumn _constructCity() {
    return GeneratedTextColumn(
      'city',
      $tableName,
      true,
    );
  }

  final VerificationMeta _districtMeta = const VerificationMeta('district');
  GeneratedTextColumn _district;
  @override
  GeneratedTextColumn get district => _district ??= _constructDistrict();
  GeneratedTextColumn _constructDistrict() {
    return GeneratedTextColumn(
      'district',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        idNumber,
        taxNumber,
        civilStatus,
        street,
        zipCode,
        city,
        district
      ];
  @override
  $ClientsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'clients';
  @override
  final String actualTableName = 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<Client> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('id_number')) {
      context.handle(_idNumberMeta,
          idNumber.isAcceptableOrUnknown(data['id_number'], _idNumberMeta));
    }
    if (data.containsKey('tax_number')) {
      context.handle(_taxNumberMeta,
          taxNumber.isAcceptableOrUnknown(data['tax_number'], _taxNumberMeta));
    }
    if (data.containsKey('civil_status')) {
      context.handle(
          _civilStatusMeta,
          civilStatus.isAcceptableOrUnknown(
              data['civil_status'], _civilStatusMeta));
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street'], _streetMeta));
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code'], _zipCodeMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city'], _cityMeta));
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district'], _districtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Client.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UsersTable _users;
  $UsersTable get users => _users ??= $UsersTable(this);
  $ClientsTable _clients;
  $ClientsTable get clients => _clients ??= $ClientsTable(this);
  UserDao _userDao;
  UserDao get userDao => _userDao ??= UserDao(this as AppDatabase);
  ClientDao _clientDao;
  ClientDao get clientDao => _clientDao ??= ClientDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, clients];
}
