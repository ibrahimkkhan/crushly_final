// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDB.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class LocalMessage extends DataClass implements Insertable<LocalMessage> {
  final int id;
  final String message;
  final String createdAt;
  final bool isMine;
  final bool isRead;
  final String? receiverId;
  final String? authorId;
  LocalMessage(
      {required this.id,
      required this.message,
      required this.createdAt,
      required this.isMine,
      required this.isRead,
      this.receiverId,
      this.authorId});
  factory LocalMessage.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalMessage(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      message: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}message'])!,
      createdAt: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      isMine: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_mine'])!,
      isRead: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_read'])!,
      receiverId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}receiver_id']),
      authorId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<String>(createdAt);
    map['is_mine'] = Variable<bool>(isMine);
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || receiverId != null) {
      map['receiver_id'] = Variable<String?>(receiverId);
    }
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String?>(authorId);
    }
    return map;
  }

  LocalMessagesCompanion toCompanion(bool nullToAbsent) {
    return LocalMessagesCompanion(
      id: Value(id),
      message: Value(message),
      createdAt: Value(createdAt),
      isMine: Value(isMine),
      isRead: Value(isRead),
      receiverId: receiverId == null && nullToAbsent
          ? const Value.absent()
          : Value(receiverId),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
    );
  }

  factory LocalMessage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalMessage(
      id: serializer.fromJson<int>(json['id']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      isMine: serializer.fromJson<bool>(json['isMine']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      receiverId: serializer.fromJson<String?>(json['receiverId']),
      authorId: serializer.fromJson<String?>(json['authorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<String>(createdAt),
      'isMine': serializer.toJson<bool>(isMine),
      'isRead': serializer.toJson<bool>(isRead),
      'receiverId': serializer.toJson<String?>(receiverId),
      'authorId': serializer.toJson<String?>(authorId),
    };
  }

  LocalMessage copyWith(
          {int? id,
          String? message,
          String? createdAt,
          bool? isMine,
          bool? isRead,
          String? receiverId,
          String? authorId}) =>
      LocalMessage(
        id: id ?? this.id,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        isMine: isMine ?? this.isMine,
        isRead: isRead ?? this.isRead,
        receiverId: receiverId ?? this.receiverId,
        authorId: authorId ?? this.authorId,
      );
  @override
  String toString() {
    return (StringBuffer('LocalMessage(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('isMine: $isMine, ')
          ..write('isRead: $isRead, ')
          ..write('receiverId: $receiverId, ')
          ..write('authorId: $authorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          message.hashCode,
          $mrjc(
              createdAt.hashCode,
              $mrjc(
                  isMine.hashCode,
                  $mrjc(isRead.hashCode,
                      $mrjc(receiverId.hashCode, authorId.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMessage &&
          other.id == this.id &&
          other.message == this.message &&
          other.createdAt == this.createdAt &&
          other.isMine == this.isMine &&
          other.isRead == this.isRead &&
          other.receiverId == this.receiverId &&
          other.authorId == this.authorId);
}

class LocalMessagesCompanion extends UpdateCompanion<LocalMessage> {
  final Value<int> id;
  final Value<String> message;
  final Value<String> createdAt;
  final Value<bool> isMine;
  final Value<bool> isRead;
  final Value<String?> receiverId;
  final Value<String?> authorId;
  const LocalMessagesCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isMine = const Value.absent(),
    this.isRead = const Value.absent(),
    this.receiverId = const Value.absent(),
    this.authorId = const Value.absent(),
  });
  LocalMessagesCompanion.insert({
    this.id = const Value.absent(),
    required String message,
    required String createdAt,
    this.isMine = const Value.absent(),
    this.isRead = const Value.absent(),
    this.receiverId = const Value.absent(),
    this.authorId = const Value.absent(),
  })  : message = Value(message),
        createdAt = Value(createdAt);
  static Insertable<LocalMessage> custom({
    Expression<int>? id,
    Expression<String>? message,
    Expression<String>? createdAt,
    Expression<bool>? isMine,
    Expression<bool>? isRead,
    Expression<String?>? receiverId,
    Expression<String?>? authorId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (isMine != null) 'is_mine': isMine,
      if (isRead != null) 'is_read': isRead,
      if (receiverId != null) 'receiver_id': receiverId,
      if (authorId != null) 'author_id': authorId,
    });
  }

  LocalMessagesCompanion copyWith(
      {Value<int>? id,
      Value<String>? message,
      Value<String>? createdAt,
      Value<bool>? isMine,
      Value<bool>? isRead,
      Value<String?>? receiverId,
      Value<String?>? authorId}) {
    return LocalMessagesCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isMine: isMine ?? this.isMine,
      isRead: isRead ?? this.isRead,
      receiverId: receiverId ?? this.receiverId,
      authorId: authorId ?? this.authorId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (isMine.present) {
      map['is_mine'] = Variable<bool>(isMine.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (receiverId.present) {
      map['receiver_id'] = Variable<String?>(receiverId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String?>(authorId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMessagesCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('isMine: $isMine, ')
          ..write('isRead: $isRead, ')
          ..write('receiverId: $receiverId, ')
          ..write('authorId: $authorId')
          ..write(')'))
        .toString();
  }
}

class $LocalMessagesTable extends LocalMessages
    with TableInfo<$LocalMessagesTable, LocalMessage> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LocalMessagesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _messageMeta = const VerificationMeta('message');
  @override
  late final GeneratedTextColumn message = _constructMessage();
  GeneratedTextColumn _constructMessage() {
    return GeneratedTextColumn(
      'message',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedTextColumn createdAt = _constructCreatedAt();
  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isMineMeta = const VerificationMeta('isMine');
  @override
  late final GeneratedBoolColumn isMine = _constructIsMine();
  GeneratedBoolColumn _constructIsMine() {
    return GeneratedBoolColumn('is_mine', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedBoolColumn isRead = _constructIsRead();
  GeneratedBoolColumn _constructIsRead() {
    return GeneratedBoolColumn('is_read', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _receiverIdMeta = const VerificationMeta('receiverId');
  @override
  late final GeneratedTextColumn receiverId = _constructReceiverId();
  GeneratedTextColumn _constructReceiverId() {
    return GeneratedTextColumn(
      'receiver_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _authorIdMeta = const VerificationMeta('authorId');
  @override
  late final GeneratedTextColumn authorId = _constructAuthorId();
  GeneratedTextColumn _constructAuthorId() {
    return GeneratedTextColumn(
      'author_id',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, message, createdAt, isMine, isRead, receiverId, authorId];
  @override
  $LocalMessagesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'local_messages';
  @override
  final String actualTableName = 'local_messages';
  @override
  VerificationContext validateIntegrity(Insertable<LocalMessage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_mine')) {
      context.handle(_isMineMeta,
          isMine.isAcceptableOrUnknown(data['is_mine']!, _isMineMeta));
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    if (data.containsKey('receiver_id')) {
      context.handle(
          _receiverIdMeta,
          receiverId.isAcceptableOrUnknown(
              data['receiver_id']!, _receiverIdMeta));
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalMessage.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalMessagesTable createAlias(String alias) {
    return $LocalMessagesTable(_db, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final String id;
  final String? name;
  final String? image;
  final String? nameBeforeReaveal;
  final bool revealed;
  final int? lastMessage;
  final DateTime? updatedAt;
  final int? numOfUnRead;
  final int? relation;
  final bool orginalySecret;
  final bool presentlySecret;
  final bool notify;
  LocalUser(
      {required this.id,
      this.name,
      this.image,
      this.nameBeforeReaveal,
      required this.revealed,
      this.lastMessage,
      this.updatedAt,
      this.numOfUnRead,
      this.relation,
      required this.orginalySecret,
      required this.presentlySecret,
      required this.notify});
  factory LocalUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalUser(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image']),
      nameBeforeReaveal: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}name_before_reaveal']),
      revealed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}revealed'])!,
      lastMessage: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_message']),
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
      numOfUnRead: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}num_of_un_read']),
      relation: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}relation']),
      orginalySecret: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}orginaly_secret'])!,
      presentlySecret: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}presently_secret'])!,
      notify: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notify'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String?>(image);
    }
    if (!nullToAbsent || nameBeforeReaveal != null) {
      map['name_before_reaveal'] = Variable<String?>(nameBeforeReaveal);
    }
    map['revealed'] = Variable<bool>(revealed);
    if (!nullToAbsent || lastMessage != null) {
      map['last_message'] = Variable<int?>(lastMessage);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime?>(updatedAt);
    }
    if (!nullToAbsent || numOfUnRead != null) {
      map['num_of_un_read'] = Variable<int?>(numOfUnRead);
    }
    if (!nullToAbsent || relation != null) {
      map['relation'] = Variable<int?>(relation);
    }
    map['orginaly_secret'] = Variable<bool>(orginalySecret);
    map['presently_secret'] = Variable<bool>(presentlySecret);
    map['notify'] = Variable<bool>(notify);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      nameBeforeReaveal: nameBeforeReaveal == null && nullToAbsent
          ? const Value.absent()
          : Value(nameBeforeReaveal),
      revealed: Value(revealed),
      lastMessage: lastMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessage),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      numOfUnRead: numOfUnRead == null && nullToAbsent
          ? const Value.absent()
          : Value(numOfUnRead),
      relation: relation == null && nullToAbsent
          ? const Value.absent()
          : Value(relation),
      orginalySecret: Value(orginalySecret),
      presentlySecret: Value(presentlySecret),
      notify: Value(notify),
    );
  }

  factory LocalUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalUser(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      image: serializer.fromJson<String?>(json['image']),
      nameBeforeReaveal:
          serializer.fromJson<String?>(json['nameBeforeReaveal']),
      revealed: serializer.fromJson<bool>(json['revealed']),
      lastMessage: serializer.fromJson<int?>(json['lastMessage']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      numOfUnRead: serializer.fromJson<int?>(json['numOfUnRead']),
      relation: serializer.fromJson<int?>(json['relation']),
      orginalySecret: serializer.fromJson<bool>(json['orginalySecret']),
      presentlySecret: serializer.fromJson<bool>(json['presentlySecret']),
      notify: serializer.fromJson<bool>(json['notify']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'image': serializer.toJson<String?>(image),
      'nameBeforeReaveal': serializer.toJson<String?>(nameBeforeReaveal),
      'revealed': serializer.toJson<bool>(revealed),
      'lastMessage': serializer.toJson<int?>(lastMessage),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'numOfUnRead': serializer.toJson<int?>(numOfUnRead),
      'relation': serializer.toJson<int?>(relation),
      'orginalySecret': serializer.toJson<bool>(orginalySecret),
      'presentlySecret': serializer.toJson<bool>(presentlySecret),
      'notify': serializer.toJson<bool>(notify),
    };
  }

  LocalUser copyWith(
          {String? id,
          String? name,
          String? image,
          String? nameBeforeReaveal,
          bool? revealed,
          int? lastMessage,
          DateTime? updatedAt,
          int? numOfUnRead,
          int? relation,
          bool? orginalySecret,
          bool? presentlySecret,
          bool? notify}) =>
      LocalUser(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        nameBeforeReaveal: nameBeforeReaveal ?? this.nameBeforeReaveal,
        revealed: revealed ?? this.revealed,
        lastMessage: lastMessage ?? this.lastMessage,
        updatedAt: updatedAt ?? this.updatedAt,
        numOfUnRead: numOfUnRead ?? this.numOfUnRead,
        relation: relation ?? this.relation,
        orginalySecret: orginalySecret ?? this.orginalySecret,
        presentlySecret: presentlySecret ?? this.presentlySecret,
        notify: notify ?? this.notify,
      );
  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('nameBeforeReaveal: $nameBeforeReaveal, ')
          ..write('revealed: $revealed, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('numOfUnRead: $numOfUnRead, ')
          ..write('relation: $relation, ')
          ..write('orginalySecret: $orginalySecret, ')
          ..write('presentlySecret: $presentlySecret, ')
          ..write('notify: $notify')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              image.hashCode,
              $mrjc(
                  nameBeforeReaveal.hashCode,
                  $mrjc(
                      revealed.hashCode,
                      $mrjc(
                          lastMessage.hashCode,
                          $mrjc(
                              updatedAt.hashCode,
                              $mrjc(
                                  numOfUnRead.hashCode,
                                  $mrjc(
                                      relation.hashCode,
                                      $mrjc(
                                          orginalySecret.hashCode,
                                          $mrjc(presentlySecret.hashCode,
                                              notify.hashCode))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.nameBeforeReaveal == this.nameBeforeReaveal &&
          other.revealed == this.revealed &&
          other.lastMessage == this.lastMessage &&
          other.updatedAt == this.updatedAt &&
          other.numOfUnRead == this.numOfUnRead &&
          other.relation == this.relation &&
          other.orginalySecret == this.orginalySecret &&
          other.presentlySecret == this.presentlySecret &&
          other.notify == this.notify);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> image;
  final Value<String?> nameBeforeReaveal;
  final Value<bool> revealed;
  final Value<int?> lastMessage;
  final Value<DateTime?> updatedAt;
  final Value<int?> numOfUnRead;
  final Value<int?> relation;
  final Value<bool> orginalySecret;
  final Value<bool> presentlySecret;
  final Value<bool> notify;
  const LocalUsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.nameBeforeReaveal = const Value.absent(),
    this.revealed = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.numOfUnRead = const Value.absent(),
    this.relation = const Value.absent(),
    this.orginalySecret = const Value.absent(),
    this.presentlySecret = const Value.absent(),
    this.notify = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.nameBeforeReaveal = const Value.absent(),
    this.revealed = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.numOfUnRead = const Value.absent(),
    this.relation = const Value.absent(),
    this.orginalySecret = const Value.absent(),
    this.presentlySecret = const Value.absent(),
    this.notify = const Value.absent(),
  }) : id = Value(id);
  static Insertable<LocalUser> custom({
    Expression<String>? id,
    Expression<String?>? name,
    Expression<String?>? image,
    Expression<String?>? nameBeforeReaveal,
    Expression<bool>? revealed,
    Expression<int?>? lastMessage,
    Expression<DateTime?>? updatedAt,
    Expression<int?>? numOfUnRead,
    Expression<int?>? relation,
    Expression<bool>? orginalySecret,
    Expression<bool>? presentlySecret,
    Expression<bool>? notify,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (nameBeforeReaveal != null) 'name_before_reaveal': nameBeforeReaveal,
      if (revealed != null) 'revealed': revealed,
      if (lastMessage != null) 'last_message': lastMessage,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (numOfUnRead != null) 'num_of_un_read': numOfUnRead,
      if (relation != null) 'relation': relation,
      if (orginalySecret != null) 'orginaly_secret': orginalySecret,
      if (presentlySecret != null) 'presently_secret': presentlySecret,
      if (notify != null) 'notify': notify,
    });
  }

  LocalUsersCompanion copyWith(
      {Value<String>? id,
      Value<String?>? name,
      Value<String?>? image,
      Value<String?>? nameBeforeReaveal,
      Value<bool>? revealed,
      Value<int?>? lastMessage,
      Value<DateTime?>? updatedAt,
      Value<int?>? numOfUnRead,
      Value<int?>? relation,
      Value<bool>? orginalySecret,
      Value<bool>? presentlySecret,
      Value<bool>? notify}) {
    return LocalUsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      nameBeforeReaveal: nameBeforeReaveal ?? this.nameBeforeReaveal,
      revealed: revealed ?? this.revealed,
      lastMessage: lastMessage ?? this.lastMessage,
      updatedAt: updatedAt ?? this.updatedAt,
      numOfUnRead: numOfUnRead ?? this.numOfUnRead,
      relation: relation ?? this.relation,
      orginalySecret: orginalySecret ?? this.orginalySecret,
      presentlySecret: presentlySecret ?? this.presentlySecret,
      notify: notify ?? this.notify,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String?>(image.value);
    }
    if (nameBeforeReaveal.present) {
      map['name_before_reaveal'] = Variable<String?>(nameBeforeReaveal.value);
    }
    if (revealed.present) {
      map['revealed'] = Variable<bool>(revealed.value);
    }
    if (lastMessage.present) {
      map['last_message'] = Variable<int?>(lastMessage.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime?>(updatedAt.value);
    }
    if (numOfUnRead.present) {
      map['num_of_un_read'] = Variable<int?>(numOfUnRead.value);
    }
    if (relation.present) {
      map['relation'] = Variable<int?>(relation.value);
    }
    if (orginalySecret.present) {
      map['orginaly_secret'] = Variable<bool>(orginalySecret.value);
    }
    if (presentlySecret.present) {
      map['presently_secret'] = Variable<bool>(presentlySecret.value);
    }
    if (notify.present) {
      map['notify'] = Variable<bool>(notify.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('nameBeforeReaveal: $nameBeforeReaveal, ')
          ..write('revealed: $revealed, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('numOfUnRead: $numOfUnRead, ')
          ..write('relation: $relation, ')
          ..write('orginalySecret: $orginalySecret, ')
          ..write('presentlySecret: $presentlySecret, ')
          ..write('notify: $notify')
          ..write(')'))
        .toString();
  }
}

class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LocalUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedTextColumn image = _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameBeforeReavealMeta =
      const VerificationMeta('nameBeforeReaveal');
  @override
  late final GeneratedTextColumn nameBeforeReaveal =
      _constructNameBeforeReaveal();
  GeneratedTextColumn _constructNameBeforeReaveal() {
    return GeneratedTextColumn(
      'name_before_reaveal',
      $tableName,
      true,
    );
  }

  final VerificationMeta _revealedMeta = const VerificationMeta('revealed');
  @override
  late final GeneratedBoolColumn revealed = _constructRevealed();
  GeneratedBoolColumn _constructRevealed() {
    return GeneratedBoolColumn('revealed', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _lastMessageMeta =
      const VerificationMeta('lastMessage');
  @override
  late final GeneratedIntColumn lastMessage = _constructLastMessage();
  GeneratedIntColumn _constructLastMessage() {
    return GeneratedIntColumn(
      'last_message',
      $tableName,
      true,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedDateTimeColumn updatedAt = _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _numOfUnReadMeta =
      const VerificationMeta('numOfUnRead');
  @override
  late final GeneratedIntColumn numOfUnRead = _constructNumOfUnRead();
  GeneratedIntColumn _constructNumOfUnRead() {
    return GeneratedIntColumn(
      'num_of_un_read',
      $tableName,
      true,
    );
  }

  final VerificationMeta _relationMeta = const VerificationMeta('relation');
  @override
  late final GeneratedIntColumn relation = _constructRelation();
  GeneratedIntColumn _constructRelation() {
    return GeneratedIntColumn(
      'relation',
      $tableName,
      true,
    );
  }

  final VerificationMeta _orginalySecretMeta =
      const VerificationMeta('orginalySecret');
  @override
  late final GeneratedBoolColumn orginalySecret = _constructOrginalySecret();
  GeneratedBoolColumn _constructOrginalySecret() {
    return GeneratedBoolColumn('orginaly_secret', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _presentlySecretMeta =
      const VerificationMeta('presentlySecret');
  @override
  late final GeneratedBoolColumn presentlySecret = _constructPresentlySecret();
  GeneratedBoolColumn _constructPresentlySecret() {
    return GeneratedBoolColumn('presently_secret', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _notifyMeta = const VerificationMeta('notify');
  @override
  late final GeneratedBoolColumn notify = _constructNotify();
  GeneratedBoolColumn _constructNotify() {
    return GeneratedBoolColumn('notify', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        image,
        nameBeforeReaveal,
        revealed,
        lastMessage,
        updatedAt,
        numOfUnRead,
        relation,
        orginalySecret,
        presentlySecret,
        notify
      ];
  @override
  $LocalUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'local_users';
  @override
  final String actualTableName = 'local_users';
  @override
  VerificationContext validateIntegrity(Insertable<LocalUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('name_before_reaveal')) {
      context.handle(
          _nameBeforeReavealMeta,
          nameBeforeReaveal.isAcceptableOrUnknown(
              data['name_before_reaveal']!, _nameBeforeReavealMeta));
    }
    if (data.containsKey('revealed')) {
      context.handle(_revealedMeta,
          revealed.isAcceptableOrUnknown(data['revealed']!, _revealedMeta));
    }
    if (data.containsKey('last_message')) {
      context.handle(
          _lastMessageMeta,
          lastMessage.isAcceptableOrUnknown(
              data['last_message']!, _lastMessageMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('num_of_un_read')) {
      context.handle(
          _numOfUnReadMeta,
          numOfUnRead.isAcceptableOrUnknown(
              data['num_of_un_read']!, _numOfUnReadMeta));
    }
    if (data.containsKey('relation')) {
      context.handle(_relationMeta,
          relation.isAcceptableOrUnknown(data['relation']!, _relationMeta));
    }
    if (data.containsKey('orginaly_secret')) {
      context.handle(
          _orginalySecretMeta,
          orginalySecret.isAcceptableOrUnknown(
              data['orginaly_secret']!, _orginalySecretMeta));
    }
    if (data.containsKey('presently_secret')) {
      context.handle(
          _presentlySecretMeta,
          presentlySecret.isAcceptableOrUnknown(
              data['presently_secret']!, _presentlySecretMeta));
    }
    if (data.containsKey('notify')) {
      context.handle(_notifyMeta,
          notify.isAcceptableOrUnknown(data['notify']!, _notifyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalUser.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(_db, alias);
  }
}

class FolloweeUser extends DataClass implements Insertable<FolloweeUser> {
  final String id;
  final String? name;
  final String? nameBeforeReaveal;
  final String? thumbnail;
  final bool revealed;
  final bool orginalySecret;
  final bool presentlySecret;
  final bool notify;
  FolloweeUser(
      {required this.id,
      this.name,
      this.nameBeforeReaveal,
      this.thumbnail,
      required this.revealed,
      required this.orginalySecret,
      required this.presentlySecret,
      required this.notify});
  factory FolloweeUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FolloweeUser(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      nameBeforeReaveal: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}name_before_reaveal']),
      thumbnail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail']),
      revealed: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}revealed'])!,
      orginalySecret: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}orginaly_secret'])!,
      presentlySecret: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}presently_secret'])!,
      notify: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notify'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || nameBeforeReaveal != null) {
      map['name_before_reaveal'] = Variable<String?>(nameBeforeReaveal);
    }
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String?>(thumbnail);
    }
    map['revealed'] = Variable<bool>(revealed);
    map['orginaly_secret'] = Variable<bool>(orginalySecret);
    map['presently_secret'] = Variable<bool>(presentlySecret);
    map['notify'] = Variable<bool>(notify);
    return map;
  }

  FolloweeUsersCompanion toCompanion(bool nullToAbsent) {
    return FolloweeUsersCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      nameBeforeReaveal: nameBeforeReaveal == null && nullToAbsent
          ? const Value.absent()
          : Value(nameBeforeReaveal),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      revealed: Value(revealed),
      orginalySecret: Value(orginalySecret),
      presentlySecret: Value(presentlySecret),
      notify: Value(notify),
    );
  }

  factory FolloweeUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FolloweeUser(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      nameBeforeReaveal:
          serializer.fromJson<String?>(json['nameBeforeReaveal']),
      thumbnail: serializer.fromJson<String?>(json['thumbnail']),
      revealed: serializer.fromJson<bool>(json['revealed']),
      orginalySecret: serializer.fromJson<bool>(json['orginalySecret']),
      presentlySecret: serializer.fromJson<bool>(json['presentlySecret']),
      notify: serializer.fromJson<bool>(json['notify']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'nameBeforeReaveal': serializer.toJson<String?>(nameBeforeReaveal),
      'thumbnail': serializer.toJson<String?>(thumbnail),
      'revealed': serializer.toJson<bool>(revealed),
      'orginalySecret': serializer.toJson<bool>(orginalySecret),
      'presentlySecret': serializer.toJson<bool>(presentlySecret),
      'notify': serializer.toJson<bool>(notify),
    };
  }

  FolloweeUser copyWith(
          {String? id,
          String? name,
          String? nameBeforeReaveal,
          String? thumbnail,
          bool? revealed,
          bool? orginalySecret,
          bool? presentlySecret,
          bool? notify}) =>
      FolloweeUser(
        id: id ?? this.id,
        name: name ?? this.name,
        nameBeforeReaveal: nameBeforeReaveal ?? this.nameBeforeReaveal,
        thumbnail: thumbnail ?? this.thumbnail,
        revealed: revealed ?? this.revealed,
        orginalySecret: orginalySecret ?? this.orginalySecret,
        presentlySecret: presentlySecret ?? this.presentlySecret,
        notify: notify ?? this.notify,
      );
  @override
  String toString() {
    return (StringBuffer('FolloweeUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameBeforeReaveal: $nameBeforeReaveal, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('revealed: $revealed, ')
          ..write('orginalySecret: $orginalySecret, ')
          ..write('presentlySecret: $presentlySecret, ')
          ..write('notify: $notify')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              nameBeforeReaveal.hashCode,
              $mrjc(
                  thumbnail.hashCode,
                  $mrjc(
                      revealed.hashCode,
                      $mrjc(
                          orginalySecret.hashCode,
                          $mrjc(
                              presentlySecret.hashCode, notify.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FolloweeUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameBeforeReaveal == this.nameBeforeReaveal &&
          other.thumbnail == this.thumbnail &&
          other.revealed == this.revealed &&
          other.orginalySecret == this.orginalySecret &&
          other.presentlySecret == this.presentlySecret &&
          other.notify == this.notify);
}

class FolloweeUsersCompanion extends UpdateCompanion<FolloweeUser> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> nameBeforeReaveal;
  final Value<String?> thumbnail;
  final Value<bool> revealed;
  final Value<bool> orginalySecret;
  final Value<bool> presentlySecret;
  final Value<bool> notify;
  const FolloweeUsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameBeforeReaveal = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.revealed = const Value.absent(),
    this.orginalySecret = const Value.absent(),
    this.presentlySecret = const Value.absent(),
    this.notify = const Value.absent(),
  });
  FolloweeUsersCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.nameBeforeReaveal = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.revealed = const Value.absent(),
    this.orginalySecret = const Value.absent(),
    this.presentlySecret = const Value.absent(),
    this.notify = const Value.absent(),
  }) : id = Value(id);
  static Insertable<FolloweeUser> custom({
    Expression<String>? id,
    Expression<String?>? name,
    Expression<String?>? nameBeforeReaveal,
    Expression<String?>? thumbnail,
    Expression<bool>? revealed,
    Expression<bool>? orginalySecret,
    Expression<bool>? presentlySecret,
    Expression<bool>? notify,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameBeforeReaveal != null) 'name_before_reaveal': nameBeforeReaveal,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (revealed != null) 'revealed': revealed,
      if (orginalySecret != null) 'orginaly_secret': orginalySecret,
      if (presentlySecret != null) 'presently_secret': presentlySecret,
      if (notify != null) 'notify': notify,
    });
  }

  FolloweeUsersCompanion copyWith(
      {Value<String>? id,
      Value<String?>? name,
      Value<String?>? nameBeforeReaveal,
      Value<String?>? thumbnail,
      Value<bool>? revealed,
      Value<bool>? orginalySecret,
      Value<bool>? presentlySecret,
      Value<bool>? notify}) {
    return FolloweeUsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameBeforeReaveal: nameBeforeReaveal ?? this.nameBeforeReaveal,
      thumbnail: thumbnail ?? this.thumbnail,
      revealed: revealed ?? this.revealed,
      orginalySecret: orginalySecret ?? this.orginalySecret,
      presentlySecret: presentlySecret ?? this.presentlySecret,
      notify: notify ?? this.notify,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (nameBeforeReaveal.present) {
      map['name_before_reaveal'] = Variable<String?>(nameBeforeReaveal.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String?>(thumbnail.value);
    }
    if (revealed.present) {
      map['revealed'] = Variable<bool>(revealed.value);
    }
    if (orginalySecret.present) {
      map['orginaly_secret'] = Variable<bool>(orginalySecret.value);
    }
    if (presentlySecret.present) {
      map['presently_secret'] = Variable<bool>(presentlySecret.value);
    }
    if (notify.present) {
      map['notify'] = Variable<bool>(notify.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FolloweeUsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameBeforeReaveal: $nameBeforeReaveal, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('revealed: $revealed, ')
          ..write('orginalySecret: $orginalySecret, ')
          ..write('presentlySecret: $presentlySecret, ')
          ..write('notify: $notify')
          ..write(')'))
        .toString();
  }
}

class $FolloweeUsersTable extends FolloweeUsers
    with TableInfo<$FolloweeUsersTable, FolloweeUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FolloweeUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameBeforeReavealMeta =
      const VerificationMeta('nameBeforeReaveal');
  @override
  late final GeneratedTextColumn nameBeforeReaveal =
      _constructNameBeforeReaveal();
  GeneratedTextColumn _constructNameBeforeReaveal() {
    return GeneratedTextColumn(
      'name_before_reaveal',
      $tableName,
      true,
    );
  }

  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  @override
  late final GeneratedTextColumn thumbnail = _constructThumbnail();
  GeneratedTextColumn _constructThumbnail() {
    return GeneratedTextColumn(
      'thumbnail',
      $tableName,
      true,
    );
  }

  final VerificationMeta _revealedMeta = const VerificationMeta('revealed');
  @override
  late final GeneratedBoolColumn revealed = _constructRevealed();
  GeneratedBoolColumn _constructRevealed() {
    return GeneratedBoolColumn('revealed', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _orginalySecretMeta =
      const VerificationMeta('orginalySecret');
  @override
  late final GeneratedBoolColumn orginalySecret = _constructOrginalySecret();
  GeneratedBoolColumn _constructOrginalySecret() {
    return GeneratedBoolColumn('orginaly_secret', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _presentlySecretMeta =
      const VerificationMeta('presentlySecret');
  @override
  late final GeneratedBoolColumn presentlySecret = _constructPresentlySecret();
  GeneratedBoolColumn _constructPresentlySecret() {
    return GeneratedBoolColumn('presently_secret', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _notifyMeta = const VerificationMeta('notify');
  @override
  late final GeneratedBoolColumn notify = _constructNotify();
  GeneratedBoolColumn _constructNotify() {
    return GeneratedBoolColumn('notify', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        nameBeforeReaveal,
        thumbnail,
        revealed,
        orginalySecret,
        presentlySecret,
        notify
      ];
  @override
  $FolloweeUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'followee_users';
  @override
  final String actualTableName = 'followee_users';
  @override
  VerificationContext validateIntegrity(Insertable<FolloweeUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('name_before_reaveal')) {
      context.handle(
          _nameBeforeReavealMeta,
          nameBeforeReaveal.isAcceptableOrUnknown(
              data['name_before_reaveal']!, _nameBeforeReavealMeta));
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    }
    if (data.containsKey('revealed')) {
      context.handle(_revealedMeta,
          revealed.isAcceptableOrUnknown(data['revealed']!, _revealedMeta));
    }
    if (data.containsKey('orginaly_secret')) {
      context.handle(
          _orginalySecretMeta,
          orginalySecret.isAcceptableOrUnknown(
              data['orginaly_secret']!, _orginalySecretMeta));
    }
    if (data.containsKey('presently_secret')) {
      context.handle(
          _presentlySecretMeta,
          presentlySecret.isAcceptableOrUnknown(
              data['presently_secret']!, _presentlySecretMeta));
    }
    if (data.containsKey('notify')) {
      context.handle(_notifyMeta,
          notify.isAcceptableOrUnknown(data['notify']!, _notifyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  FolloweeUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FolloweeUser.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FolloweeUsersTable createAlias(String alias) {
    return $FolloweeUsersTable(_db, alias);
  }
}

class DateUser extends DataClass implements Insertable<DateUser> {
  final String partnerId;
  final String? name;
  final String? profilePhoto;
  final String? thumbnail;
  final bool notify;
  DateUser(
      {required this.partnerId,
      this.name,
      this.profilePhoto,
      this.thumbnail,
      required this.notify});
  factory DateUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DateUser(
      partnerId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}partner_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      profilePhoto: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_photo']),
      thumbnail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail']),
      notify: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}notify'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['partner_id'] = Variable<String>(partnerId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || profilePhoto != null) {
      map['profile_photo'] = Variable<String?>(profilePhoto);
    }
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String?>(thumbnail);
    }
    map['notify'] = Variable<bool>(notify);
    return map;
  }

  DateUsersCompanion toCompanion(bool nullToAbsent) {
    return DateUsersCompanion(
      partnerId: Value(partnerId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      profilePhoto: profilePhoto == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePhoto),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
      notify: Value(notify),
    );
  }

  factory DateUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DateUser(
      partnerId: serializer.fromJson<String>(json['partnerId']),
      name: serializer.fromJson<String?>(json['name']),
      profilePhoto: serializer.fromJson<String?>(json['profilePhoto']),
      thumbnail: serializer.fromJson<String?>(json['thumbnail']),
      notify: serializer.fromJson<bool>(json['notify']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partnerId': serializer.toJson<String>(partnerId),
      'name': serializer.toJson<String?>(name),
      'profilePhoto': serializer.toJson<String?>(profilePhoto),
      'thumbnail': serializer.toJson<String?>(thumbnail),
      'notify': serializer.toJson<bool>(notify),
    };
  }

  DateUser copyWith(
          {String? partnerId,
          String? name,
          String? profilePhoto,
          String? thumbnail,
          bool? notify}) =>
      DateUser(
        partnerId: partnerId ?? this.partnerId,
        name: name ?? this.name,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        thumbnail: thumbnail ?? this.thumbnail,
        notify: notify ?? this.notify,
      );
  @override
  String toString() {
    return (StringBuffer('DateUser(')
          ..write('partnerId: $partnerId, ')
          ..write('name: $name, ')
          ..write('profilePhoto: $profilePhoto, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('notify: $notify')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      partnerId.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(profilePhoto.hashCode,
              $mrjc(thumbnail.hashCode, notify.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DateUser &&
          other.partnerId == this.partnerId &&
          other.name == this.name &&
          other.profilePhoto == this.profilePhoto &&
          other.thumbnail == this.thumbnail &&
          other.notify == this.notify);
}

class DateUsersCompanion extends UpdateCompanion<DateUser> {
  final Value<String> partnerId;
  final Value<String?> name;
  final Value<String?> profilePhoto;
  final Value<String?> thumbnail;
  final Value<bool> notify;
  const DateUsersCompanion({
    this.partnerId = const Value.absent(),
    this.name = const Value.absent(),
    this.profilePhoto = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.notify = const Value.absent(),
  });
  DateUsersCompanion.insert({
    required String partnerId,
    this.name = const Value.absent(),
    this.profilePhoto = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.notify = const Value.absent(),
  }) : partnerId = Value(partnerId);
  static Insertable<DateUser> custom({
    Expression<String>? partnerId,
    Expression<String?>? name,
    Expression<String?>? profilePhoto,
    Expression<String?>? thumbnail,
    Expression<bool>? notify,
  }) {
    return RawValuesInsertable({
      if (partnerId != null) 'partner_id': partnerId,
      if (name != null) 'name': name,
      if (profilePhoto != null) 'profile_photo': profilePhoto,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (notify != null) 'notify': notify,
    });
  }

  DateUsersCompanion copyWith(
      {Value<String>? partnerId,
      Value<String?>? name,
      Value<String?>? profilePhoto,
      Value<String?>? thumbnail,
      Value<bool>? notify}) {
    return DateUsersCompanion(
      partnerId: partnerId ?? this.partnerId,
      name: name ?? this.name,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      thumbnail: thumbnail ?? this.thumbnail,
      notify: notify ?? this.notify,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (partnerId.present) {
      map['partner_id'] = Variable<String>(partnerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (profilePhoto.present) {
      map['profile_photo'] = Variable<String?>(profilePhoto.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String?>(thumbnail.value);
    }
    if (notify.present) {
      map['notify'] = Variable<bool>(notify.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DateUsersCompanion(')
          ..write('partnerId: $partnerId, ')
          ..write('name: $name, ')
          ..write('profilePhoto: $profilePhoto, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('notify: $notify')
          ..write(')'))
        .toString();
  }
}

class $DateUsersTable extends DateUsers
    with TableInfo<$DateUsersTable, DateUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DateUsersTable(this._db, [this._alias]);
  final VerificationMeta _partnerIdMeta = const VerificationMeta('partnerId');
  @override
  late final GeneratedTextColumn partnerId = _constructPartnerId();
  GeneratedTextColumn _constructPartnerId() {
    return GeneratedTextColumn(
      'partner_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _profilePhotoMeta =
      const VerificationMeta('profilePhoto');
  @override
  late final GeneratedTextColumn profilePhoto = _constructProfilePhoto();
  GeneratedTextColumn _constructProfilePhoto() {
    return GeneratedTextColumn(
      'profile_photo',
      $tableName,
      true,
    );
  }

  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  @override
  late final GeneratedTextColumn thumbnail = _constructThumbnail();
  GeneratedTextColumn _constructThumbnail() {
    return GeneratedTextColumn(
      'thumbnail',
      $tableName,
      true,
    );
  }

  final VerificationMeta _notifyMeta = const VerificationMeta('notify');
  @override
  late final GeneratedBoolColumn notify = _constructNotify();
  GeneratedBoolColumn _constructNotify() {
    return GeneratedBoolColumn('notify', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [partnerId, name, profilePhoto, thumbnail, notify];
  @override
  $DateUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'date_users';
  @override
  final String actualTableName = 'date_users';
  @override
  VerificationContext validateIntegrity(Insertable<DateUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('partner_id')) {
      context.handle(_partnerIdMeta,
          partnerId.isAcceptableOrUnknown(data['partner_id']!, _partnerIdMeta));
    } else if (isInserting) {
      context.missing(_partnerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('profile_photo')) {
      context.handle(
          _profilePhotoMeta,
          profilePhoto.isAcceptableOrUnknown(
              data['profile_photo']!, _profilePhotoMeta));
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    }
    if (data.containsKey('notify')) {
      context.handle(_notifyMeta,
          notify.isAcceptableOrUnknown(data['notify']!, _notifyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DateUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DateUser.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DateUsersTable createAlias(String alias) {
    return $DateUsersTable(_db, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String userName;
  final String userId;
  final String type;
  final String image;
  final DateTime createdAt;
  final bool seen;
  Notification(
      {required this.userName,
      required this.userId,
      required this.type,
      required this.image,
      required this.createdAt,
      required this.seen});
  factory Notification.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Notification(
      userName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_name'])!,
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      seen: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}seen'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_name'] = Variable<String>(userName);
    map['user_id'] = Variable<String>(userId);
    map['type'] = Variable<String>(type);
    map['image'] = Variable<String>(image);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['seen'] = Variable<bool>(seen);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      userName: Value(userName),
      userId: Value(userId),
      type: Value(type),
      image: Value(image),
      createdAt: Value(createdAt),
      seen: Value(seen),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Notification(
      userName: serializer.fromJson<String>(json['userName']),
      userId: serializer.fromJson<String>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      image: serializer.fromJson<String>(json['image']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      seen: serializer.fromJson<bool>(json['seen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userName': serializer.toJson<String>(userName),
      'userId': serializer.toJson<String>(userId),
      'type': serializer.toJson<String>(type),
      'image': serializer.toJson<String>(image),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'seen': serializer.toJson<bool>(seen),
    };
  }

  Notification copyWith(
          {String? userName,
          String? userId,
          String? type,
          String? image,
          DateTime? createdAt,
          bool? seen}) =>
      Notification(
        userName: userName ?? this.userName,
        userId: userId ?? this.userId,
        type: type ?? this.type,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        seen: seen ?? this.seen,
      );
  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('userName: $userName, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('image: $image, ')
          ..write('createdAt: $createdAt, ')
          ..write('seen: $seen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      userName.hashCode,
      $mrjc(
          userId.hashCode,
          $mrjc(
              type.hashCode,
              $mrjc(
                  image.hashCode, $mrjc(createdAt.hashCode, seen.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.userName == this.userName &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.image == this.image &&
          other.createdAt == this.createdAt &&
          other.seen == this.seen);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> userName;
  final Value<String> userId;
  final Value<String> type;
  final Value<String> image;
  final Value<DateTime> createdAt;
  final Value<bool> seen;
  const NotificationsCompanion({
    this.userName = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.image = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.seen = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String userName,
    required String userId,
    required String type,
    required String image,
    required DateTime createdAt,
    this.seen = const Value.absent(),
  })  : userName = Value(userName),
        userId = Value(userId),
        type = Value(type),
        image = Value(image),
        createdAt = Value(createdAt);
  static Insertable<Notification> custom({
    Expression<String>? userName,
    Expression<String>? userId,
    Expression<String>? type,
    Expression<String>? image,
    Expression<DateTime>? createdAt,
    Expression<bool>? seen,
  }) {
    return RawValuesInsertable({
      if (userName != null) 'user_name': userName,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (image != null) 'image': image,
      if (createdAt != null) 'created_at': createdAt,
      if (seen != null) 'seen': seen,
    });
  }

  NotificationsCompanion copyWith(
      {Value<String>? userName,
      Value<String>? userId,
      Value<String>? type,
      Value<String>? image,
      Value<DateTime>? createdAt,
      Value<bool>? seen}) {
    return NotificationsCompanion(
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      seen: seen ?? this.seen,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (seen.present) {
      map['seen'] = Variable<bool>(seen.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('userName: $userName, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('image: $image, ')
          ..write('createdAt: $createdAt, ')
          ..write('seen: $seen')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  final GeneratedDatabase _db;
  final String? _alias;
  $NotificationsTable(this._db, [this._alias]);
  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  @override
  late final GeneratedTextColumn userName = _constructUserName();
  GeneratedTextColumn _constructUserName() {
    return GeneratedTextColumn(
      'user_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedTextColumn userId = _constructUserId();
  GeneratedTextColumn _constructUserId() {
    return GeneratedTextColumn(
      'user_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedTextColumn type = _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedTextColumn image = _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedDateTimeColumn createdAt = _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _seenMeta = const VerificationMeta('seen');
  @override
  late final GeneratedBoolColumn seen = _constructSeen();
  GeneratedBoolColumn _constructSeen() {
    return GeneratedBoolColumn('seen', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [userName, userId, type, image, createdAt, seen];
  @override
  $NotificationsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notifications';
  @override
  final String actualTableName = 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('seen')) {
      context.handle(
          _seenMeta, seen.isAcceptableOrUnknown(data['seen']!, _seenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Notification.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(_db, alias);
  }
}

class LocalStory extends DataClass implements Insertable<LocalStory> {
  final int localId;
  final String id;
  final String authorId;
  final String url;
  final String storyText;
  final String authorName;
  final String createdAt;
  final bool private;
  LocalStory(
      {required this.localId,
      required this.id,
      required this.authorId,
      required this.url,
      required this.storyText,
      required this.authorName,
      required this.createdAt,
      required this.private});
  factory LocalStory.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalStory(
      localId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}local_id'])!,
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      authorId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author_id'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      storyText: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}story_text'])!,
      authorName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author_name'])!,
      createdAt: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      private: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}private'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['id'] = Variable<String>(id);
    map['author_id'] = Variable<String>(authorId);
    map['url'] = Variable<String>(url);
    map['story_text'] = Variable<String>(storyText);
    map['author_name'] = Variable<String>(authorName);
    map['created_at'] = Variable<String>(createdAt);
    map['private'] = Variable<bool>(private);
    return map;
  }

  LocalStorysCompanion toCompanion(bool nullToAbsent) {
    return LocalStorysCompanion(
      localId: Value(localId),
      id: Value(id),
      authorId: Value(authorId),
      url: Value(url),
      storyText: Value(storyText),
      authorName: Value(authorName),
      createdAt: Value(createdAt),
      private: Value(private),
    );
  }

  factory LocalStory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return LocalStory(
      localId: serializer.fromJson<int>(json['localId']),
      id: serializer.fromJson<String>(json['id']),
      authorId: serializer.fromJson<String>(json['authorId']),
      url: serializer.fromJson<String>(json['url']),
      storyText: serializer.fromJson<String>(json['storyText']),
      authorName: serializer.fromJson<String>(json['authorName']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      private: serializer.fromJson<bool>(json['private']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'id': serializer.toJson<String>(id),
      'authorId': serializer.toJson<String>(authorId),
      'url': serializer.toJson<String>(url),
      'storyText': serializer.toJson<String>(storyText),
      'authorName': serializer.toJson<String>(authorName),
      'createdAt': serializer.toJson<String>(createdAt),
      'private': serializer.toJson<bool>(private),
    };
  }

  LocalStory copyWith(
          {int? localId,
          String? id,
          String? authorId,
          String? url,
          String? storyText,
          String? authorName,
          String? createdAt,
          bool? private}) =>
      LocalStory(
        localId: localId ?? this.localId,
        id: id ?? this.id,
        authorId: authorId ?? this.authorId,
        url: url ?? this.url,
        storyText: storyText ?? this.storyText,
        authorName: authorName ?? this.authorName,
        createdAt: createdAt ?? this.createdAt,
        private: private ?? this.private,
      );
  @override
  String toString() {
    return (StringBuffer('LocalStory(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('url: $url, ')
          ..write('storyText: $storyText, ')
          ..write('authorName: $authorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('private: $private')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      localId.hashCode,
      $mrjc(
          id.hashCode,
          $mrjc(
              authorId.hashCode,
              $mrjc(
                  url.hashCode,
                  $mrjc(
                      storyText.hashCode,
                      $mrjc(authorName.hashCode,
                          $mrjc(createdAt.hashCode, private.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalStory &&
          other.localId == this.localId &&
          other.id == this.id &&
          other.authorId == this.authorId &&
          other.url == this.url &&
          other.storyText == this.storyText &&
          other.authorName == this.authorName &&
          other.createdAt == this.createdAt &&
          other.private == this.private);
}

class LocalStorysCompanion extends UpdateCompanion<LocalStory> {
  final Value<int> localId;
  final Value<String> id;
  final Value<String> authorId;
  final Value<String> url;
  final Value<String> storyText;
  final Value<String> authorName;
  final Value<String> createdAt;
  final Value<bool> private;
  const LocalStorysCompanion({
    this.localId = const Value.absent(),
    this.id = const Value.absent(),
    this.authorId = const Value.absent(),
    this.url = const Value.absent(),
    this.storyText = const Value.absent(),
    this.authorName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.private = const Value.absent(),
  });
  LocalStorysCompanion.insert({
    this.localId = const Value.absent(),
    required String id,
    required String authorId,
    required String url,
    required String storyText,
    required String authorName,
    required String createdAt,
    this.private = const Value.absent(),
  })  : id = Value(id),
        authorId = Value(authorId),
        url = Value(url),
        storyText = Value(storyText),
        authorName = Value(authorName),
        createdAt = Value(createdAt);
  static Insertable<LocalStory> custom({
    Expression<int>? localId,
    Expression<String>? id,
    Expression<String>? authorId,
    Expression<String>? url,
    Expression<String>? storyText,
    Expression<String>? authorName,
    Expression<String>? createdAt,
    Expression<bool>? private,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (id != null) 'id': id,
      if (authorId != null) 'author_id': authorId,
      if (url != null) 'url': url,
      if (storyText != null) 'story_text': storyText,
      if (authorName != null) 'author_name': authorName,
      if (createdAt != null) 'created_at': createdAt,
      if (private != null) 'private': private,
    });
  }

  LocalStorysCompanion copyWith(
      {Value<int>? localId,
      Value<String>? id,
      Value<String>? authorId,
      Value<String>? url,
      Value<String>? storyText,
      Value<String>? authorName,
      Value<String>? createdAt,
      Value<bool>? private}) {
    return LocalStorysCompanion(
      localId: localId ?? this.localId,
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      url: url ?? this.url,
      storyText: storyText ?? this.storyText,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      private: private ?? this.private,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (storyText.present) {
      map['story_text'] = Variable<String>(storyText.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (private.present) {
      map['private'] = Variable<bool>(private.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalStorysCompanion(')
          ..write('localId: $localId, ')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('url: $url, ')
          ..write('storyText: $storyText, ')
          ..write('authorName: $authorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('private: $private')
          ..write(')'))
        .toString();
  }
}

class $LocalStorysTable extends LocalStorys
    with TableInfo<$LocalStorysTable, LocalStory> {
  final GeneratedDatabase _db;
  final String? _alias;
  $LocalStorysTable(this._db, [this._alias]);
  final VerificationMeta _localIdMeta = const VerificationMeta('localId');
  @override
  late final GeneratedIntColumn localId = _constructLocalId();
  GeneratedIntColumn _constructLocalId() {
    return GeneratedIntColumn('local_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorIdMeta = const VerificationMeta('authorId');
  @override
  late final GeneratedTextColumn authorId = _constructAuthorId();
  GeneratedTextColumn _constructAuthorId() {
    return GeneratedTextColumn(
      'author_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedTextColumn url = _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn(
      'url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _storyTextMeta = const VerificationMeta('storyText');
  @override
  late final GeneratedTextColumn storyText = _constructStoryText();
  GeneratedTextColumn _constructStoryText() {
    return GeneratedTextColumn(
      'story_text',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorNameMeta = const VerificationMeta('authorName');
  @override
  late final GeneratedTextColumn authorName = _constructAuthorName();
  GeneratedTextColumn _constructAuthorName() {
    return GeneratedTextColumn(
      'author_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedTextColumn createdAt = _constructCreatedAt();
  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _privateMeta = const VerificationMeta('private');
  @override
  late final GeneratedBoolColumn private = _constructPrivate();
  GeneratedBoolColumn _constructPrivate() {
    return GeneratedBoolColumn('private', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [localId, id, authorId, url, storyText, authorName, createdAt, private];
  @override
  $LocalStorysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'local_storys';
  @override
  final String actualTableName = 'local_storys';
  @override
  VerificationContext validateIntegrity(Insertable<LocalStory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('story_text')) {
      context.handle(_storyTextMeta,
          storyText.isAcceptableOrUnknown(data['story_text']!, _storyTextMeta));
    } else if (isInserting) {
      context.missing(_storyTextMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
          _authorNameMeta,
          authorName.isAcceptableOrUnknown(
              data['author_name']!, _authorNameMeta));
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('private')) {
      context.handle(_privateMeta,
          private.isAcceptableOrUnknown(data['private']!, _privateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  LocalStory map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalStory.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalStorysTable createAlias(String alias) {
    return $LocalStorysTable(_db, alias);
  }
}

class StoryUser extends DataClass implements Insertable<StoryUser> {
  final String id;
  final String name;
  final DateTime? updatedAt;
  final int? lastStory;
  StoryUser(
      {required this.id, required this.name, this.updatedAt, this.lastStory});
  factory StoryUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return StoryUser(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
      lastStory: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_story']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime?>(updatedAt);
    }
    if (!nullToAbsent || lastStory != null) {
      map['last_story'] = Variable<int?>(lastStory);
    }
    return map;
  }

  StoryUsersCompanion toCompanion(bool nullToAbsent) {
    return StoryUsersCompanion(
      id: Value(id),
      name: Value(name),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      lastStory: lastStory == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStory),
    );
  }

  factory StoryUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return StoryUser(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      lastStory: serializer.fromJson<int?>(json['lastStory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'lastStory': serializer.toJson<int?>(lastStory),
    };
  }

  StoryUser copyWith(
          {String? id, String? name, DateTime? updatedAt, int? lastStory}) =>
      StoryUser(
        id: id ?? this.id,
        name: name ?? this.name,
        updatedAt: updatedAt ?? this.updatedAt,
        lastStory: lastStory ?? this.lastStory,
      );
  @override
  String toString() {
    return (StringBuffer('StoryUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastStory: $lastStory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(updatedAt.hashCode, lastStory.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoryUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.updatedAt == this.updatedAt &&
          other.lastStory == this.lastStory);
}

class StoryUsersCompanion extends UpdateCompanion<StoryUser> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime?> updatedAt;
  final Value<int?> lastStory;
  const StoryUsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastStory = const Value.absent(),
  });
  StoryUsersCompanion.insert({
    required String id,
    required String name,
    this.updatedAt = const Value.absent(),
    this.lastStory = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<StoryUser> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime?>? updatedAt,
    Expression<int?>? lastStory,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastStory != null) 'last_story': lastStory,
    });
  }

  StoryUsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<DateTime?>? updatedAt,
      Value<int?>? lastStory}) {
    return StoryUsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
      lastStory: lastStory ?? this.lastStory,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime?>(updatedAt.value);
    }
    if (lastStory.present) {
      map['last_story'] = Variable<int?>(lastStory.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoryUsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastStory: $lastStory')
          ..write(')'))
        .toString();
  }
}

class $StoryUsersTable extends StoryUsers
    with TableInfo<$StoryUsersTable, StoryUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $StoryUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedDateTimeColumn updatedAt = _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn(
      'updated_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _lastStoryMeta = const VerificationMeta('lastStory');
  @override
  late final GeneratedIntColumn lastStory = _constructLastStory();
  GeneratedIntColumn _constructLastStory() {
    return GeneratedIntColumn(
      'last_story',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, updatedAt, lastStory];
  @override
  $StoryUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'story_users';
  @override
  final String actualTableName = 'story_users';
  @override
  VerificationContext validateIntegrity(Insertable<StoryUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_story')) {
      context.handle(_lastStoryMeta,
          lastStory.isAcceptableOrUnknown(data['last_story']!, _lastStoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  StoryUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    return StoryUser.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $StoryUsersTable createAlias(String alias) {
    return $StoryUsersTable(_db, alias);
  }
}

class BlockedUser extends DataClass implements Insertable<BlockedUser> {
  final String id;
  BlockedUser({required this.id});
  factory BlockedUser.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return BlockedUser(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  BlockedUsersCompanion toCompanion(bool nullToAbsent) {
    return BlockedUsersCompanion(
      id: Value(id),
    );
  }

  factory BlockedUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BlockedUser(
      id: serializer.fromJson<String>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
    };
  }

  BlockedUser copyWith({String? id}) => BlockedUser(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('BlockedUser(')..write('id: $id')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(id.hashCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is BlockedUser && other.id == this.id);
}

class BlockedUsersCompanion extends UpdateCompanion<BlockedUser> {
  final Value<String> id;
  const BlockedUsersCompanion({
    this.id = const Value.absent(),
  });
  BlockedUsersCompanion.insert({
    required String id,
  }) : id = Value(id);
  static Insertable<BlockedUser> custom({
    Expression<String>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  BlockedUsersCompanion copyWith({Value<String>? id}) {
    return BlockedUsersCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockedUsersCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $BlockedUsersTable extends BlockedUsers
    with TableInfo<$BlockedUsersTable, BlockedUser> {
  final GeneratedDatabase _db;
  final String? _alias;
  $BlockedUsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedTextColumn id = _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  $BlockedUsersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'blocked_users';
  @override
  final String actualTableName = 'blocked_users';
  @override
  VerificationContext validateIntegrity(Insertable<BlockedUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  BlockedUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    return BlockedUser.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $BlockedUsersTable createAlias(String alias) {
    return $BlockedUsersTable(_db, alias);
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $LocalMessagesTable localMessages = $LocalMessagesTable(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $FolloweeUsersTable followeeUsers = $FolloweeUsersTable(this);
  late final $DateUsersTable dateUsers = $DateUsersTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  late final $LocalStorysTable localStorys = $LocalStorysTable(this);
  late final $StoryUsersTable storyUsers = $StoryUsersTable(this);
  late final $BlockedUsersTable blockedUsers = $BlockedUsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        localMessages,
        localUsers,
        followeeUsers,
        dateUsers,
        notifications,
        localStorys,
        storyUsers,
        blockedUsers
      ];
}
