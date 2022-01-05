// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ClientNote extends DataClass implements Insertable<ClientNote> {
  final int id;
  final String? title;
  final String? content;
  final int clientId;
  ClientNote(
      {required this.id, this.title, this.content, required this.clientId});
  factory ClientNote.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ClientNote(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    map['client_id'] = Variable<int>(clientId);
    return map;
  }

  ClientNotesCompanion toCompanion(bool nullToAbsent) {
    return ClientNotesCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      clientId: Value(clientId),
    );
  }

  factory ClientNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientNote(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      clientId: serializer.fromJson<int>(json['clientId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String?>(content),
      'clientId': serializer.toJson<int>(clientId),
    };
  }

  ClientNote copyWith(
          {int? id, String? title, String? content, int? clientId}) =>
      ClientNote(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        clientId: clientId ?? this.clientId,
      );
  @override
  String toString() {
    return (StringBuffer('ClientNote(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, clientId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientNote &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.clientId == this.clientId);
}

class ClientNotesCompanion extends UpdateCompanion<ClientNote> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> content;
  final Value<int> clientId;
  const ClientNotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.clientId = const Value.absent(),
  });
  ClientNotesCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    required int clientId,
  }) : clientId = Value(clientId);
  static Insertable<ClientNote> custom({
    Expression<int>? id,
    Expression<String?>? title,
    Expression<String?>? content,
    Expression<int>? clientId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (clientId != null) 'client_id': clientId,
    });
  }

  ClientNotesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? content,
      Value<int>? clientId}) {
    return ClientNotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      clientId: clientId ?? this.clientId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientNotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }
}

class $ClientNotesTable extends ClientNotes
    with TableInfo<$ClientNotesTable, ClientNote> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ClientNotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES clients(id)');
  @override
  List<GeneratedColumn> get $columns => [id, title, content, clientId];
  @override
  String get aliasedName => _alias ?? 'client_notes';
  @override
  String get actualTableName => 'client_notes';
  @override
  VerificationContext validateIntegrity(Insertable<ClientNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ClientNote.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ClientNotesTable createAlias(String alias) {
    return $ClientNotesTable(_db, alias);
  }
}

class ClientLawsuite extends DataClass implements Insertable<ClientLawsuite> {
  final int id;
  final int clientId;
  final int lawsuiteId;
  ClientLawsuite(
      {required this.id, required this.clientId, required this.lawsuiteId});
  factory ClientLawsuite.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ClientLawsuite(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      lawsuiteId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lawsuite_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['lawsuite_id'] = Variable<int>(lawsuiteId);
    return map;
  }

  ClientsLawsuitesCompanion toCompanion(bool nullToAbsent) {
    return ClientsLawsuitesCompanion(
      id: Value(id),
      clientId: Value(clientId),
      lawsuiteId: Value(lawsuiteId),
    );
  }

  factory ClientLawsuite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientLawsuite(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      lawsuiteId: serializer.fromJson<int>(json['lawsuiteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'lawsuiteId': serializer.toJson<int>(lawsuiteId),
    };
  }

  ClientLawsuite copyWith({int? id, int? clientId, int? lawsuiteId}) =>
      ClientLawsuite(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        lawsuiteId: lawsuiteId ?? this.lawsuiteId,
      );
  @override
  String toString() {
    return (StringBuffer('ClientLawsuite(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('lawsuiteId: $lawsuiteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientId, lawsuiteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientLawsuite &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.lawsuiteId == this.lawsuiteId);
}

class ClientsLawsuitesCompanion extends UpdateCompanion<ClientLawsuite> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<int> lawsuiteId;
  const ClientsLawsuitesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.lawsuiteId = const Value.absent(),
  });
  ClientsLawsuitesCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required int lawsuiteId,
  })  : clientId = Value(clientId),
        lawsuiteId = Value(lawsuiteId);
  static Insertable<ClientLawsuite> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<int>? lawsuiteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (lawsuiteId != null) 'lawsuite_id': lawsuiteId,
    });
  }

  ClientsLawsuitesCompanion copyWith(
      {Value<int>? id, Value<int>? clientId, Value<int>? lawsuiteId}) {
    return ClientsLawsuitesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      lawsuiteId: lawsuiteId ?? this.lawsuiteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (lawsuiteId.present) {
      map['lawsuite_id'] = Variable<int>(lawsuiteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsLawsuitesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('lawsuiteId: $lawsuiteId')
          ..write(')'))
        .toString();
  }
}

class $ClientsLawsuitesTable extends ClientsLawsuites
    with TableInfo<$ClientsLawsuitesTable, ClientLawsuite> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ClientsLawsuitesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES clients(id)');
  final VerificationMeta _lawsuiteIdMeta = const VerificationMeta('lawsuiteId');
  @override
  late final GeneratedColumn<int?> lawsuiteId = GeneratedColumn<int?>(
      'lawsuite_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES lawsuites(id)');
  @override
  List<GeneratedColumn> get $columns => [id, clientId, lawsuiteId];
  @override
  String get aliasedName => _alias ?? 'clients_lawsuites';
  @override
  String get actualTableName => 'clients_lawsuites';
  @override
  VerificationContext validateIntegrity(Insertable<ClientLawsuite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('lawsuite_id')) {
      context.handle(
          _lawsuiteIdMeta,
          lawsuiteId.isAcceptableOrUnknown(
              data['lawsuite_id']!, _lawsuiteIdMeta));
    } else if (isInserting) {
      context.missing(_lawsuiteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientLawsuite map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ClientLawsuite.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ClientsLawsuitesTable createAlias(String alias) {
    return $ClientsLawsuitesTable(_db, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final ClientType type;
  final String? idNumber;
  final int? taxNumber;
  final String? civilStatus;
  final String? street;
  final String? zipCode;
  final String? city;
  final String? county;
  final DateTime createdAt;
  Client(
      {required this.id,
      required this.name,
      required this.type,
      this.idNumber,
      this.taxNumber,
      this.civilStatus,
      this.street,
      this.zipCode,
      this.city,
      this.county,
      required this.createdAt});
  factory Client.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Client(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      type: $ClientsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      idNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id_number']),
      taxNumber: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tax_number']),
      civilStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}civil_status']),
      street: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street']),
      zipCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}zip_code']),
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city']),
      county: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}county']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      final converter = $ClientsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type)!);
    }
    if (!nullToAbsent || idNumber != null) {
      map['id_number'] = Variable<String?>(idNumber);
    }
    if (!nullToAbsent || taxNumber != null) {
      map['tax_number'] = Variable<int?>(taxNumber);
    }
    if (!nullToAbsent || civilStatus != null) {
      map['civil_status'] = Variable<String?>(civilStatus);
    }
    if (!nullToAbsent || street != null) {
      map['street'] = Variable<String?>(street);
    }
    if (!nullToAbsent || zipCode != null) {
      map['zip_code'] = Variable<String?>(zipCode);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String?>(city);
    }
    if (!nullToAbsent || county != null) {
      map['county'] = Variable<String?>(county);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
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
      county:
          county == null && nullToAbsent ? const Value.absent() : Value(county),
      createdAt: Value(createdAt),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<ClientType>(json['type']),
      idNumber: serializer.fromJson<String?>(json['idNumber']),
      taxNumber: serializer.fromJson<int?>(json['taxNumber']),
      civilStatus: serializer.fromJson<String?>(json['civilStatus']),
      street: serializer.fromJson<String?>(json['street']),
      zipCode: serializer.fromJson<String?>(json['zipCode']),
      city: serializer.fromJson<String?>(json['city']),
      county: serializer.fromJson<String?>(json['county']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<ClientType>(type),
      'idNumber': serializer.toJson<String?>(idNumber),
      'taxNumber': serializer.toJson<int?>(taxNumber),
      'civilStatus': serializer.toJson<String?>(civilStatus),
      'street': serializer.toJson<String?>(street),
      'zipCode': serializer.toJson<String?>(zipCode),
      'city': serializer.toJson<String?>(city),
      'county': serializer.toJson<String?>(county),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Client copyWith(
          {int? id,
          String? name,
          ClientType? type,
          String? idNumber,
          int? taxNumber,
          String? civilStatus,
          String? street,
          String? zipCode,
          String? city,
          String? county,
          DateTime? createdAt}) =>
      Client(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        idNumber: idNumber ?? this.idNumber,
        taxNumber: taxNumber ?? this.taxNumber,
        civilStatus: civilStatus ?? this.civilStatus,
        street: street ?? this.street,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
        county: county ?? this.county,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('idNumber: $idNumber, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('civilStatus: $civilStatus, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode, ')
          ..write('city: $city, ')
          ..write('county: $county, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, idNumber, taxNumber,
      civilStatus, street, zipCode, city, county, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.idNumber == this.idNumber &&
          other.taxNumber == this.taxNumber &&
          other.civilStatus == this.civilStatus &&
          other.street == this.street &&
          other.zipCode == this.zipCode &&
          other.city == this.city &&
          other.county == this.county &&
          other.createdAt == this.createdAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<ClientType> type;
  final Value<String?> idNumber;
  final Value<int?> taxNumber;
  final Value<String?> civilStatus;
  final Value<String?> street;
  final Value<String?> zipCode;
  final Value<String?> city;
  final Value<String?> county;
  final Value<DateTime> createdAt;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.civilStatus = const Value.absent(),
    this.street = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.city = const Value.absent(),
    this.county = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required ClientType type,
    this.idNumber = const Value.absent(),
    this.taxNumber = const Value.absent(),
    this.civilStatus = const Value.absent(),
    this.street = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.city = const Value.absent(),
    this.county = const Value.absent(),
    required DateTime createdAt,
  })  : name = Value(name),
        type = Value(type),
        createdAt = Value(createdAt);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<ClientType>? type,
    Expression<String?>? idNumber,
    Expression<int?>? taxNumber,
    Expression<String?>? civilStatus,
    Expression<String?>? street,
    Expression<String?>? zipCode,
    Expression<String?>? city,
    Expression<String?>? county,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (idNumber != null) 'id_number': idNumber,
      if (taxNumber != null) 'tax_number': taxNumber,
      if (civilStatus != null) 'civil_status': civilStatus,
      if (street != null) 'street': street,
      if (zipCode != null) 'zip_code': zipCode,
      if (city != null) 'city': city,
      if (county != null) 'county': county,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ClientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<ClientType>? type,
      Value<String?>? idNumber,
      Value<int?>? taxNumber,
      Value<String?>? civilStatus,
      Value<String?>? street,
      Value<String?>? zipCode,
      Value<String?>? city,
      Value<String?>? county,
      Value<DateTime>? createdAt}) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      idNumber: idNumber ?? this.idNumber,
      taxNumber: taxNumber ?? this.taxNumber,
      civilStatus: civilStatus ?? this.civilStatus,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      county: county ?? this.county,
      createdAt: createdAt ?? this.createdAt,
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
    if (type.present) {
      final converter = $ClientsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value)!);
    }
    if (idNumber.present) {
      map['id_number'] = Variable<String?>(idNumber.value);
    }
    if (taxNumber.present) {
      map['tax_number'] = Variable<int?>(taxNumber.value);
    }
    if (civilStatus.present) {
      map['civil_status'] = Variable<String?>(civilStatus.value);
    }
    if (street.present) {
      map['street'] = Variable<String?>(street.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String?>(zipCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String?>(city.value);
    }
    if (county.present) {
      map['county'] = Variable<String?>(county.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('idNumber: $idNumber, ')
          ..write('taxNumber: $taxNumber, ')
          ..write('civilStatus: $civilStatus, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode, ')
          ..write('city: $city, ')
          ..write('county: $county, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ClientsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ClientType, int?> type =
      GeneratedColumn<int?>('type', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<ClientType>($ClientsTable.$converter0);
  final VerificationMeta _idNumberMeta = const VerificationMeta('idNumber');
  @override
  late final GeneratedColumn<String?> idNumber = GeneratedColumn<String?>(
      'id_number', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _taxNumberMeta = const VerificationMeta('taxNumber');
  @override
  late final GeneratedColumn<int?> taxNumber = GeneratedColumn<int?>(
      'tax_number', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _civilStatusMeta =
      const VerificationMeta('civilStatus');
  @override
  late final GeneratedColumn<String?> civilStatus = GeneratedColumn<String?>(
      'civil_status', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String?> street = GeneratedColumn<String?>(
      'street', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _zipCodeMeta = const VerificationMeta('zipCode');
  @override
  late final GeneratedColumn<String?> zipCode = GeneratedColumn<String?>(
      'zip_code', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _countyMeta = const VerificationMeta('county');
  @override
  late final GeneratedColumn<String?> county = GeneratedColumn<String?>(
      'county', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        idNumber,
        taxNumber,
        civilStatus,
        street,
        zipCode,
        city,
        county,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? 'clients';
  @override
  String get actualTableName => 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<Client> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('id_number')) {
      context.handle(_idNumberMeta,
          idNumber.isAcceptableOrUnknown(data['id_number']!, _idNumberMeta));
    }
    if (data.containsKey('tax_number')) {
      context.handle(_taxNumberMeta,
          taxNumber.isAcceptableOrUnknown(data['tax_number']!, _taxNumberMeta));
    }
    if (data.containsKey('civil_status')) {
      context.handle(
          _civilStatusMeta,
          civilStatus.isAcceptableOrUnknown(
              data['civil_status']!, _civilStatusMeta));
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('county')) {
      context.handle(_countyMeta,
          county.isAcceptableOrUnknown(data['county']!, _countyMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Client.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(_db, alias);
  }

  static TypeConverter<ClientType, int> $converter0 =
      const EnumIndexConverter<ClientType>(ClientType.values);
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final ContactType contactType;
  final String? contact;
  final int clientId;
  Contact(
      {required this.id,
      required this.contactType,
      this.contact,
      required this.clientId});
  factory Contact.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Contact(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      contactType: $ContactsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}contact_type']))!,
      contact: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}contact']),
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      final converter = $ContactsTable.$converter0;
      map['contact_type'] = Variable<int>(converter.mapToSql(contactType)!);
    }
    if (!nullToAbsent || contact != null) {
      map['contact'] = Variable<String?>(contact);
    }
    map['client_id'] = Variable<int>(clientId);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      contactType: Value(contactType),
      contact: contact == null && nullToAbsent
          ? const Value.absent()
          : Value(contact),
      clientId: Value(clientId),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      contactType: serializer.fromJson<ContactType>(json['contactType']),
      contact: serializer.fromJson<String?>(json['contact']),
      clientId: serializer.fromJson<int>(json['clientId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contactType': serializer.toJson<ContactType>(contactType),
      'contact': serializer.toJson<String?>(contact),
      'clientId': serializer.toJson<int>(clientId),
    };
  }

  Contact copyWith(
          {int? id,
          ContactType? contactType,
          String? contact,
          int? clientId}) =>
      Contact(
        id: id ?? this.id,
        contactType: contactType ?? this.contactType,
        contact: contact ?? this.contact,
        clientId: clientId ?? this.clientId,
      );
  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('contactType: $contactType, ')
          ..write('contact: $contact, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contactType, contact, clientId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.contactType == this.contactType &&
          other.contact == this.contact &&
          other.clientId == this.clientId);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<ContactType> contactType;
  final Value<String?> contact;
  final Value<int> clientId;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.contactType = const Value.absent(),
    this.contact = const Value.absent(),
    this.clientId = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required ContactType contactType,
    this.contact = const Value.absent(),
    required int clientId,
  })  : contactType = Value(contactType),
        clientId = Value(clientId);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<ContactType>? contactType,
    Expression<String?>? contact,
    Expression<int>? clientId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contactType != null) 'contact_type': contactType,
      if (contact != null) 'contact': contact,
      if (clientId != null) 'client_id': clientId,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<ContactType>? contactType,
      Value<String?>? contact,
      Value<int>? clientId}) {
    return ContactsCompanion(
      id: id ?? this.id,
      contactType: contactType ?? this.contactType,
      contact: contact ?? this.contact,
      clientId: clientId ?? this.clientId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contactType.present) {
      final converter = $ContactsTable.$converter0;
      map['contact_type'] =
          Variable<int>(converter.mapToSql(contactType.value)!);
    }
    if (contact.present) {
      map['contact'] = Variable<String?>(contact.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('contactType: $contactType, ')
          ..write('contact: $contact, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _contactTypeMeta =
      const VerificationMeta('contactType');
  @override
  late final GeneratedColumnWithTypeConverter<ContactType, int?> contactType =
      GeneratedColumn<int?>('contact_type', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<ContactType>($ContactsTable.$converter0);
  final VerificationMeta _contactMeta = const VerificationMeta('contact');
  @override
  late final GeneratedColumn<String?> contact = GeneratedColumn<String?>(
      'contact', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES clients(id)');
  @override
  List<GeneratedColumn> get $columns => [id, contactType, contact, clientId];
  @override
  String get aliasedName => _alias ?? 'contacts';
  @override
  String get actualTableName => 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_contactTypeMeta, const VerificationResult.success());
    if (data.containsKey('contact')) {
      context.handle(_contactMeta,
          contact.isAcceptableOrUnknown(data['contact']!, _contactMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Contact.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(_db, alias);
  }

  static TypeConverter<ContactType, int> $converter0 =
      const EnumIndexConverter<ContactType>(ContactType.values);
}

class LawsuiteNote extends DataClass implements Insertable<LawsuiteNote> {
  final int id;
  final String? title;
  final String? content;
  final int lawsuiteId;
  LawsuiteNote(
      {required this.id, this.title, this.content, required this.lawsuiteId});
  factory LawsuiteNote.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LawsuiteNote(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      lawsuiteId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lawsuite_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    map['lawsuite_id'] = Variable<int>(lawsuiteId);
    return map;
  }

  LawsuiteNotesCompanion toCompanion(bool nullToAbsent) {
    return LawsuiteNotesCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      lawsuiteId: Value(lawsuiteId),
    );
  }

  factory LawsuiteNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LawsuiteNote(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      lawsuiteId: serializer.fromJson<int>(json['lawsuiteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String?>(content),
      'lawsuiteId': serializer.toJson<int>(lawsuiteId),
    };
  }

  LawsuiteNote copyWith(
          {int? id, String? title, String? content, int? lawsuiteId}) =>
      LawsuiteNote(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        lawsuiteId: lawsuiteId ?? this.lawsuiteId,
      );
  @override
  String toString() {
    return (StringBuffer('LawsuiteNote(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('lawsuiteId: $lawsuiteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, lawsuiteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LawsuiteNote &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.lawsuiteId == this.lawsuiteId);
}

class LawsuiteNotesCompanion extends UpdateCompanion<LawsuiteNote> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> content;
  final Value<int> lawsuiteId;
  const LawsuiteNotesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.lawsuiteId = const Value.absent(),
  });
  LawsuiteNotesCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    required int lawsuiteId,
  }) : lawsuiteId = Value(lawsuiteId);
  static Insertable<LawsuiteNote> custom({
    Expression<int>? id,
    Expression<String?>? title,
    Expression<String?>? content,
    Expression<int>? lawsuiteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (lawsuiteId != null) 'lawsuite_id': lawsuiteId,
    });
  }

  LawsuiteNotesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? content,
      Value<int>? lawsuiteId}) {
    return LawsuiteNotesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      lawsuiteId: lawsuiteId ?? this.lawsuiteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (lawsuiteId.present) {
      map['lawsuite_id'] = Variable<int>(lawsuiteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LawsuiteNotesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('lawsuiteId: $lawsuiteId')
          ..write(')'))
        .toString();
  }
}

class $LawsuiteNotesTable extends LawsuiteNotes
    with TableInfo<$LawsuiteNotesTable, LawsuiteNote> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LawsuiteNotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _lawsuiteIdMeta = const VerificationMeta('lawsuiteId');
  @override
  late final GeneratedColumn<int?> lawsuiteId = GeneratedColumn<int?>(
      'lawsuite_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES lawsuites(id)');
  @override
  List<GeneratedColumn> get $columns => [id, title, content, lawsuiteId];
  @override
  String get aliasedName => _alias ?? 'lawsuite_notes';
  @override
  String get actualTableName => 'lawsuite_notes';
  @override
  VerificationContext validateIntegrity(Insertable<LawsuiteNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('lawsuite_id')) {
      context.handle(
          _lawsuiteIdMeta,
          lawsuiteId.isAcceptableOrUnknown(
              data['lawsuite_id']!, _lawsuiteIdMeta));
    } else if (isInserting) {
      context.missing(_lawsuiteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LawsuiteNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LawsuiteNote.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LawsuiteNotesTable createAlias(String alias) {
    return $LawsuiteNotesTable(_db, alias);
  }
}

class Lawsuite extends DataClass implements Insertable<Lawsuite> {
  final int id;
  final String name;
  final LawsuiteState state;
  final String? against;
  final String? code;
  final String? processNumber;
  final String? district;
  final String? court;
  final String? judgement;
  final String? form;
  final String? legalSupportNumber;
  final DateTime createdAt;
  Lawsuite(
      {required this.id,
      required this.name,
      required this.state,
      this.against,
      this.code,
      this.processNumber,
      this.district,
      this.court,
      this.judgement,
      this.form,
      this.legalSupportNumber,
      required this.createdAt});
  factory Lawsuite.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Lawsuite(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      state: $LawsuitesTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}state']))!,
      against: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}against']),
      code: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}code']),
      processNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}process_number']),
      district: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}district']),
      court: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}court']),
      judgement: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}judgement']),
      form: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}form']),
      legalSupportNumber: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}legal_support_number']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      final converter = $LawsuitesTable.$converter0;
      map['state'] = Variable<int>(converter.mapToSql(state)!);
    }
    if (!nullToAbsent || against != null) {
      map['against'] = Variable<String?>(against);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String?>(code);
    }
    if (!nullToAbsent || processNumber != null) {
      map['process_number'] = Variable<String?>(processNumber);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String?>(district);
    }
    if (!nullToAbsent || court != null) {
      map['court'] = Variable<String?>(court);
    }
    if (!nullToAbsent || judgement != null) {
      map['judgement'] = Variable<String?>(judgement);
    }
    if (!nullToAbsent || form != null) {
      map['form'] = Variable<String?>(form);
    }
    if (!nullToAbsent || legalSupportNumber != null) {
      map['legal_support_number'] = Variable<String?>(legalSupportNumber);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LawsuitesCompanion toCompanion(bool nullToAbsent) {
    return LawsuitesCompanion(
      id: Value(id),
      name: Value(name),
      state: Value(state),
      against: against == null && nullToAbsent
          ? const Value.absent()
          : Value(against),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      processNumber: processNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(processNumber),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      court:
          court == null && nullToAbsent ? const Value.absent() : Value(court),
      judgement: judgement == null && nullToAbsent
          ? const Value.absent()
          : Value(judgement),
      form: form == null && nullToAbsent ? const Value.absent() : Value(form),
      legalSupportNumber: legalSupportNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(legalSupportNumber),
      createdAt: Value(createdAt),
    );
  }

  factory Lawsuite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lawsuite(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      state: serializer.fromJson<LawsuiteState>(json['state']),
      against: serializer.fromJson<String?>(json['against']),
      code: serializer.fromJson<String?>(json['code']),
      processNumber: serializer.fromJson<String?>(json['processNumber']),
      district: serializer.fromJson<String?>(json['district']),
      court: serializer.fromJson<String?>(json['court']),
      judgement: serializer.fromJson<String?>(json['judgement']),
      form: serializer.fromJson<String?>(json['form']),
      legalSupportNumber:
          serializer.fromJson<String?>(json['legalSupportNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'state': serializer.toJson<LawsuiteState>(state),
      'against': serializer.toJson<String?>(against),
      'code': serializer.toJson<String?>(code),
      'processNumber': serializer.toJson<String?>(processNumber),
      'district': serializer.toJson<String?>(district),
      'court': serializer.toJson<String?>(court),
      'judgement': serializer.toJson<String?>(judgement),
      'form': serializer.toJson<String?>(form),
      'legalSupportNumber': serializer.toJson<String?>(legalSupportNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Lawsuite copyWith(
          {int? id,
          String? name,
          LawsuiteState? state,
          String? against,
          String? code,
          String? processNumber,
          String? district,
          String? court,
          String? judgement,
          String? form,
          String? legalSupportNumber,
          DateTime? createdAt}) =>
      Lawsuite(
        id: id ?? this.id,
        name: name ?? this.name,
        state: state ?? this.state,
        against: against ?? this.against,
        code: code ?? this.code,
        processNumber: processNumber ?? this.processNumber,
        district: district ?? this.district,
        court: court ?? this.court,
        judgement: judgement ?? this.judgement,
        form: form ?? this.form,
        legalSupportNumber: legalSupportNumber ?? this.legalSupportNumber,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Lawsuite(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('state: $state, ')
          ..write('against: $against, ')
          ..write('code: $code, ')
          ..write('processNumber: $processNumber, ')
          ..write('district: $district, ')
          ..write('court: $court, ')
          ..write('judgement: $judgement, ')
          ..write('form: $form, ')
          ..write('legalSupportNumber: $legalSupportNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, state, against, code, processNumber,
      district, court, judgement, form, legalSupportNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lawsuite &&
          other.id == this.id &&
          other.name == this.name &&
          other.state == this.state &&
          other.against == this.against &&
          other.code == this.code &&
          other.processNumber == this.processNumber &&
          other.district == this.district &&
          other.court == this.court &&
          other.judgement == this.judgement &&
          other.form == this.form &&
          other.legalSupportNumber == this.legalSupportNumber &&
          other.createdAt == this.createdAt);
}

class LawsuitesCompanion extends UpdateCompanion<Lawsuite> {
  final Value<int> id;
  final Value<String> name;
  final Value<LawsuiteState> state;
  final Value<String?> against;
  final Value<String?> code;
  final Value<String?> processNumber;
  final Value<String?> district;
  final Value<String?> court;
  final Value<String?> judgement;
  final Value<String?> form;
  final Value<String?> legalSupportNumber;
  final Value<DateTime> createdAt;
  const LawsuitesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.state = const Value.absent(),
    this.against = const Value.absent(),
    this.code = const Value.absent(),
    this.processNumber = const Value.absent(),
    this.district = const Value.absent(),
    this.court = const Value.absent(),
    this.judgement = const Value.absent(),
    this.form = const Value.absent(),
    this.legalSupportNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LawsuitesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required LawsuiteState state,
    this.against = const Value.absent(),
    this.code = const Value.absent(),
    this.processNumber = const Value.absent(),
    this.district = const Value.absent(),
    this.court = const Value.absent(),
    this.judgement = const Value.absent(),
    this.form = const Value.absent(),
    this.legalSupportNumber = const Value.absent(),
    required DateTime createdAt,
  })  : name = Value(name),
        state = Value(state),
        createdAt = Value(createdAt);
  static Insertable<Lawsuite> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<LawsuiteState>? state,
    Expression<String?>? against,
    Expression<String?>? code,
    Expression<String?>? processNumber,
    Expression<String?>? district,
    Expression<String?>? court,
    Expression<String?>? judgement,
    Expression<String?>? form,
    Expression<String?>? legalSupportNumber,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (state != null) 'state': state,
      if (against != null) 'against': against,
      if (code != null) 'code': code,
      if (processNumber != null) 'process_number': processNumber,
      if (district != null) 'district': district,
      if (court != null) 'court': court,
      if (judgement != null) 'judgement': judgement,
      if (form != null) 'form': form,
      if (legalSupportNumber != null)
        'legal_support_number': legalSupportNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LawsuitesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<LawsuiteState>? state,
      Value<String?>? against,
      Value<String?>? code,
      Value<String?>? processNumber,
      Value<String?>? district,
      Value<String?>? court,
      Value<String?>? judgement,
      Value<String?>? form,
      Value<String?>? legalSupportNumber,
      Value<DateTime>? createdAt}) {
    return LawsuitesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      against: against ?? this.against,
      code: code ?? this.code,
      processNumber: processNumber ?? this.processNumber,
      district: district ?? this.district,
      court: court ?? this.court,
      judgement: judgement ?? this.judgement,
      form: form ?? this.form,
      legalSupportNumber: legalSupportNumber ?? this.legalSupportNumber,
      createdAt: createdAt ?? this.createdAt,
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
    if (state.present) {
      final converter = $LawsuitesTable.$converter0;
      map['state'] = Variable<int>(converter.mapToSql(state.value)!);
    }
    if (against.present) {
      map['against'] = Variable<String?>(against.value);
    }
    if (code.present) {
      map['code'] = Variable<String?>(code.value);
    }
    if (processNumber.present) {
      map['process_number'] = Variable<String?>(processNumber.value);
    }
    if (district.present) {
      map['district'] = Variable<String?>(district.value);
    }
    if (court.present) {
      map['court'] = Variable<String?>(court.value);
    }
    if (judgement.present) {
      map['judgement'] = Variable<String?>(judgement.value);
    }
    if (form.present) {
      map['form'] = Variable<String?>(form.value);
    }
    if (legalSupportNumber.present) {
      map['legal_support_number'] = Variable<String?>(legalSupportNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LawsuitesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('state: $state, ')
          ..write('against: $against, ')
          ..write('code: $code, ')
          ..write('processNumber: $processNumber, ')
          ..write('district: $district, ')
          ..write('court: $court, ')
          ..write('judgement: $judgement, ')
          ..write('form: $form, ')
          ..write('legalSupportNumber: $legalSupportNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LawsuitesTable extends Lawsuites
    with TableInfo<$LawsuitesTable, Lawsuite> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LawsuitesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumnWithTypeConverter<LawsuiteState, int?> state =
      GeneratedColumn<int?>('state', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<LawsuiteState>($LawsuitesTable.$converter0);
  final VerificationMeta _againstMeta = const VerificationMeta('against');
  @override
  late final GeneratedColumn<String?> against = GeneratedColumn<String?>(
      'against', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String?> code = GeneratedColumn<String?>(
      'code', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _processNumberMeta =
      const VerificationMeta('processNumber');
  @override
  late final GeneratedColumn<String?> processNumber = GeneratedColumn<String?>(
      'process_number', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _districtMeta = const VerificationMeta('district');
  @override
  late final GeneratedColumn<String?> district = GeneratedColumn<String?>(
      'district', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _courtMeta = const VerificationMeta('court');
  @override
  late final GeneratedColumn<String?> court = GeneratedColumn<String?>(
      'court', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _judgementMeta = const VerificationMeta('judgement');
  @override
  late final GeneratedColumn<String?> judgement = GeneratedColumn<String?>(
      'judgement', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String?> form = GeneratedColumn<String?>(
      'form', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _legalSupportNumberMeta =
      const VerificationMeta('legalSupportNumber');
  @override
  late final GeneratedColumn<String?> legalSupportNumber =
      GeneratedColumn<String?>('legal_support_number', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        state,
        against,
        code,
        processNumber,
        district,
        court,
        judgement,
        form,
        legalSupportNumber,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? 'lawsuites';
  @override
  String get actualTableName => 'lawsuites';
  @override
  VerificationContext validateIntegrity(Insertable<Lawsuite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_stateMeta, const VerificationResult.success());
    if (data.containsKey('against')) {
      context.handle(_againstMeta,
          against.isAcceptableOrUnknown(data['against']!, _againstMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('process_number')) {
      context.handle(
          _processNumberMeta,
          processNumber.isAcceptableOrUnknown(
              data['process_number']!, _processNumberMeta));
    }
    if (data.containsKey('district')) {
      context.handle(_districtMeta,
          district.isAcceptableOrUnknown(data['district']!, _districtMeta));
    }
    if (data.containsKey('court')) {
      context.handle(
          _courtMeta, court.isAcceptableOrUnknown(data['court']!, _courtMeta));
    }
    if (data.containsKey('judgement')) {
      context.handle(_judgementMeta,
          judgement.isAcceptableOrUnknown(data['judgement']!, _judgementMeta));
    }
    if (data.containsKey('form')) {
      context.handle(
          _formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    }
    if (data.containsKey('legal_support_number')) {
      context.handle(
          _legalSupportNumberMeta,
          legalSupportNumber.isAcceptableOrUnknown(
              data['legal_support_number']!, _legalSupportNumberMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lawsuite map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Lawsuite.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LawsuitesTable createAlias(String alias) {
    return $LawsuitesTable(_db, alias);
  }

  static TypeConverter<LawsuiteState, int> $converter0 =
      const EnumIndexConverter<LawsuiteState>(LawsuiteState.values);
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final String name;
  final String value;
  Setting({required this.id, required this.name, required this.value});
  factory Setting.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Setting(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      name: Value(name),
      value: Value(value),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({int? id, String? name, String? value}) => Setting(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> value;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String value,
  })  : name = Value(name),
        value = Value(value);
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
    });
  }

  SettingsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? value}) {
    return SettingsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
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
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SettingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, value];
  @override
  String get aliasedName => _alias ?? 'settings';
  @override
  String get actualTableName => 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Setting.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(_db, alias);
  }
}

class AppNotification extends DataClass implements Insertable<AppNotification> {
  final int id;
  final String? title;
  final String? content;
  final NotificationType? type;
  final bool emitted;
  final DateTime createdAt;
  AppNotification(
      {required this.id,
      this.title,
      this.content,
      this.type,
      required this.emitted,
      required this.createdAt});
  factory AppNotification.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AppNotification(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      type: $AppNotificationsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      emitted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}emitted'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    if (!nullToAbsent || type != null) {
      final converter = $AppNotificationsTable.$converter0;
      map['type'] = Variable<int?>(converter.mapToSql(type));
    }
    map['emitted'] = Variable<bool>(emitted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AppNotificationsCompanion toCompanion(bool nullToAbsent) {
    return AppNotificationsCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      emitted: Value(emitted),
      createdAt: Value(createdAt),
    );
  }

  factory AppNotification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppNotification(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      type: serializer.fromJson<NotificationType?>(json['type']),
      emitted: serializer.fromJson<bool>(json['emitted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String?>(content),
      'type': serializer.toJson<NotificationType?>(type),
      'emitted': serializer.toJson<bool>(emitted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AppNotification copyWith(
          {int? id,
          String? title,
          String? content,
          NotificationType? type,
          bool? emitted,
          DateTime? createdAt}) =>
      AppNotification(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        type: type ?? this.type,
        emitted: emitted ?? this.emitted,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('AppNotification(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('emitted: $emitted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, type, emitted, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppNotification &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.type == this.type &&
          other.emitted == this.emitted &&
          other.createdAt == this.createdAt);
}

class AppNotificationsCompanion extends UpdateCompanion<AppNotification> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> content;
  final Value<NotificationType?> type;
  final Value<bool> emitted;
  final Value<DateTime> createdAt;
  const AppNotificationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
    this.emitted = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AppNotificationsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
    this.emitted = const Value.absent(),
    required DateTime createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<AppNotification> custom({
    Expression<int>? id,
    Expression<String?>? title,
    Expression<String?>? content,
    Expression<NotificationType?>? type,
    Expression<bool>? emitted,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (type != null) 'type': type,
      if (emitted != null) 'emitted': emitted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AppNotificationsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? content,
      Value<NotificationType?>? type,
      Value<bool>? emitted,
      Value<DateTime>? createdAt}) {
    return AppNotificationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      emitted: emitted ?? this.emitted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (type.present) {
      final converter = $AppNotificationsTable.$converter0;
      map['type'] = Variable<int?>(converter.mapToSql(type.value));
    }
    if (emitted.present) {
      map['emitted'] = Variable<bool>(emitted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('emitted: $emitted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppNotificationsTable extends AppNotifications
    with TableInfo<$AppNotificationsTable, AppNotification> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AppNotificationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<NotificationType?, int?> type =
      GeneratedColumn<int?>('type', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<NotificationType?>($AppNotificationsTable.$converter0);
  final VerificationMeta _emittedMeta = const VerificationMeta('emitted');
  @override
  late final GeneratedColumn<bool?> emitted = GeneratedColumn<bool?>(
      'emitted', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (emitted IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, type, emitted, createdAt];
  @override
  String get aliasedName => _alias ?? 'app_notifications';
  @override
  String get actualTableName => 'app_notifications';
  @override
  VerificationContext validateIntegrity(Insertable<AppNotification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('emitted')) {
      context.handle(_emittedMeta,
          emitted.isAcceptableOrUnknown(data['emitted']!, _emittedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppNotification map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AppNotification.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AppNotificationsTable createAlias(String alias) {
    return $AppNotificationsTable(_db, alias);
  }

  static TypeConverter<NotificationType?, int> $converter0 =
      const EnumIndexConverter<NotificationType>(NotificationType.values);
}

class Alert extends DataClass implements Insertable<Alert> {
  final int id;
  final String? title;
  final String? content;
  final NotificationType? type;
  final bool emitted;
  final DateTime emitAt;
  final DateTime createdAt;
  Alert(
      {required this.id,
      this.title,
      this.content,
      this.type,
      required this.emitted,
      required this.emitAt,
      required this.createdAt});
  factory Alert.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Alert(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      type: $AlertsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      emitted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}emitted'])!,
      emitAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}emit_at'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    if (!nullToAbsent || type != null) {
      final converter = $AlertsTable.$converter0;
      map['type'] = Variable<int?>(converter.mapToSql(type));
    }
    map['emitted'] = Variable<bool>(emitted);
    map['emit_at'] = Variable<DateTime>(emitAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AlertsCompanion toCompanion(bool nullToAbsent) {
    return AlertsCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      emitted: Value(emitted),
      emitAt: Value(emitAt),
      createdAt: Value(createdAt),
    );
  }

  factory Alert.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alert(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      type: serializer.fromJson<NotificationType?>(json['type']),
      emitted: serializer.fromJson<bool>(json['emitted']),
      emitAt: serializer.fromJson<DateTime>(json['emitAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String?>(content),
      'type': serializer.toJson<NotificationType?>(type),
      'emitted': serializer.toJson<bool>(emitted),
      'emitAt': serializer.toJson<DateTime>(emitAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Alert copyWith(
          {int? id,
          String? title,
          String? content,
          NotificationType? type,
          bool? emitted,
          DateTime? emitAt,
          DateTime? createdAt}) =>
      Alert(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        type: type ?? this.type,
        emitted: emitted ?? this.emitted,
        emitAt: emitAt ?? this.emitAt,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Alert(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('emitted: $emitted, ')
          ..write('emitAt: $emitAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, content, type, emitted, emitAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alert &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.type == this.type &&
          other.emitted == this.emitted &&
          other.emitAt == this.emitAt &&
          other.createdAt == this.createdAt);
}

class AlertsCompanion extends UpdateCompanion<Alert> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> content;
  final Value<NotificationType?> type;
  final Value<bool> emitted;
  final Value<DateTime> emitAt;
  final Value<DateTime> createdAt;
  const AlertsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
    this.emitted = const Value.absent(),
    this.emitAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AlertsCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
    this.emitted = const Value.absent(),
    required DateTime emitAt,
    required DateTime createdAt,
  })  : emitAt = Value(emitAt),
        createdAt = Value(createdAt);
  static Insertable<Alert> custom({
    Expression<int>? id,
    Expression<String?>? title,
    Expression<String?>? content,
    Expression<NotificationType?>? type,
    Expression<bool>? emitted,
    Expression<DateTime>? emitAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (type != null) 'type': type,
      if (emitted != null) 'emitted': emitted,
      if (emitAt != null) 'emit_at': emitAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AlertsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? content,
      Value<NotificationType?>? type,
      Value<bool>? emitted,
      Value<DateTime>? emitAt,
      Value<DateTime>? createdAt}) {
    return AlertsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      emitted: emitted ?? this.emitted,
      emitAt: emitAt ?? this.emitAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (type.present) {
      final converter = $AlertsTable.$converter0;
      map['type'] = Variable<int?>(converter.mapToSql(type.value));
    }
    if (emitted.present) {
      map['emitted'] = Variable<bool>(emitted.value);
    }
    if (emitAt.present) {
      map['emit_at'] = Variable<DateTime>(emitAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlertsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('emitted: $emitted, ')
          ..write('emitAt: $emitAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AlertsTable extends Alerts with TableInfo<$AlertsTable, Alert> {
  final GeneratedDatabase _db;
  final String? _alias;
  $AlertsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<NotificationType?, int?> type =
      GeneratedColumn<int?>('type', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<NotificationType?>($AlertsTable.$converter0);
  final VerificationMeta _emittedMeta = const VerificationMeta('emitted');
  @override
  late final GeneratedColumn<bool?> emitted = GeneratedColumn<bool?>(
      'emitted', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (emitted IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _emitAtMeta = const VerificationMeta('emitAt');
  @override
  late final GeneratedColumn<DateTime?> emitAt = GeneratedColumn<DateTime?>(
      'emit_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, type, emitted, emitAt, createdAt];
  @override
  String get aliasedName => _alias ?? 'alerts';
  @override
  String get actualTableName => 'alerts';
  @override
  VerificationContext validateIntegrity(Insertable<Alert> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('emitted')) {
      context.handle(_emittedMeta,
          emitted.isAcceptableOrUnknown(data['emitted']!, _emittedMeta));
    }
    if (data.containsKey('emit_at')) {
      context.handle(_emitAtMeta,
          emitAt.isAcceptableOrUnknown(data['emit_at']!, _emitAtMeta));
    } else if (isInserting) {
      context.missing(_emitAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alert map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Alert.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AlertsTable createAlias(String alias) {
    return $AlertsTable(_db, alias);
  }

  static TypeConverter<NotificationType?, int> $converter0 =
      const EnumIndexConverter<NotificationType>(NotificationType.values);
}

class LawsuiteAgainst extends DataClass implements Insertable<LawsuiteAgainst> {
  final int id;
  final String? against;
  final int lawsuiteId;
  LawsuiteAgainst({required this.id, this.against, required this.lawsuiteId});
  factory LawsuiteAgainst.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LawsuiteAgainst(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      against: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}against']),
      lawsuiteId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lawsuite_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || against != null) {
      map['against'] = Variable<String?>(against);
    }
    map['lawsuite_id'] = Variable<int>(lawsuiteId);
    return map;
  }

  LawsuiteAgainstsCompanion toCompanion(bool nullToAbsent) {
    return LawsuiteAgainstsCompanion(
      id: Value(id),
      against: against == null && nullToAbsent
          ? const Value.absent()
          : Value(against),
      lawsuiteId: Value(lawsuiteId),
    );
  }

  factory LawsuiteAgainst.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LawsuiteAgainst(
      id: serializer.fromJson<int>(json['id']),
      against: serializer.fromJson<String?>(json['against']),
      lawsuiteId: serializer.fromJson<int>(json['lawsuiteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'against': serializer.toJson<String?>(against),
      'lawsuiteId': serializer.toJson<int>(lawsuiteId),
    };
  }

  LawsuiteAgainst copyWith({int? id, String? against, int? lawsuiteId}) =>
      LawsuiteAgainst(
        id: id ?? this.id,
        against: against ?? this.against,
        lawsuiteId: lawsuiteId ?? this.lawsuiteId,
      );
  @override
  String toString() {
    return (StringBuffer('LawsuiteAgainst(')
          ..write('id: $id, ')
          ..write('against: $against, ')
          ..write('lawsuiteId: $lawsuiteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, against, lawsuiteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LawsuiteAgainst &&
          other.id == this.id &&
          other.against == this.against &&
          other.lawsuiteId == this.lawsuiteId);
}

class LawsuiteAgainstsCompanion extends UpdateCompanion<LawsuiteAgainst> {
  final Value<int> id;
  final Value<String?> against;
  final Value<int> lawsuiteId;
  const LawsuiteAgainstsCompanion({
    this.id = const Value.absent(),
    this.against = const Value.absent(),
    this.lawsuiteId = const Value.absent(),
  });
  LawsuiteAgainstsCompanion.insert({
    this.id = const Value.absent(),
    this.against = const Value.absent(),
    required int lawsuiteId,
  }) : lawsuiteId = Value(lawsuiteId);
  static Insertable<LawsuiteAgainst> custom({
    Expression<int>? id,
    Expression<String?>? against,
    Expression<int>? lawsuiteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (against != null) 'against': against,
      if (lawsuiteId != null) 'lawsuite_id': lawsuiteId,
    });
  }

  LawsuiteAgainstsCompanion copyWith(
      {Value<int>? id, Value<String?>? against, Value<int>? lawsuiteId}) {
    return LawsuiteAgainstsCompanion(
      id: id ?? this.id,
      against: against ?? this.against,
      lawsuiteId: lawsuiteId ?? this.lawsuiteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (against.present) {
      map['against'] = Variable<String?>(against.value);
    }
    if (lawsuiteId.present) {
      map['lawsuite_id'] = Variable<int>(lawsuiteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LawsuiteAgainstsCompanion(')
          ..write('id: $id, ')
          ..write('against: $against, ')
          ..write('lawsuiteId: $lawsuiteId')
          ..write(')'))
        .toString();
  }
}

class $LawsuiteAgainstsTable extends LawsuiteAgainsts
    with TableInfo<$LawsuiteAgainstsTable, LawsuiteAgainst> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LawsuiteAgainstsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _againstMeta = const VerificationMeta('against');
  @override
  late final GeneratedColumn<String?> against = GeneratedColumn<String?>(
      'against', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _lawsuiteIdMeta = const VerificationMeta('lawsuiteId');
  @override
  late final GeneratedColumn<int?> lawsuiteId = GeneratedColumn<int?>(
      'lawsuite_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES lawsuites(id)');
  @override
  List<GeneratedColumn> get $columns => [id, against, lawsuiteId];
  @override
  String get aliasedName => _alias ?? 'lawsuite_againsts';
  @override
  String get actualTableName => 'lawsuite_againsts';
  @override
  VerificationContext validateIntegrity(Insertable<LawsuiteAgainst> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('against')) {
      context.handle(_againstMeta,
          against.isAcceptableOrUnknown(data['against']!, _againstMeta));
    }
    if (data.containsKey('lawsuite_id')) {
      context.handle(
          _lawsuiteIdMeta,
          lawsuiteId.isAcceptableOrUnknown(
              data['lawsuite_id']!, _lawsuiteIdMeta));
    } else if (isInserting) {
      context.missing(_lawsuiteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LawsuiteAgainst map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LawsuiteAgainst.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LawsuiteAgainstsTable createAlias(String alias) {
    return $LawsuiteAgainstsTable(_db, alias);
  }
}

abstract class _$UserDatabase extends GeneratedDatabase {
  _$UserDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ClientNotesTable clientNotes = $ClientNotesTable(this);
  late final $ClientsLawsuitesTable clientsLawsuites =
      $ClientsLawsuitesTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $LawsuiteNotesTable lawsuiteNotes = $LawsuiteNotesTable(this);
  late final $LawsuitesTable lawsuites = $LawsuitesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $AppNotificationsTable appNotifications =
      $AppNotificationsTable(this);
  late final $AlertsTable alerts = $AlertsTable(this);
  late final $LawsuiteAgainstsTable lawsuiteAgainsts =
      $LawsuiteAgainstsTable(this);
  late final ClientDao clientDao = ClientDao(this as UserDatabase);
  late final LawsuiteDao lawsuiteDao = LawsuiteDao(this as UserDatabase);
  late final AlertDao alertDao = AlertDao(this as UserDatabase);
  late final NotificationDao notificationDao =
      NotificationDao(this as UserDatabase);
  late final ClientLawsuiteDao clientLawsuiteDao =
      ClientLawsuiteDao(this as UserDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        clientNotes,
        clientsLawsuites,
        clients,
        contacts,
        lawsuiteNotes,
        lawsuites,
        settings,
        appNotifications,
        alerts,
        lawsuiteAgainsts
      ];
}
