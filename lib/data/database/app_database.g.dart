// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DeviceTypesTable extends DeviceTypes
    with TableInfo<$DeviceTypesTable, DeviceTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceTypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $DeviceTypesTable createAlias(String alias) {
    return $DeviceTypesTable(attachedDatabase, alias);
  }
}

class DeviceTypeRow extends DataClass implements Insertable<DeviceTypeRow> {
  final String id;
  final String name;
  final String? description;
  final bool isActive;
  const DeviceTypeRow({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  DeviceTypesCompanion toCompanion(bool nullToAbsent) {
    return DeviceTypesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
    );
  }

  factory DeviceTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceTypeRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  DeviceTypeRow copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isActive,
  }) => DeviceTypeRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
  );
  DeviceTypeRow copyWithCompanion(DeviceTypesCompanion data) {
    return DeviceTypeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTypeRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceTypeRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive);
}

class DeviceTypesCompanion extends UpdateCompanion<DeviceTypeRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<int> rowid;
  const DeviceTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceTypesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<DeviceTypeRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceTypesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return DeviceTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrandsTable extends Brands with TableInfo<$BrandsTable, BrandRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrandsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brands';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrandRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BrandRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrandRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $BrandsTable createAlias(String alias) {
    return $BrandsTable(attachedDatabase, alias);
  }
}

class BrandRow extends DataClass implements Insertable<BrandRow> {
  final String id;
  final String name;
  final bool isActive;
  const BrandRow({
    required this.id,
    required this.name,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  BrandsCompanion toCompanion(bool nullToAbsent) {
    return BrandsCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
    );
  }

  factory BrandRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrandRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  BrandRow copyWith({String? id, String? name, bool? isActive}) => BrandRow(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
  );
  BrandRow copyWithCompanion(BrandsCompanion data) {
    return BrandRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrandRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrandRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive);
}

class BrandsCompanion extends UpdateCompanion<BrandRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<int> rowid;
  const BrandsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrandsCompanion.insert({
    required String id,
    required String name,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<BrandRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrandsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return BrandsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
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
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrandsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceModelsTable extends DeviceModels
    with TableInfo<$DeviceModelsTable, DeviceModelRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelCodeMeta = const VerificationMeta(
    'modelCode',
  );
  @override
  late final GeneratedColumn<String> modelCode = GeneratedColumn<String>(
    'model_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alternativeSearchTermsMeta =
      const VerificationMeta('alternativeSearchTerms');
  @override
  late final GeneratedColumn<String> alternativeSearchTerms =
      GeneratedColumn<String>(
        'alternative_search_terms',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deviceTypeIdMeta = const VerificationMeta(
    'deviceTypeId',
  );
  @override
  late final GeneratedColumn<String> deviceTypeId = GeneratedColumn<String>(
    'device_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES device_types (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _brandIdMeta = const VerificationMeta(
    'brandId',
  );
  @override
  late final GeneratedColumn<String> brandId = GeneratedColumn<String>(
    'brand_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES brands (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    modelCode,
    alternativeSearchTerms,
    deviceTypeId,
    brandId,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceModelRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('model_code')) {
      context.handle(
        _modelCodeMeta,
        modelCode.isAcceptableOrUnknown(data['model_code']!, _modelCodeMeta),
      );
    }
    if (data.containsKey('alternative_search_terms')) {
      context.handle(
        _alternativeSearchTermsMeta,
        alternativeSearchTerms.isAcceptableOrUnknown(
          data['alternative_search_terms']!,
          _alternativeSearchTermsMeta,
        ),
      );
    }
    if (data.containsKey('device_type_id')) {
      context.handle(
        _deviceTypeIdMeta,
        deviceTypeId.isAcceptableOrUnknown(
          data['device_type_id']!,
          _deviceTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceTypeIdMeta);
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    } else if (isInserting) {
      context.missing(_brandIdMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceModelRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceModelRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      modelCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_code'],
      ),
      alternativeSearchTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternative_search_terms'],
      ),
      deviceTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_type_id'],
      )!,
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand_id'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $DeviceModelsTable createAlias(String alias) {
    return $DeviceModelsTable(attachedDatabase, alias);
  }
}

class DeviceModelRow extends DataClass implements Insertable<DeviceModelRow> {
  final String id;
  final String name;
  final String? modelCode;
  final String? alternativeSearchTerms;
  final String deviceTypeId;
  final String brandId;
  final bool isActive;
  const DeviceModelRow({
    required this.id,
    required this.name,
    this.modelCode,
    this.alternativeSearchTerms,
    required this.deviceTypeId,
    required this.brandId,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || modelCode != null) {
      map['model_code'] = Variable<String>(modelCode);
    }
    if (!nullToAbsent || alternativeSearchTerms != null) {
      map['alternative_search_terms'] = Variable<String>(
        alternativeSearchTerms,
      );
    }
    map['device_type_id'] = Variable<String>(deviceTypeId);
    map['brand_id'] = Variable<String>(brandId);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  DeviceModelsCompanion toCompanion(bool nullToAbsent) {
    return DeviceModelsCompanion(
      id: Value(id),
      name: Value(name),
      modelCode: modelCode == null && nullToAbsent
          ? const Value.absent()
          : Value(modelCode),
      alternativeSearchTerms: alternativeSearchTerms == null && nullToAbsent
          ? const Value.absent()
          : Value(alternativeSearchTerms),
      deviceTypeId: Value(deviceTypeId),
      brandId: Value(brandId),
      isActive: Value(isActive),
    );
  }

  factory DeviceModelRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceModelRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      modelCode: serializer.fromJson<String?>(json['modelCode']),
      alternativeSearchTerms: serializer.fromJson<String?>(
        json['alternativeSearchTerms'],
      ),
      deviceTypeId: serializer.fromJson<String>(json['deviceTypeId']),
      brandId: serializer.fromJson<String>(json['brandId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'modelCode': serializer.toJson<String?>(modelCode),
      'alternativeSearchTerms': serializer.toJson<String?>(
        alternativeSearchTerms,
      ),
      'deviceTypeId': serializer.toJson<String>(deviceTypeId),
      'brandId': serializer.toJson<String>(brandId),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  DeviceModelRow copyWith({
    String? id,
    String? name,
    Value<String?> modelCode = const Value.absent(),
    Value<String?> alternativeSearchTerms = const Value.absent(),
    String? deviceTypeId,
    String? brandId,
    bool? isActive,
  }) => DeviceModelRow(
    id: id ?? this.id,
    name: name ?? this.name,
    modelCode: modelCode.present ? modelCode.value : this.modelCode,
    alternativeSearchTerms: alternativeSearchTerms.present
        ? alternativeSearchTerms.value
        : this.alternativeSearchTerms,
    deviceTypeId: deviceTypeId ?? this.deviceTypeId,
    brandId: brandId ?? this.brandId,
    isActive: isActive ?? this.isActive,
  );
  DeviceModelRow copyWithCompanion(DeviceModelsCompanion data) {
    return DeviceModelRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      modelCode: data.modelCode.present ? data.modelCode.value : this.modelCode,
      alternativeSearchTerms: data.alternativeSearchTerms.present
          ? data.alternativeSearchTerms.value
          : this.alternativeSearchTerms,
      deviceTypeId: data.deviceTypeId.present
          ? data.deviceTypeId.value
          : this.deviceTypeId,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceModelRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('modelCode: $modelCode, ')
          ..write('alternativeSearchTerms: $alternativeSearchTerms, ')
          ..write('deviceTypeId: $deviceTypeId, ')
          ..write('brandId: $brandId, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    modelCode,
    alternativeSearchTerms,
    deviceTypeId,
    brandId,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceModelRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.modelCode == this.modelCode &&
          other.alternativeSearchTerms == this.alternativeSearchTerms &&
          other.deviceTypeId == this.deviceTypeId &&
          other.brandId == this.brandId &&
          other.isActive == this.isActive);
}

class DeviceModelsCompanion extends UpdateCompanion<DeviceModelRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> modelCode;
  final Value<String?> alternativeSearchTerms;
  final Value<String> deviceTypeId;
  final Value<String> brandId;
  final Value<bool> isActive;
  final Value<int> rowid;
  const DeviceModelsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.modelCode = const Value.absent(),
    this.alternativeSearchTerms = const Value.absent(),
    this.deviceTypeId = const Value.absent(),
    this.brandId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceModelsCompanion.insert({
    required String id,
    required String name,
    this.modelCode = const Value.absent(),
    this.alternativeSearchTerms = const Value.absent(),
    required String deviceTypeId,
    required String brandId,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       deviceTypeId = Value(deviceTypeId),
       brandId = Value(brandId);
  static Insertable<DeviceModelRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? modelCode,
    Expression<String>? alternativeSearchTerms,
    Expression<String>? deviceTypeId,
    Expression<String>? brandId,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (modelCode != null) 'model_code': modelCode,
      if (alternativeSearchTerms != null)
        'alternative_search_terms': alternativeSearchTerms,
      if (deviceTypeId != null) 'device_type_id': deviceTypeId,
      if (brandId != null) 'brand_id': brandId,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceModelsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? modelCode,
    Value<String?>? alternativeSearchTerms,
    Value<String>? deviceTypeId,
    Value<String>? brandId,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return DeviceModelsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      modelCode: modelCode ?? this.modelCode,
      alternativeSearchTerms:
          alternativeSearchTerms ?? this.alternativeSearchTerms,
      deviceTypeId: deviceTypeId ?? this.deviceTypeId,
      brandId: brandId ?? this.brandId,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
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
    if (modelCode.present) {
      map['model_code'] = Variable<String>(modelCode.value);
    }
    if (alternativeSearchTerms.present) {
      map['alternative_search_terms'] = Variable<String>(
        alternativeSearchTerms.value,
      );
    }
    if (deviceTypeId.present) {
      map['device_type_id'] = Variable<String>(deviceTypeId.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<String>(brandId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceModelsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('modelCode: $modelCode, ')
          ..write('alternativeSearchTerms: $alternativeSearchTerms, ')
          ..write('deviceTypeId: $deviceTypeId, ')
          ..write('brandId: $brandId, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ComponentsTable extends Components
    with TableInfo<$ComponentsTable, ComponentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComponentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'components';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComponentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComponentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComponentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $ComponentsTable createAlias(String alias) {
    return $ComponentsTable(attachedDatabase, alias);
  }
}

class ComponentRow extends DataClass implements Insertable<ComponentRow> {
  final String id;
  final String name;
  final String? description;
  final bool isActive;
  const ComponentRow({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ComponentsCompanion toCompanion(bool nullToAbsent) {
    return ComponentsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
    );
  }

  factory ComponentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComponentRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ComponentRow copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isActive,
  }) => ComponentRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
  );
  ComponentRow copyWithCompanion(ComponentsCompanion data) {
    return ComponentRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComponentRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComponentRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive);
}

class ComponentsCompanion extends UpdateCompanion<ComponentRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ComponentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ComponentsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<ComponentRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ComponentsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return ComponentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComponentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceTypeComponentsTable extends DeviceTypeComponents
    with TableInfo<$DeviceTypeComponentsTable, DeviceTypeComponentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceTypeComponentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deviceTypeIdMeta = const VerificationMeta(
    'deviceTypeId',
  );
  @override
  late final GeneratedColumn<String> deviceTypeId = GeneratedColumn<String>(
    'device_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES device_types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _componentIdMeta = const VerificationMeta(
    'componentId',
  );
  @override
  late final GeneratedColumn<String> componentId = GeneratedColumn<String>(
    'component_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES components (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [deviceTypeId, componentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_type_components';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceTypeComponentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('device_type_id')) {
      context.handle(
        _deviceTypeIdMeta,
        deviceTypeId.isAcceptableOrUnknown(
          data['device_type_id']!,
          _deviceTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceTypeIdMeta);
    }
    if (data.containsKey('component_id')) {
      context.handle(
        _componentIdMeta,
        componentId.isAcceptableOrUnknown(
          data['component_id']!,
          _componentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceTypeId, componentId};
  @override
  DeviceTypeComponentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceTypeComponentRow(
      deviceTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_type_id'],
      )!,
      componentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_id'],
      )!,
    );
  }

  @override
  $DeviceTypeComponentsTable createAlias(String alias) {
    return $DeviceTypeComponentsTable(attachedDatabase, alias);
  }
}

class DeviceTypeComponentRow extends DataClass
    implements Insertable<DeviceTypeComponentRow> {
  final String deviceTypeId;
  final String componentId;
  const DeviceTypeComponentRow({
    required this.deviceTypeId,
    required this.componentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['device_type_id'] = Variable<String>(deviceTypeId);
    map['component_id'] = Variable<String>(componentId);
    return map;
  }

  DeviceTypeComponentsCompanion toCompanion(bool nullToAbsent) {
    return DeviceTypeComponentsCompanion(
      deviceTypeId: Value(deviceTypeId),
      componentId: Value(componentId),
    );
  }

  factory DeviceTypeComponentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceTypeComponentRow(
      deviceTypeId: serializer.fromJson<String>(json['deviceTypeId']),
      componentId: serializer.fromJson<String>(json['componentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deviceTypeId': serializer.toJson<String>(deviceTypeId),
      'componentId': serializer.toJson<String>(componentId),
    };
  }

  DeviceTypeComponentRow copyWith({
    String? deviceTypeId,
    String? componentId,
  }) => DeviceTypeComponentRow(
    deviceTypeId: deviceTypeId ?? this.deviceTypeId,
    componentId: componentId ?? this.componentId,
  );
  DeviceTypeComponentRow copyWithCompanion(DeviceTypeComponentsCompanion data) {
    return DeviceTypeComponentRow(
      deviceTypeId: data.deviceTypeId.present
          ? data.deviceTypeId.value
          : this.deviceTypeId,
      componentId: data.componentId.present
          ? data.componentId.value
          : this.componentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTypeComponentRow(')
          ..write('deviceTypeId: $deviceTypeId, ')
          ..write('componentId: $componentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(deviceTypeId, componentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceTypeComponentRow &&
          other.deviceTypeId == this.deviceTypeId &&
          other.componentId == this.componentId);
}

class DeviceTypeComponentsCompanion
    extends UpdateCompanion<DeviceTypeComponentRow> {
  final Value<String> deviceTypeId;
  final Value<String> componentId;
  final Value<int> rowid;
  const DeviceTypeComponentsCompanion({
    this.deviceTypeId = const Value.absent(),
    this.componentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceTypeComponentsCompanion.insert({
    required String deviceTypeId,
    required String componentId,
    this.rowid = const Value.absent(),
  }) : deviceTypeId = Value(deviceTypeId),
       componentId = Value(componentId);
  static Insertable<DeviceTypeComponentRow> custom({
    Expression<String>? deviceTypeId,
    Expression<String>? componentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deviceTypeId != null) 'device_type_id': deviceTypeId,
      if (componentId != null) 'component_id': componentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceTypeComponentsCompanion copyWith({
    Value<String>? deviceTypeId,
    Value<String>? componentId,
    Value<int>? rowid,
  }) {
    return DeviceTypeComponentsCompanion(
      deviceTypeId: deviceTypeId ?? this.deviceTypeId,
      componentId: componentId ?? this.componentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deviceTypeId.present) {
      map['device_type_id'] = Variable<String>(deviceTypeId.value);
    }
    if (componentId.present) {
      map['component_id'] = Variable<String>(componentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTypeComponentsCompanion(')
          ..write('deviceTypeId: $deviceTypeId, ')
          ..write('componentId: $componentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, SupplierRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlTemplateMeta = const VerificationMeta(
    'urlTemplate',
  );
  @override
  late final GeneratedColumn<String> urlTemplate = GeneratedColumn<String>(
    'url_template',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    baseUrl,
    urlTemplate,
    displayOrder,
    notes,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    if (data.containsKey('url_template')) {
      context.handle(
        _urlTemplateMeta,
        urlTemplate.isAcceptableOrUnknown(
          data['url_template']!,
          _urlTemplateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_urlTemplateMeta);
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      urlTemplate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url_template'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class SupplierRow extends DataClass implements Insertable<SupplierRow> {
  final String id;
  final String name;
  final String baseUrl;
  final String urlTemplate;
  final int displayOrder;
  final String? notes;
  final bool isActive;
  const SupplierRow({
    required this.id,
    required this.name,
    required this.baseUrl,
    required this.urlTemplate,
    required this.displayOrder,
    this.notes,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['base_url'] = Variable<String>(baseUrl);
    map['url_template'] = Variable<String>(urlTemplate);
    map['display_order'] = Variable<int>(displayOrder);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      baseUrl: Value(baseUrl),
      urlTemplate: Value(urlTemplate),
      displayOrder: Value(displayOrder),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
    );
  }

  factory SupplierRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      urlTemplate: serializer.fromJson<String>(json['urlTemplate']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'urlTemplate': serializer.toJson<String>(urlTemplate),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  SupplierRow copyWith({
    String? id,
    String? name,
    String? baseUrl,
    String? urlTemplate,
    int? displayOrder,
    Value<String?> notes = const Value.absent(),
    bool? isActive,
  }) => SupplierRow(
    id: id ?? this.id,
    name: name ?? this.name,
    baseUrl: baseUrl ?? this.baseUrl,
    urlTemplate: urlTemplate ?? this.urlTemplate,
    displayOrder: displayOrder ?? this.displayOrder,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
  );
  SupplierRow copyWithCompanion(SuppliersCompanion data) {
    return SupplierRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      urlTemplate: data.urlTemplate.present
          ? data.urlTemplate.value
          : this.urlTemplate,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('urlTemplate: $urlTemplate, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    baseUrl,
    urlTemplate,
    displayOrder,
    notes,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.baseUrl == this.baseUrl &&
          other.urlTemplate == this.urlTemplate &&
          other.displayOrder == this.displayOrder &&
          other.notes == this.notes &&
          other.isActive == this.isActive);
}

class SuppliersCompanion extends UpdateCompanion<SupplierRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> baseUrl;
  final Value<String> urlTemplate;
  final Value<int> displayOrder;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.urlTemplate = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    required String id,
    required String name,
    required String baseUrl,
    required String urlTemplate,
    this.displayOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       baseUrl = Value(baseUrl),
       urlTemplate = Value(urlTemplate);
  static Insertable<SupplierRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? baseUrl,
    Expression<String>? urlTemplate,
    Expression<int>? displayOrder,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (baseUrl != null) 'base_url': baseUrl,
      if (urlTemplate != null) 'url_template': urlTemplate,
      if (displayOrder != null) 'display_order': displayOrder,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? baseUrl,
    Value<String>? urlTemplate,
    Value<int>? displayOrder,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      baseUrl: baseUrl ?? this.baseUrl,
      urlTemplate: urlTemplate ?? this.urlTemplate,
      displayOrder: displayOrder ?? this.displayOrder,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
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
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (urlTemplate.present) {
      map['url_template'] = Variable<String>(urlTemplate.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('urlTemplate: $urlTemplate, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplierDeviceTypesTable extends SupplierDeviceTypes
    with TableInfo<$SupplierDeviceTypesTable, SupplierDeviceTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierDeviceTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _deviceTypeIdMeta = const VerificationMeta(
    'deviceTypeId',
  );
  @override
  late final GeneratedColumn<String> deviceTypeId = GeneratedColumn<String>(
    'device_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES device_types (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [supplierId, deviceTypeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_device_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierDeviceTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('device_type_id')) {
      context.handle(
        _deviceTypeIdMeta,
        deviceTypeId.isAcceptableOrUnknown(
          data['device_type_id']!,
          _deviceTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceTypeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {supplierId, deviceTypeId};
  @override
  SupplierDeviceTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierDeviceTypeRow(
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      deviceTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_type_id'],
      )!,
    );
  }

  @override
  $SupplierDeviceTypesTable createAlias(String alias) {
    return $SupplierDeviceTypesTable(attachedDatabase, alias);
  }
}

class SupplierDeviceTypeRow extends DataClass
    implements Insertable<SupplierDeviceTypeRow> {
  final String supplierId;
  final String deviceTypeId;
  const SupplierDeviceTypeRow({
    required this.supplierId,
    required this.deviceTypeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['supplier_id'] = Variable<String>(supplierId);
    map['device_type_id'] = Variable<String>(deviceTypeId);
    return map;
  }

  SupplierDeviceTypesCompanion toCompanion(bool nullToAbsent) {
    return SupplierDeviceTypesCompanion(
      supplierId: Value(supplierId),
      deviceTypeId: Value(deviceTypeId),
    );
  }

  factory SupplierDeviceTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierDeviceTypeRow(
      supplierId: serializer.fromJson<String>(json['supplierId']),
      deviceTypeId: serializer.fromJson<String>(json['deviceTypeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'supplierId': serializer.toJson<String>(supplierId),
      'deviceTypeId': serializer.toJson<String>(deviceTypeId),
    };
  }

  SupplierDeviceTypeRow copyWith({String? supplierId, String? deviceTypeId}) =>
      SupplierDeviceTypeRow(
        supplierId: supplierId ?? this.supplierId,
        deviceTypeId: deviceTypeId ?? this.deviceTypeId,
      );
  SupplierDeviceTypeRow copyWithCompanion(SupplierDeviceTypesCompanion data) {
    return SupplierDeviceTypeRow(
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      deviceTypeId: data.deviceTypeId.present
          ? data.deviceTypeId.value
          : this.deviceTypeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierDeviceTypeRow(')
          ..write('supplierId: $supplierId, ')
          ..write('deviceTypeId: $deviceTypeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(supplierId, deviceTypeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierDeviceTypeRow &&
          other.supplierId == this.supplierId &&
          other.deviceTypeId == this.deviceTypeId);
}

class SupplierDeviceTypesCompanion
    extends UpdateCompanion<SupplierDeviceTypeRow> {
  final Value<String> supplierId;
  final Value<String> deviceTypeId;
  final Value<int> rowid;
  const SupplierDeviceTypesCompanion({
    this.supplierId = const Value.absent(),
    this.deviceTypeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupplierDeviceTypesCompanion.insert({
    required String supplierId,
    required String deviceTypeId,
    this.rowid = const Value.absent(),
  }) : supplierId = Value(supplierId),
       deviceTypeId = Value(deviceTypeId);
  static Insertable<SupplierDeviceTypeRow> custom({
    Expression<String>? supplierId,
    Expression<String>? deviceTypeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (supplierId != null) 'supplier_id': supplierId,
      if (deviceTypeId != null) 'device_type_id': deviceTypeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupplierDeviceTypesCompanion copyWith({
    Value<String>? supplierId,
    Value<String>? deviceTypeId,
    Value<int>? rowid,
  }) {
    return SupplierDeviceTypesCompanion(
      supplierId: supplierId ?? this.supplierId,
      deviceTypeId: deviceTypeId ?? this.deviceTypeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (deviceTypeId.present) {
      map['device_type_id'] = Variable<String>(deviceTypeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierDeviceTypesCompanion(')
          ..write('supplierId: $supplierId, ')
          ..write('deviceTypeId: $deviceTypeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchHistoryEntriesTable extends SearchHistoryEntries
    with TableInfo<$SearchHistoryEntriesTable, SearchHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchedAtMeta = const VerificationMeta(
    'searchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> searchedAt = GeneratedColumn<DateTime>(
    'searched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceTypeMeta = const VerificationMeta(
    'deviceType',
  );
  @override
  late final GeneratedColumn<String> deviceType = GeneratedColumn<String>(
    'device_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceModelMeta = const VerificationMeta(
    'deviceModel',
  );
  @override
  late final GeneratedColumn<String> deviceModel = GeneratedColumn<String>(
    'device_model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceModelCodeMeta = const VerificationMeta(
    'deviceModelCode',
  );
  @override
  late final GeneratedColumn<String> deviceModelCode = GeneratedColumn<String>(
    'device_model_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _componentMeta = const VerificationMeta(
    'component',
  );
  @override
  late final GeneratedColumn<String> component = GeneratedColumn<String>(
    'component',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedQueryMeta = const VerificationMeta(
    'generatedQuery',
  );
  @override
  late final GeneratedColumn<String> generatedQuery = GeneratedColumn<String>(
    'generated_query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    searchedAt,
    deviceType,
    brand,
    deviceModel,
    deviceModelCode,
    component,
    generatedQuery,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('searched_at')) {
      context.handle(
        _searchedAtMeta,
        searchedAt.isAcceptableOrUnknown(data['searched_at']!, _searchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_searchedAtMeta);
    }
    if (data.containsKey('device_type')) {
      context.handle(
        _deviceTypeMeta,
        deviceType.isAcceptableOrUnknown(data['device_type']!, _deviceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceTypeMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('device_model')) {
      context.handle(
        _deviceModelMeta,
        deviceModel.isAcceptableOrUnknown(
          data['device_model']!,
          _deviceModelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceModelMeta);
    }
    if (data.containsKey('device_model_code')) {
      context.handle(
        _deviceModelCodeMeta,
        deviceModelCode.isAcceptableOrUnknown(
          data['device_model_code']!,
          _deviceModelCodeMeta,
        ),
      );
    }
    if (data.containsKey('component')) {
      context.handle(
        _componentMeta,
        component.isAcceptableOrUnknown(data['component']!, _componentMeta),
      );
    } else if (isInserting) {
      context.missing(_componentMeta);
    }
    if (data.containsKey('generated_query')) {
      context.handle(
        _generatedQueryMeta,
        generatedQuery.isAcceptableOrUnknown(
          data['generated_query']!,
          _generatedQueryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedQueryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      searchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}searched_at'],
      )!,
      deviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_type'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      deviceModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_model'],
      )!,
      deviceModelCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_model_code'],
      ),
      component: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component'],
      )!,
      generatedQuery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generated_query'],
      )!,
    );
  }

  @override
  $SearchHistoryEntriesTable createAlias(String alias) {
    return $SearchHistoryEntriesTable(attachedDatabase, alias);
  }
}

class SearchHistoryRow extends DataClass
    implements Insertable<SearchHistoryRow> {
  final String id;
  final DateTime searchedAt;
  final String deviceType;
  final String brand;
  final String deviceModel;
  final String? deviceModelCode;
  final String component;
  final String generatedQuery;
  const SearchHistoryRow({
    required this.id,
    required this.searchedAt,
    required this.deviceType,
    required this.brand,
    required this.deviceModel,
    this.deviceModelCode,
    required this.component,
    required this.generatedQuery,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['searched_at'] = Variable<DateTime>(searchedAt);
    map['device_type'] = Variable<String>(deviceType);
    map['brand'] = Variable<String>(brand);
    map['device_model'] = Variable<String>(deviceModel);
    if (!nullToAbsent || deviceModelCode != null) {
      map['device_model_code'] = Variable<String>(deviceModelCode);
    }
    map['component'] = Variable<String>(component);
    map['generated_query'] = Variable<String>(generatedQuery);
    return map;
  }

  SearchHistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return SearchHistoryEntriesCompanion(
      id: Value(id),
      searchedAt: Value(searchedAt),
      deviceType: Value(deviceType),
      brand: Value(brand),
      deviceModel: Value(deviceModel),
      deviceModelCode: deviceModelCode == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceModelCode),
      component: Value(component),
      generatedQuery: Value(generatedQuery),
    );
  }

  factory SearchHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      searchedAt: serializer.fromJson<DateTime>(json['searchedAt']),
      deviceType: serializer.fromJson<String>(json['deviceType']),
      brand: serializer.fromJson<String>(json['brand']),
      deviceModel: serializer.fromJson<String>(json['deviceModel']),
      deviceModelCode: serializer.fromJson<String?>(json['deviceModelCode']),
      component: serializer.fromJson<String>(json['component']),
      generatedQuery: serializer.fromJson<String>(json['generatedQuery']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'searchedAt': serializer.toJson<DateTime>(searchedAt),
      'deviceType': serializer.toJson<String>(deviceType),
      'brand': serializer.toJson<String>(brand),
      'deviceModel': serializer.toJson<String>(deviceModel),
      'deviceModelCode': serializer.toJson<String?>(deviceModelCode),
      'component': serializer.toJson<String>(component),
      'generatedQuery': serializer.toJson<String>(generatedQuery),
    };
  }

  SearchHistoryRow copyWith({
    String? id,
    DateTime? searchedAt,
    String? deviceType,
    String? brand,
    String? deviceModel,
    Value<String?> deviceModelCode = const Value.absent(),
    String? component,
    String? generatedQuery,
  }) => SearchHistoryRow(
    id: id ?? this.id,
    searchedAt: searchedAt ?? this.searchedAt,
    deviceType: deviceType ?? this.deviceType,
    brand: brand ?? this.brand,
    deviceModel: deviceModel ?? this.deviceModel,
    deviceModelCode: deviceModelCode.present
        ? deviceModelCode.value
        : this.deviceModelCode,
    component: component ?? this.component,
    generatedQuery: generatedQuery ?? this.generatedQuery,
  );
  SearchHistoryRow copyWithCompanion(SearchHistoryEntriesCompanion data) {
    return SearchHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      searchedAt: data.searchedAt.present
          ? data.searchedAt.value
          : this.searchedAt,
      deviceType: data.deviceType.present
          ? data.deviceType.value
          : this.deviceType,
      brand: data.brand.present ? data.brand.value : this.brand,
      deviceModel: data.deviceModel.present
          ? data.deviceModel.value
          : this.deviceModel,
      deviceModelCode: data.deviceModelCode.present
          ? data.deviceModelCode.value
          : this.deviceModelCode,
      component: data.component.present ? data.component.value : this.component,
      generatedQuery: data.generatedQuery.present
          ? data.generatedQuery.value
          : this.generatedQuery,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryRow(')
          ..write('id: $id, ')
          ..write('searchedAt: $searchedAt, ')
          ..write('deviceType: $deviceType, ')
          ..write('brand: $brand, ')
          ..write('deviceModel: $deviceModel, ')
          ..write('deviceModelCode: $deviceModelCode, ')
          ..write('component: $component, ')
          ..write('generatedQuery: $generatedQuery')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    searchedAt,
    deviceType,
    brand,
    deviceModel,
    deviceModelCode,
    component,
    generatedQuery,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistoryRow &&
          other.id == this.id &&
          other.searchedAt == this.searchedAt &&
          other.deviceType == this.deviceType &&
          other.brand == this.brand &&
          other.deviceModel == this.deviceModel &&
          other.deviceModelCode == this.deviceModelCode &&
          other.component == this.component &&
          other.generatedQuery == this.generatedQuery);
}

class SearchHistoryEntriesCompanion extends UpdateCompanion<SearchHistoryRow> {
  final Value<String> id;
  final Value<DateTime> searchedAt;
  final Value<String> deviceType;
  final Value<String> brand;
  final Value<String> deviceModel;
  final Value<String?> deviceModelCode;
  final Value<String> component;
  final Value<String> generatedQuery;
  final Value<int> rowid;
  const SearchHistoryEntriesCompanion({
    this.id = const Value.absent(),
    this.searchedAt = const Value.absent(),
    this.deviceType = const Value.absent(),
    this.brand = const Value.absent(),
    this.deviceModel = const Value.absent(),
    this.deviceModelCode = const Value.absent(),
    this.component = const Value.absent(),
    this.generatedQuery = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchHistoryEntriesCompanion.insert({
    required String id,
    required DateTime searchedAt,
    required String deviceType,
    required String brand,
    required String deviceModel,
    this.deviceModelCode = const Value.absent(),
    required String component,
    required String generatedQuery,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       searchedAt = Value(searchedAt),
       deviceType = Value(deviceType),
       brand = Value(brand),
       deviceModel = Value(deviceModel),
       component = Value(component),
       generatedQuery = Value(generatedQuery);
  static Insertable<SearchHistoryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? searchedAt,
    Expression<String>? deviceType,
    Expression<String>? brand,
    Expression<String>? deviceModel,
    Expression<String>? deviceModelCode,
    Expression<String>? component,
    Expression<String>? generatedQuery,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (searchedAt != null) 'searched_at': searchedAt,
      if (deviceType != null) 'device_type': deviceType,
      if (brand != null) 'brand': brand,
      if (deviceModel != null) 'device_model': deviceModel,
      if (deviceModelCode != null) 'device_model_code': deviceModelCode,
      if (component != null) 'component': component,
      if (generatedQuery != null) 'generated_query': generatedQuery,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchHistoryEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? searchedAt,
    Value<String>? deviceType,
    Value<String>? brand,
    Value<String>? deviceModel,
    Value<String?>? deviceModelCode,
    Value<String>? component,
    Value<String>? generatedQuery,
    Value<int>? rowid,
  }) {
    return SearchHistoryEntriesCompanion(
      id: id ?? this.id,
      searchedAt: searchedAt ?? this.searchedAt,
      deviceType: deviceType ?? this.deviceType,
      brand: brand ?? this.brand,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceModelCode: deviceModelCode ?? this.deviceModelCode,
      component: component ?? this.component,
      generatedQuery: generatedQuery ?? this.generatedQuery,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (searchedAt.present) {
      map['searched_at'] = Variable<DateTime>(searchedAt.value);
    }
    if (deviceType.present) {
      map['device_type'] = Variable<String>(deviceType.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (deviceModel.present) {
      map['device_model'] = Variable<String>(deviceModel.value);
    }
    if (deviceModelCode.present) {
      map['device_model_code'] = Variable<String>(deviceModelCode.value);
    }
    if (component.present) {
      map['component'] = Variable<String>(component.value);
    }
    if (generatedQuery.present) {
      map['generated_query'] = Variable<String>(generatedQuery.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('searchedAt: $searchedAt, ')
          ..write('deviceType: $deviceType, ')
          ..write('brand: $brand, ')
          ..write('deviceModel: $deviceModel, ')
          ..write('deviceModelCode: $deviceModelCode, ')
          ..write('component: $component, ')
          ..write('generatedQuery: $generatedQuery, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchHistorySuppliersTable extends SearchHistorySuppliers
    with TableInfo<$SearchHistorySuppliersTable, SearchHistorySupplierRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchHistorySuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchHistoryIdMeta = const VerificationMeta(
    'searchHistoryId',
  );
  @override
  late final GeneratedColumn<String> searchHistoryId = GeneratedColumn<String>(
    'search_history_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES search_history (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedUrlMeta = const VerificationMeta(
    'generatedUrl',
  );
  @override
  late final GeneratedColumn<String> generatedUrl = GeneratedColumn<String>(
    'generated_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openResultMeta = const VerificationMeta(
    'openResult',
  );
  @override
  late final GeneratedColumn<String> openResult = GeneratedColumn<String>(
    'open_result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    searchHistoryId,
    supplierId,
    supplierName,
    generatedUrl,
    openResult,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_history_suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchHistorySupplierRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('search_history_id')) {
      context.handle(
        _searchHistoryIdMeta,
        searchHistoryId.isAcceptableOrUnknown(
          data['search_history_id']!,
          _searchHistoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_searchHistoryIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_supplierNameMeta);
    }
    if (data.containsKey('generated_url')) {
      context.handle(
        _generatedUrlMeta,
        generatedUrl.isAcceptableOrUnknown(
          data['generated_url']!,
          _generatedUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedUrlMeta);
    }
    if (data.containsKey('open_result')) {
      context.handle(
        _openResultMeta,
        openResult.isAcceptableOrUnknown(data['open_result']!, _openResultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchHistorySupplierRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchHistorySupplierRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      searchHistoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_history_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      ),
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      )!,
      generatedUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generated_url'],
      )!,
      openResult: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}open_result'],
      ),
    );
  }

  @override
  $SearchHistorySuppliersTable createAlias(String alias) {
    return $SearchHistorySuppliersTable(attachedDatabase, alias);
  }
}

class SearchHistorySupplierRow extends DataClass
    implements Insertable<SearchHistorySupplierRow> {
  final String id;
  final String searchHistoryId;
  final String? supplierId;
  final String supplierName;
  final String generatedUrl;
  final String? openResult;
  const SearchHistorySupplierRow({
    required this.id,
    required this.searchHistoryId,
    this.supplierId,
    required this.supplierName,
    required this.generatedUrl,
    this.openResult,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['search_history_id'] = Variable<String>(searchHistoryId);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    map['supplier_name'] = Variable<String>(supplierName);
    map['generated_url'] = Variable<String>(generatedUrl);
    if (!nullToAbsent || openResult != null) {
      map['open_result'] = Variable<String>(openResult);
    }
    return map;
  }

  SearchHistorySuppliersCompanion toCompanion(bool nullToAbsent) {
    return SearchHistorySuppliersCompanion(
      id: Value(id),
      searchHistoryId: Value(searchHistoryId),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      supplierName: Value(supplierName),
      generatedUrl: Value(generatedUrl),
      openResult: openResult == null && nullToAbsent
          ? const Value.absent()
          : Value(openResult),
    );
  }

  factory SearchHistorySupplierRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchHistorySupplierRow(
      id: serializer.fromJson<String>(json['id']),
      searchHistoryId: serializer.fromJson<String>(json['searchHistoryId']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      supplierName: serializer.fromJson<String>(json['supplierName']),
      generatedUrl: serializer.fromJson<String>(json['generatedUrl']),
      openResult: serializer.fromJson<String?>(json['openResult']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'searchHistoryId': serializer.toJson<String>(searchHistoryId),
      'supplierId': serializer.toJson<String?>(supplierId),
      'supplierName': serializer.toJson<String>(supplierName),
      'generatedUrl': serializer.toJson<String>(generatedUrl),
      'openResult': serializer.toJson<String?>(openResult),
    };
  }

  SearchHistorySupplierRow copyWith({
    String? id,
    String? searchHistoryId,
    Value<String?> supplierId = const Value.absent(),
    String? supplierName,
    String? generatedUrl,
    Value<String?> openResult = const Value.absent(),
  }) => SearchHistorySupplierRow(
    id: id ?? this.id,
    searchHistoryId: searchHistoryId ?? this.searchHistoryId,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    supplierName: supplierName ?? this.supplierName,
    generatedUrl: generatedUrl ?? this.generatedUrl,
    openResult: openResult.present ? openResult.value : this.openResult,
  );
  SearchHistorySupplierRow copyWithCompanion(
    SearchHistorySuppliersCompanion data,
  ) {
    return SearchHistorySupplierRow(
      id: data.id.present ? data.id.value : this.id,
      searchHistoryId: data.searchHistoryId.present
          ? data.searchHistoryId.value
          : this.searchHistoryId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      generatedUrl: data.generatedUrl.present
          ? data.generatedUrl.value
          : this.generatedUrl,
      openResult: data.openResult.present
          ? data.openResult.value
          : this.openResult,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistorySupplierRow(')
          ..write('id: $id, ')
          ..write('searchHistoryId: $searchHistoryId, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierName: $supplierName, ')
          ..write('generatedUrl: $generatedUrl, ')
          ..write('openResult: $openResult')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    searchHistoryId,
    supplierId,
    supplierName,
    generatedUrl,
    openResult,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistorySupplierRow &&
          other.id == this.id &&
          other.searchHistoryId == this.searchHistoryId &&
          other.supplierId == this.supplierId &&
          other.supplierName == this.supplierName &&
          other.generatedUrl == this.generatedUrl &&
          other.openResult == this.openResult);
}

class SearchHistorySuppliersCompanion
    extends UpdateCompanion<SearchHistorySupplierRow> {
  final Value<String> id;
  final Value<String> searchHistoryId;
  final Value<String?> supplierId;
  final Value<String> supplierName;
  final Value<String> generatedUrl;
  final Value<String?> openResult;
  final Value<int> rowid;
  const SearchHistorySuppliersCompanion({
    this.id = const Value.absent(),
    this.searchHistoryId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.generatedUrl = const Value.absent(),
    this.openResult = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SearchHistorySuppliersCompanion.insert({
    required String id,
    required String searchHistoryId,
    this.supplierId = const Value.absent(),
    required String supplierName,
    required String generatedUrl,
    this.openResult = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       searchHistoryId = Value(searchHistoryId),
       supplierName = Value(supplierName),
       generatedUrl = Value(generatedUrl);
  static Insertable<SearchHistorySupplierRow> custom({
    Expression<String>? id,
    Expression<String>? searchHistoryId,
    Expression<String>? supplierId,
    Expression<String>? supplierName,
    Expression<String>? generatedUrl,
    Expression<String>? openResult,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (searchHistoryId != null) 'search_history_id': searchHistoryId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (supplierName != null) 'supplier_name': supplierName,
      if (generatedUrl != null) 'generated_url': generatedUrl,
      if (openResult != null) 'open_result': openResult,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SearchHistorySuppliersCompanion copyWith({
    Value<String>? id,
    Value<String>? searchHistoryId,
    Value<String?>? supplierId,
    Value<String>? supplierName,
    Value<String>? generatedUrl,
    Value<String?>? openResult,
    Value<int>? rowid,
  }) {
    return SearchHistorySuppliersCompanion(
      id: id ?? this.id,
      searchHistoryId: searchHistoryId ?? this.searchHistoryId,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      generatedUrl: generatedUrl ?? this.generatedUrl,
      openResult: openResult ?? this.openResult,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (searchHistoryId.present) {
      map['search_history_id'] = Variable<String>(searchHistoryId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (generatedUrl.present) {
      map['generated_url'] = Variable<String>(generatedUrl.value);
    }
    if (openResult.present) {
      map['open_result'] = Variable<String>(openResult.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchHistorySuppliersCompanion(')
          ..write('id: $id, ')
          ..write('searchHistoryId: $searchHistoryId, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierName: $supplierName, ')
          ..write('generatedUrl: $generatedUrl, ')
          ..write('openResult: $openResult, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, FavoriteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceTypeIdMeta = const VerificationMeta(
    'deviceTypeId',
  );
  @override
  late final GeneratedColumn<String> deviceTypeId = GeneratedColumn<String>(
    'device_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES device_types (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _brandIdMeta = const VerificationMeta(
    'brandId',
  );
  @override
  late final GeneratedColumn<String> brandId = GeneratedColumn<String>(
    'brand_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES brands (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _deviceModelIdMeta = const VerificationMeta(
    'deviceModelId',
  );
  @override
  late final GeneratedColumn<String> deviceModelId = GeneratedColumn<String>(
    'device_model_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES device_models (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _componentIdMeta = const VerificationMeta(
    'componentId',
  );
  @override
  late final GeneratedColumn<String> componentId = GeneratedColumn<String>(
    'component_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES components (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    deviceTypeId,
    brandId,
    deviceModelId,
    componentId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('device_type_id')) {
      context.handle(
        _deviceTypeIdMeta,
        deviceTypeId.isAcceptableOrUnknown(
          data['device_type_id']!,
          _deviceTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceTypeIdMeta);
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    } else if (isInserting) {
      context.missing(_brandIdMeta);
    }
    if (data.containsKey('device_model_id')) {
      context.handle(
        _deviceModelIdMeta,
        deviceModelId.isAcceptableOrUnknown(
          data['device_model_id']!,
          _deviceModelIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceModelIdMeta);
    }
    if (data.containsKey('component_id')) {
      context.handle(
        _componentIdMeta,
        componentId.isAcceptableOrUnknown(
          data['component_id']!,
          _componentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      deviceTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_type_id'],
      )!,
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand_id'],
      )!,
      deviceModelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_model_id'],
      )!,
      componentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class FavoriteRow extends DataClass implements Insertable<FavoriteRow> {
  final String id;
  final String name;
  final String deviceTypeId;
  final String brandId;
  final String deviceModelId;
  final String componentId;
  final DateTime createdAt;
  const FavoriteRow({
    required this.id,
    required this.name,
    required this.deviceTypeId,
    required this.brandId,
    required this.deviceModelId,
    required this.componentId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['device_type_id'] = Variable<String>(deviceTypeId);
    map['brand_id'] = Variable<String>(brandId);
    map['device_model_id'] = Variable<String>(deviceModelId);
    map['component_id'] = Variable<String>(componentId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: Value(id),
      name: Value(name),
      deviceTypeId: Value(deviceTypeId),
      brandId: Value(brandId),
      deviceModelId: Value(deviceModelId),
      componentId: Value(componentId),
      createdAt: Value(createdAt),
    );
  }

  factory FavoriteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      deviceTypeId: serializer.fromJson<String>(json['deviceTypeId']),
      brandId: serializer.fromJson<String>(json['brandId']),
      deviceModelId: serializer.fromJson<String>(json['deviceModelId']),
      componentId: serializer.fromJson<String>(json['componentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'deviceTypeId': serializer.toJson<String>(deviceTypeId),
      'brandId': serializer.toJson<String>(brandId),
      'deviceModelId': serializer.toJson<String>(deviceModelId),
      'componentId': serializer.toJson<String>(componentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoriteRow copyWith({
    String? id,
    String? name,
    String? deviceTypeId,
    String? brandId,
    String? deviceModelId,
    String? componentId,
    DateTime? createdAt,
  }) => FavoriteRow(
    id: id ?? this.id,
    name: name ?? this.name,
    deviceTypeId: deviceTypeId ?? this.deviceTypeId,
    brandId: brandId ?? this.brandId,
    deviceModelId: deviceModelId ?? this.deviceModelId,
    componentId: componentId ?? this.componentId,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoriteRow copyWithCompanion(FavoritesCompanion data) {
    return FavoriteRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      deviceTypeId: data.deviceTypeId.present
          ? data.deviceTypeId.value
          : this.deviceTypeId,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      deviceModelId: data.deviceModelId.present
          ? data.deviceModelId.value
          : this.deviceModelId,
      componentId: data.componentId.present
          ? data.componentId.value
          : this.componentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('deviceTypeId: $deviceTypeId, ')
          ..write('brandId: $brandId, ')
          ..write('deviceModelId: $deviceModelId, ')
          ..write('componentId: $componentId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    deviceTypeId,
    brandId,
    deviceModelId,
    componentId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.deviceTypeId == this.deviceTypeId &&
          other.brandId == this.brandId &&
          other.deviceModelId == this.deviceModelId &&
          other.componentId == this.componentId &&
          other.createdAt == this.createdAt);
}

class FavoritesCompanion extends UpdateCompanion<FavoriteRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> deviceTypeId;
  final Value<String> brandId;
  final Value<String> deviceModelId;
  final Value<String> componentId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.deviceTypeId = const Value.absent(),
    this.brandId = const Value.absent(),
    this.deviceModelId = const Value.absent(),
    this.componentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritesCompanion.insert({
    required String id,
    required String name,
    required String deviceTypeId,
    required String brandId,
    required String deviceModelId,
    required String componentId,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       deviceTypeId = Value(deviceTypeId),
       brandId = Value(brandId),
       deviceModelId = Value(deviceModelId),
       componentId = Value(componentId),
       createdAt = Value(createdAt);
  static Insertable<FavoriteRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? deviceTypeId,
    Expression<String>? brandId,
    Expression<String>? deviceModelId,
    Expression<String>? componentId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (deviceTypeId != null) 'device_type_id': deviceTypeId,
      if (brandId != null) 'brand_id': brandId,
      if (deviceModelId != null) 'device_model_id': deviceModelId,
      if (componentId != null) 'component_id': componentId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? deviceTypeId,
    Value<String>? brandId,
    Value<String>? deviceModelId,
    Value<String>? componentId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FavoritesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      deviceTypeId: deviceTypeId ?? this.deviceTypeId,
      brandId: brandId ?? this.brandId,
      deviceModelId: deviceModelId ?? this.deviceModelId,
      componentId: componentId ?? this.componentId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
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
    if (deviceTypeId.present) {
      map['device_type_id'] = Variable<String>(deviceTypeId.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<String>(brandId.value);
    }
    if (deviceModelId.present) {
      map['device_model_id'] = Variable<String>(deviceModelId.value);
    }
    if (componentId.present) {
      map['component_id'] = Variable<String>(componentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('deviceTypeId: $deviceTypeId, ')
          ..write('brandId: $brandId, ')
          ..write('deviceModelId: $deviceModelId, ')
          ..write('componentId: $componentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoriteSuppliersTable extends FavoriteSuppliers
    with TableInfo<$FavoriteSuppliersTable, FavoriteSupplierRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteSuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _favoriteIdMeta = const VerificationMeta(
    'favoriteId',
  );
  @override
  late final GeneratedColumn<String> favoriteId = GeneratedColumn<String>(
    'favorite_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES favorites (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [favoriteId, supplierId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteSupplierRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('favorite_id')) {
      context.handle(
        _favoriteIdMeta,
        favoriteId.isAcceptableOrUnknown(data['favorite_id']!, _favoriteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_favoriteIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {favoriteId, supplierId};
  @override
  FavoriteSupplierRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteSupplierRow(
      favoriteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}favorite_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
    );
  }

  @override
  $FavoriteSuppliersTable createAlias(String alias) {
    return $FavoriteSuppliersTable(attachedDatabase, alias);
  }
}

class FavoriteSupplierRow extends DataClass
    implements Insertable<FavoriteSupplierRow> {
  final String favoriteId;
  final String supplierId;
  const FavoriteSupplierRow({
    required this.favoriteId,
    required this.supplierId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['favorite_id'] = Variable<String>(favoriteId);
    map['supplier_id'] = Variable<String>(supplierId);
    return map;
  }

  FavoriteSuppliersCompanion toCompanion(bool nullToAbsent) {
    return FavoriteSuppliersCompanion(
      favoriteId: Value(favoriteId),
      supplierId: Value(supplierId),
    );
  }

  factory FavoriteSupplierRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteSupplierRow(
      favoriteId: serializer.fromJson<String>(json['favoriteId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'favoriteId': serializer.toJson<String>(favoriteId),
      'supplierId': serializer.toJson<String>(supplierId),
    };
  }

  FavoriteSupplierRow copyWith({String? favoriteId, String? supplierId}) =>
      FavoriteSupplierRow(
        favoriteId: favoriteId ?? this.favoriteId,
        supplierId: supplierId ?? this.supplierId,
      );
  FavoriteSupplierRow copyWithCompanion(FavoriteSuppliersCompanion data) {
    return FavoriteSupplierRow(
      favoriteId: data.favoriteId.present
          ? data.favoriteId.value
          : this.favoriteId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteSupplierRow(')
          ..write('favoriteId: $favoriteId, ')
          ..write('supplierId: $supplierId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(favoriteId, supplierId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteSupplierRow &&
          other.favoriteId == this.favoriteId &&
          other.supplierId == this.supplierId);
}

class FavoriteSuppliersCompanion extends UpdateCompanion<FavoriteSupplierRow> {
  final Value<String> favoriteId;
  final Value<String> supplierId;
  final Value<int> rowid;
  const FavoriteSuppliersCompanion({
    this.favoriteId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteSuppliersCompanion.insert({
    required String favoriteId,
    required String supplierId,
    this.rowid = const Value.absent(),
  }) : favoriteId = Value(favoriteId),
       supplierId = Value(supplierId);
  static Insertable<FavoriteSupplierRow> custom({
    Expression<String>? favoriteId,
    Expression<String>? supplierId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (favoriteId != null) 'favorite_id': favoriteId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteSuppliersCompanion copyWith({
    Value<String>? favoriteId,
    Value<String>? supplierId,
    Value<int>? rowid,
  }) {
    return FavoriteSuppliersCompanion(
      favoriteId: favoriteId ?? this.favoriteId,
      supplierId: supplierId ?? this.supplierId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (favoriteId.present) {
      map['favorite_id'] = Variable<String>(favoriteId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteSuppliersCompanion(')
          ..write('favoriteId: $favoriteId, ')
          ..write('supplierId: $supplierId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxPagesToOpenMeta = const VerificationMeta(
    'maxPagesToOpen',
  );
  @override
  late final GeneratedColumn<int> maxPagesToOpen = GeneratedColumn<int>(
    'max_pages_to_open',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _requireConfirmationMeta =
      const VerificationMeta('requireConfirmation');
  @override
  late final GeneratedColumn<bool> requireConfirmation = GeneratedColumn<bool>(
    'require_confirmation',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("require_confirmation" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _historyEnabledMeta = const VerificationMeta(
    'historyEnabled',
  );
  @override
  late final GeneratedColumn<bool> historyEnabled = GeneratedColumn<bool>(
    'history_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("history_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _demoSeedVersionMeta = const VerificationMeta(
    'demoSeedVersion',
  );
  @override
  late final GeneratedColumn<int> demoSeedVersion = GeneratedColumn<int>(
    'demo_seed_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    maxPagesToOpen,
    requireConfirmation,
    historyEnabled,
    demoSeedVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('max_pages_to_open')) {
      context.handle(
        _maxPagesToOpenMeta,
        maxPagesToOpen.isAcceptableOrUnknown(
          data['max_pages_to_open']!,
          _maxPagesToOpenMeta,
        ),
      );
    }
    if (data.containsKey('require_confirmation')) {
      context.handle(
        _requireConfirmationMeta,
        requireConfirmation.isAcceptableOrUnknown(
          data['require_confirmation']!,
          _requireConfirmationMeta,
        ),
      );
    }
    if (data.containsKey('history_enabled')) {
      context.handle(
        _historyEnabledMeta,
        historyEnabled.isAcceptableOrUnknown(
          data['history_enabled']!,
          _historyEnabledMeta,
        ),
      );
    }
    if (data.containsKey('demo_seed_version')) {
      context.handle(
        _demoSeedVersionMeta,
        demoSeedVersion.isAcceptableOrUnknown(
          data['demo_seed_version']!,
          _demoSeedVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      maxPagesToOpen: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_pages_to_open'],
      )!,
      requireConfirmation: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}require_confirmation'],
      )!,
      historyEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}history_enabled'],
      )!,
      demoSeedVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}demo_seed_version'],
      )!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsRow extends DataClass implements Insertable<AppSettingsRow> {
  final String id;
  final int maxPagesToOpen;
  final bool requireConfirmation;
  final bool historyEnabled;
  final int demoSeedVersion;
  const AppSettingsRow({
    required this.id,
    required this.maxPagesToOpen,
    required this.requireConfirmation,
    required this.historyEnabled,
    required this.demoSeedVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['max_pages_to_open'] = Variable<int>(maxPagesToOpen);
    map['require_confirmation'] = Variable<bool>(requireConfirmation);
    map['history_enabled'] = Variable<bool>(historyEnabled);
    map['demo_seed_version'] = Variable<int>(demoSeedVersion);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      maxPagesToOpen: Value(maxPagesToOpen),
      requireConfirmation: Value(requireConfirmation),
      historyEnabled: Value(historyEnabled),
      demoSeedVersion: Value(demoSeedVersion),
    );
  }

  factory AppSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsRow(
      id: serializer.fromJson<String>(json['id']),
      maxPagesToOpen: serializer.fromJson<int>(json['maxPagesToOpen']),
      requireConfirmation: serializer.fromJson<bool>(
        json['requireConfirmation'],
      ),
      historyEnabled: serializer.fromJson<bool>(json['historyEnabled']),
      demoSeedVersion: serializer.fromJson<int>(json['demoSeedVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'maxPagesToOpen': serializer.toJson<int>(maxPagesToOpen),
      'requireConfirmation': serializer.toJson<bool>(requireConfirmation),
      'historyEnabled': serializer.toJson<bool>(historyEnabled),
      'demoSeedVersion': serializer.toJson<int>(demoSeedVersion),
    };
  }

  AppSettingsRow copyWith({
    String? id,
    int? maxPagesToOpen,
    bool? requireConfirmation,
    bool? historyEnabled,
    int? demoSeedVersion,
  }) => AppSettingsRow(
    id: id ?? this.id,
    maxPagesToOpen: maxPagesToOpen ?? this.maxPagesToOpen,
    requireConfirmation: requireConfirmation ?? this.requireConfirmation,
    historyEnabled: historyEnabled ?? this.historyEnabled,
    demoSeedVersion: demoSeedVersion ?? this.demoSeedVersion,
  );
  AppSettingsRow copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      maxPagesToOpen: data.maxPagesToOpen.present
          ? data.maxPagesToOpen.value
          : this.maxPagesToOpen,
      requireConfirmation: data.requireConfirmation.present
          ? data.requireConfirmation.value
          : this.requireConfirmation,
      historyEnabled: data.historyEnabled.present
          ? data.historyEnabled.value
          : this.historyEnabled,
      demoSeedVersion: data.demoSeedVersion.present
          ? data.demoSeedVersion.value
          : this.demoSeedVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsRow(')
          ..write('id: $id, ')
          ..write('maxPagesToOpen: $maxPagesToOpen, ')
          ..write('requireConfirmation: $requireConfirmation, ')
          ..write('historyEnabled: $historyEnabled, ')
          ..write('demoSeedVersion: $demoSeedVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    maxPagesToOpen,
    requireConfirmation,
    historyEnabled,
    demoSeedVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsRow &&
          other.id == this.id &&
          other.maxPagesToOpen == this.maxPagesToOpen &&
          other.requireConfirmation == this.requireConfirmation &&
          other.historyEnabled == this.historyEnabled &&
          other.demoSeedVersion == this.demoSeedVersion);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsRow> {
  final Value<String> id;
  final Value<int> maxPagesToOpen;
  final Value<bool> requireConfirmation;
  final Value<bool> historyEnabled;
  final Value<int> demoSeedVersion;
  final Value<int> rowid;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.maxPagesToOpen = const Value.absent(),
    this.requireConfirmation = const Value.absent(),
    this.historyEnabled = const Value.absent(),
    this.demoSeedVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    required String id,
    this.maxPagesToOpen = const Value.absent(),
    this.requireConfirmation = const Value.absent(),
    this.historyEnabled = const Value.absent(),
    this.demoSeedVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<AppSettingsRow> custom({
    Expression<String>? id,
    Expression<int>? maxPagesToOpen,
    Expression<bool>? requireConfirmation,
    Expression<bool>? historyEnabled,
    Expression<int>? demoSeedVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (maxPagesToOpen != null) 'max_pages_to_open': maxPagesToOpen,
      if (requireConfirmation != null)
        'require_confirmation': requireConfirmation,
      if (historyEnabled != null) 'history_enabled': historyEnabled,
      if (demoSeedVersion != null) 'demo_seed_version': demoSeedVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<int>? maxPagesToOpen,
    Value<bool>? requireConfirmation,
    Value<bool>? historyEnabled,
    Value<int>? demoSeedVersion,
    Value<int>? rowid,
  }) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      maxPagesToOpen: maxPagesToOpen ?? this.maxPagesToOpen,
      requireConfirmation: requireConfirmation ?? this.requireConfirmation,
      historyEnabled: historyEnabled ?? this.historyEnabled,
      demoSeedVersion: demoSeedVersion ?? this.demoSeedVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (maxPagesToOpen.present) {
      map['max_pages_to_open'] = Variable<int>(maxPagesToOpen.value);
    }
    if (requireConfirmation.present) {
      map['require_confirmation'] = Variable<bool>(requireConfirmation.value);
    }
    if (historyEnabled.present) {
      map['history_enabled'] = Variable<bool>(historyEnabled.value);
    }
    if (demoSeedVersion.present) {
      map['demo_seed_version'] = Variable<int>(demoSeedVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('maxPagesToOpen: $maxPagesToOpen, ')
          ..write('requireConfirmation: $requireConfirmation, ')
          ..write('historyEnabled: $historyEnabled, ')
          ..write('demoSeedVersion: $demoSeedVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DeviceTypesTable deviceTypes = $DeviceTypesTable(this);
  late final $BrandsTable brands = $BrandsTable(this);
  late final $DeviceModelsTable deviceModels = $DeviceModelsTable(this);
  late final $ComponentsTable components = $ComponentsTable(this);
  late final $DeviceTypeComponentsTable deviceTypeComponents =
      $DeviceTypeComponentsTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $SupplierDeviceTypesTable supplierDeviceTypes =
      $SupplierDeviceTypesTable(this);
  late final $SearchHistoryEntriesTable searchHistoryEntries =
      $SearchHistoryEntriesTable(this);
  late final $SearchHistorySuppliersTable searchHistorySuppliers =
      $SearchHistorySuppliersTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $FavoriteSuppliersTable favoriteSuppliers =
      $FavoriteSuppliersTable(this);
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  late final Index idxDeviceModelsBrandName = Index(
    'idx_device_models_brand_name',
    'CREATE UNIQUE INDEX idx_device_models_brand_name ON device_models (brand_id, name)',
  );
  late final CatalogDao catalogDao = CatalogDao(this as AppDatabase);
  late final SupplierDao supplierDao = SupplierDao(this as AppDatabase);
  late final SearchHistoryDao searchHistoryDao = SearchHistoryDao(
    this as AppDatabase,
  );
  late final FavoriteDao favoriteDao = FavoriteDao(this as AppDatabase);
  late final AppSettingsDao appSettingsDao = AppSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    deviceTypes,
    brands,
    deviceModels,
    components,
    deviceTypeComponents,
    suppliers,
    supplierDeviceTypes,
    searchHistoryEntries,
    searchHistorySuppliers,
    favorites,
    favoriteSuppliers,
    appSettingsTable,
    idxDeviceModelsBrandName,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'device_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_type_components', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'components',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('device_type_components', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'suppliers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('supplier_device_types', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'device_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('supplier_device_types', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'search_history',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('search_history_suppliers', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'suppliers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('search_history_suppliers', kind: UpdateKind.update),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'favorites',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('favorite_suppliers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'suppliers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('favorite_suppliers', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DeviceTypesTableCreateCompanionBuilder =
    DeviceTypesCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$DeviceTypesTableUpdateCompanionBuilder =
    DeviceTypesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$DeviceTypesTableReferences
    extends BaseReferences<_$AppDatabase, $DeviceTypesTable, DeviceTypeRow> {
  $$DeviceTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DeviceModelsTable, List<DeviceModelRow>>
  _deviceModelsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deviceModels,
    aliasName: 'device_types__id__device_models__device_type_id',
  );

  $$DeviceModelsTableProcessedTableManager get deviceModelsRefs {
    final manager = $$DeviceModelsTableTableManager(
      $_db,
      $_db.deviceModels,
    ).filter((f) => f.deviceTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_deviceModelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $DeviceTypeComponentsTable,
    List<DeviceTypeComponentRow>
  >
  _deviceTypeComponentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.deviceTypeComponents,
        aliasName: 'device_types__id__device_type_components__device_type_id',
      );

  $$DeviceTypeComponentsTableProcessedTableManager
  get deviceTypeComponentsRefs {
    final manager = $$DeviceTypeComponentsTableTableManager(
      $_db,
      $_db.deviceTypeComponents,
    ).filter((f) => f.deviceTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deviceTypeComponentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SupplierDeviceTypesTable,
    List<SupplierDeviceTypeRow>
  >
  _supplierDeviceTypesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.supplierDeviceTypes,
        aliasName: 'device_types__id__supplier_device_types__device_type_id',
      );

  $$SupplierDeviceTypesTableProcessedTableManager get supplierDeviceTypesRefs {
    final manager = $$SupplierDeviceTypesTableTableManager(
      $_db,
      $_db.supplierDeviceTypes,
    ).filter((f) => f.deviceTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _supplierDeviceTypesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritesTable, List<FavoriteRow>>
  _favoritesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favorites,
    aliasName: 'device_types__id__favorites__device_type_id',
  );

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.deviceTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DeviceTypesTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceTypesTable> {
  $$DeviceTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> deviceModelsRefs(
    Expression<bool> Function($$DeviceModelsTableFilterComposer f) f,
  ) {
    final $$DeviceModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceModels,
      getReferencedColumn: (t) => t.deviceTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceModelsTableFilterComposer(
            $db: $db,
            $table: $db.deviceModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> deviceTypeComponentsRefs(
    Expression<bool> Function($$DeviceTypeComponentsTableFilterComposer f) f,
  ) {
    final $$DeviceTypeComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceTypeComponents,
      getReferencedColumn: (t) => t.deviceTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypeComponentsTableFilterComposer(
            $db: $db,
            $table: $db.deviceTypeComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> supplierDeviceTypesRefs(
    Expression<bool> Function($$SupplierDeviceTypesTableFilterComposer f) f,
  ) {
    final $$SupplierDeviceTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierDeviceTypes,
      getReferencedColumn: (t) => t.deviceTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SupplierDeviceTypesTableFilterComposer(
            $db: $db,
            $table: $db.supplierDeviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritesRefs(
    Expression<bool> Function($$FavoritesTableFilterComposer f) f,
  ) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.deviceTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DeviceTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceTypesTable> {
  $$DeviceTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeviceTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceTypesTable> {
  $$DeviceTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> deviceModelsRefs<T extends Object>(
    Expression<T> Function($$DeviceModelsTableAnnotationComposer a) f,
  ) {
    final $$DeviceModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceModels,
      getReferencedColumn: (t) => t.deviceTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> deviceTypeComponentsRefs<T extends Object>(
    Expression<T> Function($$DeviceTypeComponentsTableAnnotationComposer a) f,
  ) {
    final $$DeviceTypeComponentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.deviceTypeComponents,
          getReferencedColumn: (t) => t.deviceTypeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DeviceTypeComponentsTableAnnotationComposer(
                $db: $db,
                $table: $db.deviceTypeComponents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> supplierDeviceTypesRefs<T extends Object>(
    Expression<T> Function($$SupplierDeviceTypesTableAnnotationComposer a) f,
  ) {
    final $$SupplierDeviceTypesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.supplierDeviceTypes,
          getReferencedColumn: (t) => t.deviceTypeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SupplierDeviceTypesTableAnnotationComposer(
                $db: $db,
                $table: $db.supplierDeviceTypes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> favoritesRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.deviceTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DeviceTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceTypesTable,
          DeviceTypeRow,
          $$DeviceTypesTableFilterComposer,
          $$DeviceTypesTableOrderingComposer,
          $$DeviceTypesTableAnnotationComposer,
          $$DeviceTypesTableCreateCompanionBuilder,
          $$DeviceTypesTableUpdateCompanionBuilder,
          (DeviceTypeRow, $$DeviceTypesTableReferences),
          DeviceTypeRow,
          PrefetchHooks Function({
            bool deviceModelsRefs,
            bool deviceTypeComponentsRefs,
            bool supplierDeviceTypesRefs,
            bool favoritesRefs,
          })
        > {
  $$DeviceTypesTableTableManager(_$AppDatabase db, $DeviceTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceTypesCompanion(
                id: id,
                name: name,
                description: description,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceTypesCompanion.insert(
                id: id,
                name: name,
                description: description,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeviceTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                deviceModelsRefs = false,
                deviceTypeComponentsRefs = false,
                supplierDeviceTypesRefs = false,
                favoritesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (deviceModelsRefs) db.deviceModels,
                    if (deviceTypeComponentsRefs) db.deviceTypeComponents,
                    if (supplierDeviceTypesRefs) db.supplierDeviceTypes,
                    if (favoritesRefs) db.favorites,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (deviceModelsRefs)
                        await $_getPrefetchedData<
                          DeviceTypeRow,
                          $DeviceTypesTable,
                          DeviceModelRow
                        >(
                          currentTable: table,
                          referencedTable: $$DeviceTypesTableReferences
                              ._deviceModelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeviceTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceModelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (deviceTypeComponentsRefs)
                        await $_getPrefetchedData<
                          DeviceTypeRow,
                          $DeviceTypesTable,
                          DeviceTypeComponentRow
                        >(
                          currentTable: table,
                          referencedTable: $$DeviceTypesTableReferences
                              ._deviceTypeComponentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeviceTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceTypeComponentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (supplierDeviceTypesRefs)
                        await $_getPrefetchedData<
                          DeviceTypeRow,
                          $DeviceTypesTable,
                          SupplierDeviceTypeRow
                        >(
                          currentTable: table,
                          referencedTable: $$DeviceTypesTableReferences
                              ._supplierDeviceTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeviceTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).supplierDeviceTypesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (favoritesRefs)
                        await $_getPrefetchedData<
                          DeviceTypeRow,
                          $DeviceTypesTable,
                          FavoriteRow
                        >(
                          currentTable: table,
                          referencedTable: $$DeviceTypesTableReferences
                              ._favoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeviceTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DeviceTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceTypesTable,
      DeviceTypeRow,
      $$DeviceTypesTableFilterComposer,
      $$DeviceTypesTableOrderingComposer,
      $$DeviceTypesTableAnnotationComposer,
      $$DeviceTypesTableCreateCompanionBuilder,
      $$DeviceTypesTableUpdateCompanionBuilder,
      (DeviceTypeRow, $$DeviceTypesTableReferences),
      DeviceTypeRow,
      PrefetchHooks Function({
        bool deviceModelsRefs,
        bool deviceTypeComponentsRefs,
        bool supplierDeviceTypesRefs,
        bool favoritesRefs,
      })
    >;
typedef $$BrandsTableCreateCompanionBuilder =
    BrandsCompanion Function({
      required String id,
      required String name,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$BrandsTableUpdateCompanionBuilder =
    BrandsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$BrandsTableReferences
    extends BaseReferences<_$AppDatabase, $BrandsTable, BrandRow> {
  $$BrandsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DeviceModelsTable, List<DeviceModelRow>>
  _deviceModelsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deviceModels,
    aliasName: 'brands__id__device_models__brand_id',
  );

  $$DeviceModelsTableProcessedTableManager get deviceModelsRefs {
    final manager = $$DeviceModelsTableTableManager(
      $_db,
      $_db.deviceModels,
    ).filter((f) => f.brandId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_deviceModelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritesTable, List<FavoriteRow>>
  _favoritesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favorites,
    aliasName: 'brands__id__favorites__brand_id',
  );

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.brandId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BrandsTableFilterComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> deviceModelsRefs(
    Expression<bool> Function($$DeviceModelsTableFilterComposer f) f,
  ) {
    final $$DeviceModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceModels,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceModelsTableFilterComposer(
            $db: $db,
            $table: $db.deviceModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritesRefs(
    Expression<bool> Function($$FavoritesTableFilterComposer f) f,
  ) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BrandsTableOrderingComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrandsTable> {
  $$BrandsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> deviceModelsRefs<T extends Object>(
    Expression<T> Function($$DeviceModelsTableAnnotationComposer a) f,
  ) {
    final $$DeviceModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceModels,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> favoritesRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.brandId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BrandsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrandsTable,
          BrandRow,
          $$BrandsTableFilterComposer,
          $$BrandsTableOrderingComposer,
          $$BrandsTableAnnotationComposer,
          $$BrandsTableCreateCompanionBuilder,
          $$BrandsTableUpdateCompanionBuilder,
          (BrandRow, $$BrandsTableReferences),
          BrandRow,
          PrefetchHooks Function({bool deviceModelsRefs, bool favoritesRefs})
        > {
  $$BrandsTableTableManager(_$AppDatabase db, $BrandsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrandsCompanion(
                id: id,
                name: name,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrandsCompanion.insert(
                id: id,
                name: name,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BrandsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({deviceModelsRefs = false, favoritesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (deviceModelsRefs) db.deviceModels,
                    if (favoritesRefs) db.favorites,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (deviceModelsRefs)
                        await $_getPrefetchedData<
                          BrandRow,
                          $BrandsTable,
                          DeviceModelRow
                        >(
                          currentTable: table,
                          referencedTable: $$BrandsTableReferences
                              ._deviceModelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceModelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brandId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (favoritesRefs)
                        await $_getPrefetchedData<
                          BrandRow,
                          $BrandsTable,
                          FavoriteRow
                        >(
                          currentTable: table,
                          referencedTable: $$BrandsTableReferences
                              ._favoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BrandsTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.brandId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BrandsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrandsTable,
      BrandRow,
      $$BrandsTableFilterComposer,
      $$BrandsTableOrderingComposer,
      $$BrandsTableAnnotationComposer,
      $$BrandsTableCreateCompanionBuilder,
      $$BrandsTableUpdateCompanionBuilder,
      (BrandRow, $$BrandsTableReferences),
      BrandRow,
      PrefetchHooks Function({bool deviceModelsRefs, bool favoritesRefs})
    >;
typedef $$DeviceModelsTableCreateCompanionBuilder =
    DeviceModelsCompanion Function({
      required String id,
      required String name,
      Value<String?> modelCode,
      Value<String?> alternativeSearchTerms,
      required String deviceTypeId,
      required String brandId,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$DeviceModelsTableUpdateCompanionBuilder =
    DeviceModelsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> modelCode,
      Value<String?> alternativeSearchTerms,
      Value<String> deviceTypeId,
      Value<String> brandId,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$DeviceModelsTableReferences
    extends BaseReferences<_$AppDatabase, $DeviceModelsTable, DeviceModelRow> {
  $$DeviceModelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DeviceTypesTable _deviceTypeIdTable(_$AppDatabase db) => db
      .deviceTypes
      .createAlias('device_models__device_type_id__device_types__id');

  $$DeviceTypesTableProcessedTableManager get deviceTypeId {
    final $_column = $_itemColumn<String>('device_type_id')!;

    final manager = $$DeviceTypesTableTableManager(
      $_db,
      $_db.deviceTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BrandsTable _brandIdTable(_$AppDatabase db) =>
      db.brands.createAlias('device_models__brand_id__brands__id');

  $$BrandsTableProcessedTableManager get brandId {
    final $_column = $_itemColumn<String>('brand_id')!;

    final manager = $$BrandsTableTableManager(
      $_db,
      $_db.brands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FavoritesTable, List<FavoriteRow>>
  _favoritesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favorites,
    aliasName: 'device_models__id__favorites__device_model_id',
  );

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.deviceModelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DeviceModelsTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceModelsTable> {
  $$DeviceModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelCode => $composableBuilder(
    column: $table.modelCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternativeSearchTerms => $composableBuilder(
    column: $table.alternativeSearchTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$DeviceTypesTableFilterComposer get deviceTypeId {
    final $$DeviceTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableFilterComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableFilterComposer get brandId {
    final $$BrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableFilterComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> favoritesRefs(
    Expression<bool> Function($$FavoritesTableFilterComposer f) f,
  ) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.deviceModelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DeviceModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceModelsTable> {
  $$DeviceModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelCode => $composableBuilder(
    column: $table.modelCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternativeSearchTerms => $composableBuilder(
    column: $table.alternativeSearchTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$DeviceTypesTableOrderingComposer get deviceTypeId {
    final $$DeviceTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableOrderingComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableOrderingComposer get brandId {
    final $$BrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableOrderingComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceModelsTable> {
  $$DeviceModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get modelCode =>
      $composableBuilder(column: $table.modelCode, builder: (column) => column);

  GeneratedColumn<String> get alternativeSearchTerms => $composableBuilder(
    column: $table.alternativeSearchTerms,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$DeviceTypesTableAnnotationComposer get deviceTypeId {
    final $$DeviceTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableAnnotationComposer get brandId {
    final $$BrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> favoritesRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.deviceModelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DeviceModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceModelsTable,
          DeviceModelRow,
          $$DeviceModelsTableFilterComposer,
          $$DeviceModelsTableOrderingComposer,
          $$DeviceModelsTableAnnotationComposer,
          $$DeviceModelsTableCreateCompanionBuilder,
          $$DeviceModelsTableUpdateCompanionBuilder,
          (DeviceModelRow, $$DeviceModelsTableReferences),
          DeviceModelRow,
          PrefetchHooks Function({
            bool deviceTypeId,
            bool brandId,
            bool favoritesRefs,
          })
        > {
  $$DeviceModelsTableTableManager(_$AppDatabase db, $DeviceModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> modelCode = const Value.absent(),
                Value<String?> alternativeSearchTerms = const Value.absent(),
                Value<String> deviceTypeId = const Value.absent(),
                Value<String> brandId = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceModelsCompanion(
                id: id,
                name: name,
                modelCode: modelCode,
                alternativeSearchTerms: alternativeSearchTerms,
                deviceTypeId: deviceTypeId,
                brandId: brandId,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> modelCode = const Value.absent(),
                Value<String?> alternativeSearchTerms = const Value.absent(),
                required String deviceTypeId,
                required String brandId,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceModelsCompanion.insert(
                id: id,
                name: name,
                modelCode: modelCode,
                alternativeSearchTerms: alternativeSearchTerms,
                deviceTypeId: deviceTypeId,
                brandId: brandId,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeviceModelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({deviceTypeId = false, brandId = false, favoritesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (favoritesRefs) db.favorites],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (deviceTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.deviceTypeId,
                                    referencedTable:
                                        $$DeviceModelsTableReferences
                                            ._deviceTypeIdTable(db),
                                    referencedColumn:
                                        $$DeviceModelsTableReferences
                                            ._deviceTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (brandId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.brandId,
                                    referencedTable:
                                        $$DeviceModelsTableReferences
                                            ._brandIdTable(db),
                                    referencedColumn:
                                        $$DeviceModelsTableReferences
                                            ._brandIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (favoritesRefs)
                        await $_getPrefetchedData<
                          DeviceModelRow,
                          $DeviceModelsTable,
                          FavoriteRow
                        >(
                          currentTable: table,
                          referencedTable: $$DeviceModelsTableReferences
                              ._favoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DeviceModelsTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deviceModelId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DeviceModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceModelsTable,
      DeviceModelRow,
      $$DeviceModelsTableFilterComposer,
      $$DeviceModelsTableOrderingComposer,
      $$DeviceModelsTableAnnotationComposer,
      $$DeviceModelsTableCreateCompanionBuilder,
      $$DeviceModelsTableUpdateCompanionBuilder,
      (DeviceModelRow, $$DeviceModelsTableReferences),
      DeviceModelRow,
      PrefetchHooks Function({
        bool deviceTypeId,
        bool brandId,
        bool favoritesRefs,
      })
    >;
typedef $$ComponentsTableCreateCompanionBuilder =
    ComponentsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$ComponentsTableUpdateCompanionBuilder =
    ComponentsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$ComponentsTableReferences
    extends BaseReferences<_$AppDatabase, $ComponentsTable, ComponentRow> {
  $$ComponentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $DeviceTypeComponentsTable,
    List<DeviceTypeComponentRow>
  >
  _deviceTypeComponentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.deviceTypeComponents,
        aliasName: 'components__id__device_type_components__component_id',
      );

  $$DeviceTypeComponentsTableProcessedTableManager
  get deviceTypeComponentsRefs {
    final manager = $$DeviceTypeComponentsTableTableManager(
      $_db,
      $_db.deviceTypeComponents,
    ).filter((f) => f.componentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _deviceTypeComponentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritesTable, List<FavoriteRow>>
  _favoritesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favorites,
    aliasName: 'components__id__favorites__component_id',
  );

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.componentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ComponentsTableFilterComposer
    extends Composer<_$AppDatabase, $ComponentsTable> {
  $$ComponentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> deviceTypeComponentsRefs(
    Expression<bool> Function($$DeviceTypeComponentsTableFilterComposer f) f,
  ) {
    final $$DeviceTypeComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deviceTypeComponents,
      getReferencedColumn: (t) => t.componentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypeComponentsTableFilterComposer(
            $db: $db,
            $table: $db.deviceTypeComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritesRefs(
    Expression<bool> Function($$FavoritesTableFilterComposer f) f,
  ) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.componentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ComponentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ComponentsTable> {
  $$ComponentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ComponentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComponentsTable> {
  $$ComponentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> deviceTypeComponentsRefs<T extends Object>(
    Expression<T> Function($$DeviceTypeComponentsTableAnnotationComposer a) f,
  ) {
    final $$DeviceTypeComponentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.deviceTypeComponents,
          getReferencedColumn: (t) => t.componentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DeviceTypeComponentsTableAnnotationComposer(
                $db: $db,
                $table: $db.deviceTypeComponents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> favoritesRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.componentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ComponentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComponentsTable,
          ComponentRow,
          $$ComponentsTableFilterComposer,
          $$ComponentsTableOrderingComposer,
          $$ComponentsTableAnnotationComposer,
          $$ComponentsTableCreateCompanionBuilder,
          $$ComponentsTableUpdateCompanionBuilder,
          (ComponentRow, $$ComponentsTableReferences),
          ComponentRow,
          PrefetchHooks Function({
            bool deviceTypeComponentsRefs,
            bool favoritesRefs,
          })
        > {
  $$ComponentsTableTableManager(_$AppDatabase db, $ComponentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComponentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComponentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComponentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ComponentsCompanion(
                id: id,
                name: name,
                description: description,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ComponentsCompanion.insert(
                id: id,
                name: name,
                description: description,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ComponentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({deviceTypeComponentsRefs = false, favoritesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (deviceTypeComponentsRefs) db.deviceTypeComponents,
                    if (favoritesRefs) db.favorites,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (deviceTypeComponentsRefs)
                        await $_getPrefetchedData<
                          ComponentRow,
                          $ComponentsTable,
                          DeviceTypeComponentRow
                        >(
                          currentTable: table,
                          referencedTable: $$ComponentsTableReferences
                              ._deviceTypeComponentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ComponentsTableReferences(
                                db,
                                table,
                                p0,
                              ).deviceTypeComponentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.componentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (favoritesRefs)
                        await $_getPrefetchedData<
                          ComponentRow,
                          $ComponentsTable,
                          FavoriteRow
                        >(
                          currentTable: table,
                          referencedTable: $$ComponentsTableReferences
                              ._favoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ComponentsTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.componentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ComponentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComponentsTable,
      ComponentRow,
      $$ComponentsTableFilterComposer,
      $$ComponentsTableOrderingComposer,
      $$ComponentsTableAnnotationComposer,
      $$ComponentsTableCreateCompanionBuilder,
      $$ComponentsTableUpdateCompanionBuilder,
      (ComponentRow, $$ComponentsTableReferences),
      ComponentRow,
      PrefetchHooks Function({
        bool deviceTypeComponentsRefs,
        bool favoritesRefs,
      })
    >;
typedef $$DeviceTypeComponentsTableCreateCompanionBuilder =
    DeviceTypeComponentsCompanion Function({
      required String deviceTypeId,
      required String componentId,
      Value<int> rowid,
    });
typedef $$DeviceTypeComponentsTableUpdateCompanionBuilder =
    DeviceTypeComponentsCompanion Function({
      Value<String> deviceTypeId,
      Value<String> componentId,
      Value<int> rowid,
    });

final class $$DeviceTypeComponentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DeviceTypeComponentsTable,
          DeviceTypeComponentRow
        > {
  $$DeviceTypeComponentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DeviceTypesTable _deviceTypeIdTable(_$AppDatabase db) => db
      .deviceTypes
      .createAlias('device_type_components__device_type_id__device_types__id');

  $$DeviceTypesTableProcessedTableManager get deviceTypeId {
    final $_column = $_itemColumn<String>('device_type_id')!;

    final manager = $$DeviceTypesTableTableManager(
      $_db,
      $_db.deviceTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ComponentsTable _componentIdTable(_$AppDatabase db) => db.components
      .createAlias('device_type_components__component_id__components__id');

  $$ComponentsTableProcessedTableManager get componentId {
    final $_column = $_itemColumn<String>('component_id')!;

    final manager = $$ComponentsTableTableManager(
      $_db,
      $_db.components,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_componentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DeviceTypeComponentsTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceTypeComponentsTable> {
  $$DeviceTypeComponentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$DeviceTypesTableFilterComposer get deviceTypeId {
    final $$DeviceTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableFilterComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComponentsTableFilterComposer get componentId {
    final $$ComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.componentId,
      referencedTable: $db.components,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComponentsTableFilterComposer(
            $db: $db,
            $table: $db.components,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceTypeComponentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceTypeComponentsTable> {
  $$DeviceTypeComponentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$DeviceTypesTableOrderingComposer get deviceTypeId {
    final $$DeviceTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableOrderingComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComponentsTableOrderingComposer get componentId {
    final $$ComponentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.componentId,
      referencedTable: $db.components,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComponentsTableOrderingComposer(
            $db: $db,
            $table: $db.components,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceTypeComponentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceTypeComponentsTable> {
  $$DeviceTypeComponentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$DeviceTypesTableAnnotationComposer get deviceTypeId {
    final $$DeviceTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComponentsTableAnnotationComposer get componentId {
    final $$ComponentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.componentId,
      referencedTable: $db.components,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComponentsTableAnnotationComposer(
            $db: $db,
            $table: $db.components,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeviceTypeComponentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceTypeComponentsTable,
          DeviceTypeComponentRow,
          $$DeviceTypeComponentsTableFilterComposer,
          $$DeviceTypeComponentsTableOrderingComposer,
          $$DeviceTypeComponentsTableAnnotationComposer,
          $$DeviceTypeComponentsTableCreateCompanionBuilder,
          $$DeviceTypeComponentsTableUpdateCompanionBuilder,
          (DeviceTypeComponentRow, $$DeviceTypeComponentsTableReferences),
          DeviceTypeComponentRow,
          PrefetchHooks Function({bool deviceTypeId, bool componentId})
        > {
  $$DeviceTypeComponentsTableTableManager(
    _$AppDatabase db,
    $DeviceTypeComponentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceTypeComponentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceTypeComponentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DeviceTypeComponentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> deviceTypeId = const Value.absent(),
                Value<String> componentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceTypeComponentsCompanion(
                deviceTypeId: deviceTypeId,
                componentId: componentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String deviceTypeId,
                required String componentId,
                Value<int> rowid = const Value.absent(),
              }) => DeviceTypeComponentsCompanion.insert(
                deviceTypeId: deviceTypeId,
                componentId: componentId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeviceTypeComponentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({deviceTypeId = false, componentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (deviceTypeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deviceTypeId,
                                referencedTable:
                                    $$DeviceTypeComponentsTableReferences
                                        ._deviceTypeIdTable(db),
                                referencedColumn:
                                    $$DeviceTypeComponentsTableReferences
                                        ._deviceTypeIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (componentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.componentId,
                                referencedTable:
                                    $$DeviceTypeComponentsTableReferences
                                        ._componentIdTable(db),
                                referencedColumn:
                                    $$DeviceTypeComponentsTableReferences
                                        ._componentIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DeviceTypeComponentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceTypeComponentsTable,
      DeviceTypeComponentRow,
      $$DeviceTypeComponentsTableFilterComposer,
      $$DeviceTypeComponentsTableOrderingComposer,
      $$DeviceTypeComponentsTableAnnotationComposer,
      $$DeviceTypeComponentsTableCreateCompanionBuilder,
      $$DeviceTypeComponentsTableUpdateCompanionBuilder,
      (DeviceTypeComponentRow, $$DeviceTypeComponentsTableReferences),
      DeviceTypeComponentRow,
      PrefetchHooks Function({bool deviceTypeId, bool componentId})
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      required String id,
      required String name,
      required String baseUrl,
      required String urlTemplate,
      Value<int> displayOrder,
      Value<String?> notes,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> baseUrl,
      Value<String> urlTemplate,
      Value<int> displayOrder,
      Value<String?> notes,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$SuppliersTableReferences
    extends BaseReferences<_$AppDatabase, $SuppliersTable, SupplierRow> {
  $$SuppliersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $SupplierDeviceTypesTable,
    List<SupplierDeviceTypeRow>
  >
  _supplierDeviceTypesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.supplierDeviceTypes,
        aliasName: 'suppliers__id__supplier_device_types__supplier_id',
      );

  $$SupplierDeviceTypesTableProcessedTableManager get supplierDeviceTypesRefs {
    final manager = $$SupplierDeviceTypesTableTableManager(
      $_db,
      $_db.supplierDeviceTypes,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _supplierDeviceTypesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SearchHistorySuppliersTable,
    List<SearchHistorySupplierRow>
  >
  _searchHistorySuppliersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.searchHistorySuppliers,
        aliasName: 'suppliers__id__search_history_suppliers__supplier_id',
      );

  $$SearchHistorySuppliersTableProcessedTableManager
  get searchHistorySuppliersRefs {
    final manager = $$SearchHistorySuppliersTableTableManager(
      $_db,
      $_db.searchHistorySuppliers,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _searchHistorySuppliersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoriteSuppliersTable, List<FavoriteSupplierRow>>
  _favoriteSuppliersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.favoriteSuppliers,
        aliasName: 'suppliers__id__favorite_suppliers__supplier_id',
      );

  $$FavoriteSuppliersTableProcessedTableManager get favoriteSuppliersRefs {
    final manager = $$FavoriteSuppliersTableTableManager(
      $_db,
      $_db.favoriteSuppliers,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _favoriteSuppliersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urlTemplate => $composableBuilder(
    column: $table.urlTemplate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> supplierDeviceTypesRefs(
    Expression<bool> Function($$SupplierDeviceTypesTableFilterComposer f) f,
  ) {
    final $$SupplierDeviceTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierDeviceTypes,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SupplierDeviceTypesTableFilterComposer(
            $db: $db,
            $table: $db.supplierDeviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> searchHistorySuppliersRefs(
    Expression<bool> Function($$SearchHistorySuppliersTableFilterComposer f) f,
  ) {
    final $$SearchHistorySuppliersTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.searchHistorySuppliers,
          getReferencedColumn: (t) => t.supplierId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SearchHistorySuppliersTableFilterComposer(
                $db: $db,
                $table: $db.searchHistorySuppliers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> favoriteSuppliersRefs(
    Expression<bool> Function($$FavoriteSuppliersTableFilterComposer f) f,
  ) {
    final $$FavoriteSuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favoriteSuppliers,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteSuppliersTableFilterComposer(
            $db: $db,
            $table: $db.favoriteSuppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urlTemplate => $composableBuilder(
    column: $table.urlTemplate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get urlTemplate => $composableBuilder(
    column: $table.urlTemplate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> supplierDeviceTypesRefs<T extends Object>(
    Expression<T> Function($$SupplierDeviceTypesTableAnnotationComposer a) f,
  ) {
    final $$SupplierDeviceTypesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.supplierDeviceTypes,
          getReferencedColumn: (t) => t.supplierId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SupplierDeviceTypesTableAnnotationComposer(
                $db: $db,
                $table: $db.supplierDeviceTypes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> searchHistorySuppliersRefs<T extends Object>(
    Expression<T> Function($$SearchHistorySuppliersTableAnnotationComposer a) f,
  ) {
    final $$SearchHistorySuppliersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.searchHistorySuppliers,
          getReferencedColumn: (t) => t.supplierId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SearchHistorySuppliersTableAnnotationComposer(
                $db: $db,
                $table: $db.searchHistorySuppliers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> favoriteSuppliersRefs<T extends Object>(
    Expression<T> Function($$FavoriteSuppliersTableAnnotationComposer a) f,
  ) {
    final $$FavoriteSuppliersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.favoriteSuppliers,
          getReferencedColumn: (t) => t.supplierId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FavoriteSuppliersTableAnnotationComposer(
                $db: $db,
                $table: $db.favoriteSuppliers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          SupplierRow,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (SupplierRow, $$SuppliersTableReferences),
          SupplierRow,
          PrefetchHooks Function({
            bool supplierDeviceTypesRefs,
            bool searchHistorySuppliersRefs,
            bool favoriteSuppliersRefs,
          })
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String> urlTemplate = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                name: name,
                baseUrl: baseUrl,
                urlTemplate: urlTemplate,
                displayOrder: displayOrder,
                notes: notes,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String baseUrl,
                required String urlTemplate,
                Value<int> displayOrder = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                name: name,
                baseUrl: baseUrl,
                urlTemplate: urlTemplate,
                displayOrder: displayOrder,
                notes: notes,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                supplierDeviceTypesRefs = false,
                searchHistorySuppliersRefs = false,
                favoriteSuppliersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (supplierDeviceTypesRefs) db.supplierDeviceTypes,
                    if (searchHistorySuppliersRefs) db.searchHistorySuppliers,
                    if (favoriteSuppliersRefs) db.favoriteSuppliers,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (supplierDeviceTypesRefs)
                        await $_getPrefetchedData<
                          SupplierRow,
                          $SuppliersTable,
                          SupplierDeviceTypeRow
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences
                              ._supplierDeviceTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTableReferences(
                                db,
                                table,
                                p0,
                              ).supplierDeviceTypesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (searchHistorySuppliersRefs)
                        await $_getPrefetchedData<
                          SupplierRow,
                          $SuppliersTable,
                          SearchHistorySupplierRow
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences
                              ._searchHistorySuppliersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTableReferences(
                                db,
                                table,
                                p0,
                              ).searchHistorySuppliersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (favoriteSuppliersRefs)
                        await $_getPrefetchedData<
                          SupplierRow,
                          $SuppliersTable,
                          FavoriteSupplierRow
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences
                              ._favoriteSuppliersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTableReferences(
                                db,
                                table,
                                p0,
                              ).favoriteSuppliersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      SupplierRow,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (SupplierRow, $$SuppliersTableReferences),
      SupplierRow,
      PrefetchHooks Function({
        bool supplierDeviceTypesRefs,
        bool searchHistorySuppliersRefs,
        bool favoriteSuppliersRefs,
      })
    >;
typedef $$SupplierDeviceTypesTableCreateCompanionBuilder =
    SupplierDeviceTypesCompanion Function({
      required String supplierId,
      required String deviceTypeId,
      Value<int> rowid,
    });
typedef $$SupplierDeviceTypesTableUpdateCompanionBuilder =
    SupplierDeviceTypesCompanion Function({
      Value<String> supplierId,
      Value<String> deviceTypeId,
      Value<int> rowid,
    });

final class $$SupplierDeviceTypesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SupplierDeviceTypesTable,
          SupplierDeviceTypeRow
        > {
  $$SupplierDeviceTypesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) => db.suppliers
      .createAlias('supplier_device_types__supplier_id__suppliers__id');

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<String>('supplier_id')!;

    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DeviceTypesTable _deviceTypeIdTable(_$AppDatabase db) => db
      .deviceTypes
      .createAlias('supplier_device_types__device_type_id__device_types__id');

  $$DeviceTypesTableProcessedTableManager get deviceTypeId {
    final $_column = $_itemColumn<String>('device_type_id')!;

    final manager = $$DeviceTypesTableTableManager(
      $_db,
      $_db.deviceTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SupplierDeviceTypesTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierDeviceTypesTable> {
  $$SupplierDeviceTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DeviceTypesTableFilterComposer get deviceTypeId {
    final $$DeviceTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableFilterComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierDeviceTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierDeviceTypesTable> {
  $$SupplierDeviceTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DeviceTypesTableOrderingComposer get deviceTypeId {
    final $$DeviceTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableOrderingComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierDeviceTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierDeviceTypesTable> {
  $$SupplierDeviceTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DeviceTypesTableAnnotationComposer get deviceTypeId {
    final $$DeviceTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierDeviceTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierDeviceTypesTable,
          SupplierDeviceTypeRow,
          $$SupplierDeviceTypesTableFilterComposer,
          $$SupplierDeviceTypesTableOrderingComposer,
          $$SupplierDeviceTypesTableAnnotationComposer,
          $$SupplierDeviceTypesTableCreateCompanionBuilder,
          $$SupplierDeviceTypesTableUpdateCompanionBuilder,
          (SupplierDeviceTypeRow, $$SupplierDeviceTypesTableReferences),
          SupplierDeviceTypeRow,
          PrefetchHooks Function({bool supplierId, bool deviceTypeId})
        > {
  $$SupplierDeviceTypesTableTableManager(
    _$AppDatabase db,
    $SupplierDeviceTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierDeviceTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierDeviceTypesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupplierDeviceTypesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> supplierId = const Value.absent(),
                Value<String> deviceTypeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SupplierDeviceTypesCompanion(
                supplierId: supplierId,
                deviceTypeId: deviceTypeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String supplierId,
                required String deviceTypeId,
                Value<int> rowid = const Value.absent(),
              }) => SupplierDeviceTypesCompanion.insert(
                supplierId: supplierId,
                deviceTypeId: deviceTypeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SupplierDeviceTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({supplierId = false, deviceTypeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (supplierId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.supplierId,
                                referencedTable:
                                    $$SupplierDeviceTypesTableReferences
                                        ._supplierIdTable(db),
                                referencedColumn:
                                    $$SupplierDeviceTypesTableReferences
                                        ._supplierIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (deviceTypeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deviceTypeId,
                                referencedTable:
                                    $$SupplierDeviceTypesTableReferences
                                        ._deviceTypeIdTable(db),
                                referencedColumn:
                                    $$SupplierDeviceTypesTableReferences
                                        ._deviceTypeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SupplierDeviceTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierDeviceTypesTable,
      SupplierDeviceTypeRow,
      $$SupplierDeviceTypesTableFilterComposer,
      $$SupplierDeviceTypesTableOrderingComposer,
      $$SupplierDeviceTypesTableAnnotationComposer,
      $$SupplierDeviceTypesTableCreateCompanionBuilder,
      $$SupplierDeviceTypesTableUpdateCompanionBuilder,
      (SupplierDeviceTypeRow, $$SupplierDeviceTypesTableReferences),
      SupplierDeviceTypeRow,
      PrefetchHooks Function({bool supplierId, bool deviceTypeId})
    >;
typedef $$SearchHistoryEntriesTableCreateCompanionBuilder =
    SearchHistoryEntriesCompanion Function({
      required String id,
      required DateTime searchedAt,
      required String deviceType,
      required String brand,
      required String deviceModel,
      Value<String?> deviceModelCode,
      required String component,
      required String generatedQuery,
      Value<int> rowid,
    });
typedef $$SearchHistoryEntriesTableUpdateCompanionBuilder =
    SearchHistoryEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> searchedAt,
      Value<String> deviceType,
      Value<String> brand,
      Value<String> deviceModel,
      Value<String?> deviceModelCode,
      Value<String> component,
      Value<String> generatedQuery,
      Value<int> rowid,
    });

final class $$SearchHistoryEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SearchHistoryEntriesTable,
          SearchHistoryRow
        > {
  $$SearchHistoryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SearchHistorySuppliersTable,
    List<SearchHistorySupplierRow>
  >
  _searchHistorySuppliersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.searchHistorySuppliers,
        aliasName:
            'search_history__id__search_history_suppliers__search_history_id',
      );

  $$SearchHistorySuppliersTableProcessedTableManager
  get searchHistorySuppliersRefs {
    final manager =
        $$SearchHistorySuppliersTableTableManager(
          $_db,
          $_db.searchHistorySuppliers,
        ).filter(
          (f) => f.searchHistoryId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _searchHistorySuppliersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SearchHistoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistoryEntriesTable> {
  $$SearchHistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get searchedAt => $composableBuilder(
    column: $table.searchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceType => $composableBuilder(
    column: $table.deviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceModel => $composableBuilder(
    column: $table.deviceModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceModelCode => $composableBuilder(
    column: $table.deviceModelCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get component => $composableBuilder(
    column: $table.component,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get generatedQuery => $composableBuilder(
    column: $table.generatedQuery,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> searchHistorySuppliersRefs(
    Expression<bool> Function($$SearchHistorySuppliersTableFilterComposer f) f,
  ) {
    final $$SearchHistorySuppliersTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.searchHistorySuppliers,
          getReferencedColumn: (t) => t.searchHistoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SearchHistorySuppliersTableFilterComposer(
                $db: $db,
                $table: $db.searchHistorySuppliers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SearchHistoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistoryEntriesTable> {
  $$SearchHistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get searchedAt => $composableBuilder(
    column: $table.searchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceType => $composableBuilder(
    column: $table.deviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceModel => $composableBuilder(
    column: $table.deviceModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceModelCode => $composableBuilder(
    column: $table.deviceModelCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get component => $composableBuilder(
    column: $table.component,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get generatedQuery => $composableBuilder(
    column: $table.generatedQuery,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchHistoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistoryEntriesTable> {
  $$SearchHistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get searchedAt => $composableBuilder(
    column: $table.searchedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceType => $composableBuilder(
    column: $table.deviceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get deviceModel => $composableBuilder(
    column: $table.deviceModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceModelCode => $composableBuilder(
    column: $table.deviceModelCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get component =>
      $composableBuilder(column: $table.component, builder: (column) => column);

  GeneratedColumn<String> get generatedQuery => $composableBuilder(
    column: $table.generatedQuery,
    builder: (column) => column,
  );

  Expression<T> searchHistorySuppliersRefs<T extends Object>(
    Expression<T> Function($$SearchHistorySuppliersTableAnnotationComposer a) f,
  ) {
    final $$SearchHistorySuppliersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.searchHistorySuppliers,
          getReferencedColumn: (t) => t.searchHistoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SearchHistorySuppliersTableAnnotationComposer(
                $db: $db,
                $table: $db.searchHistorySuppliers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SearchHistoryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchHistoryEntriesTable,
          SearchHistoryRow,
          $$SearchHistoryEntriesTableFilterComposer,
          $$SearchHistoryEntriesTableOrderingComposer,
          $$SearchHistoryEntriesTableAnnotationComposer,
          $$SearchHistoryEntriesTableCreateCompanionBuilder,
          $$SearchHistoryEntriesTableUpdateCompanionBuilder,
          (SearchHistoryRow, $$SearchHistoryEntriesTableReferences),
          SearchHistoryRow,
          PrefetchHooks Function({bool searchHistorySuppliersRefs})
        > {
  $$SearchHistoryEntriesTableTableManager(
    _$AppDatabase db,
    $SearchHistoryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchHistoryEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SearchHistoryEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> searchedAt = const Value.absent(),
                Value<String> deviceType = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> deviceModel = const Value.absent(),
                Value<String?> deviceModelCode = const Value.absent(),
                Value<String> component = const Value.absent(),
                Value<String> generatedQuery = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchHistoryEntriesCompanion(
                id: id,
                searchedAt: searchedAt,
                deviceType: deviceType,
                brand: brand,
                deviceModel: deviceModel,
                deviceModelCode: deviceModelCode,
                component: component,
                generatedQuery: generatedQuery,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime searchedAt,
                required String deviceType,
                required String brand,
                required String deviceModel,
                Value<String?> deviceModelCode = const Value.absent(),
                required String component,
                required String generatedQuery,
                Value<int> rowid = const Value.absent(),
              }) => SearchHistoryEntriesCompanion.insert(
                id: id,
                searchedAt: searchedAt,
                deviceType: deviceType,
                brand: brand,
                deviceModel: deviceModel,
                deviceModelCode: deviceModelCode,
                component: component,
                generatedQuery: generatedQuery,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SearchHistoryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({searchHistorySuppliersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (searchHistorySuppliersRefs) db.searchHistorySuppliers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (searchHistorySuppliersRefs)
                    await $_getPrefetchedData<
                      SearchHistoryRow,
                      $SearchHistoryEntriesTable,
                      SearchHistorySupplierRow
                    >(
                      currentTable: table,
                      referencedTable: $$SearchHistoryEntriesTableReferences
                          ._searchHistorySuppliersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SearchHistoryEntriesTableReferences(
                            db,
                            table,
                            p0,
                          ).searchHistorySuppliersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.searchHistoryId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SearchHistoryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchHistoryEntriesTable,
      SearchHistoryRow,
      $$SearchHistoryEntriesTableFilterComposer,
      $$SearchHistoryEntriesTableOrderingComposer,
      $$SearchHistoryEntriesTableAnnotationComposer,
      $$SearchHistoryEntriesTableCreateCompanionBuilder,
      $$SearchHistoryEntriesTableUpdateCompanionBuilder,
      (SearchHistoryRow, $$SearchHistoryEntriesTableReferences),
      SearchHistoryRow,
      PrefetchHooks Function({bool searchHistorySuppliersRefs})
    >;
typedef $$SearchHistorySuppliersTableCreateCompanionBuilder =
    SearchHistorySuppliersCompanion Function({
      required String id,
      required String searchHistoryId,
      Value<String?> supplierId,
      required String supplierName,
      required String generatedUrl,
      Value<String?> openResult,
      Value<int> rowid,
    });
typedef $$SearchHistorySuppliersTableUpdateCompanionBuilder =
    SearchHistorySuppliersCompanion Function({
      Value<String> id,
      Value<String> searchHistoryId,
      Value<String?> supplierId,
      Value<String> supplierName,
      Value<String> generatedUrl,
      Value<String?> openResult,
      Value<int> rowid,
    });

final class $$SearchHistorySuppliersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SearchHistorySuppliersTable,
          SearchHistorySupplierRow
        > {
  $$SearchHistorySuppliersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SearchHistoryEntriesTable _searchHistoryIdTable(_$AppDatabase db) =>
      db.searchHistoryEntries.createAlias(
        'search_history_suppliers__search_history_id__search_history__id',
      );

  $$SearchHistoryEntriesTableProcessedTableManager get searchHistoryId {
    final $_column = $_itemColumn<String>('search_history_id')!;

    final manager = $$SearchHistoryEntriesTableTableManager(
      $_db,
      $_db.searchHistoryEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_searchHistoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) => db.suppliers
      .createAlias('search_history_suppliers__supplier_id__suppliers__id');

  $$SuppliersTableProcessedTableManager? get supplierId {
    final $_column = $_itemColumn<String>('supplier_id');
    if ($_column == null) return null;
    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SearchHistorySuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SearchHistorySuppliersTable> {
  $$SearchHistorySuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get generatedUrl => $composableBuilder(
    column: $table.generatedUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openResult => $composableBuilder(
    column: $table.openResult,
    builder: (column) => ColumnFilters(column),
  );

  $$SearchHistoryEntriesTableFilterComposer get searchHistoryId {
    final $$SearchHistoryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchHistoryId,
      referencedTable: $db.searchHistoryEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SearchHistoryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.searchHistoryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SearchHistorySuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchHistorySuppliersTable> {
  $$SearchHistorySuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get generatedUrl => $composableBuilder(
    column: $table.generatedUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openResult => $composableBuilder(
    column: $table.openResult,
    builder: (column) => ColumnOrderings(column),
  );

  $$SearchHistoryEntriesTableOrderingComposer get searchHistoryId {
    final $$SearchHistoryEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.searchHistoryId,
          referencedTable: $db.searchHistoryEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SearchHistoryEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.searchHistoryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SearchHistorySuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchHistorySuppliersTable> {
  $$SearchHistorySuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get generatedUrl => $composableBuilder(
    column: $table.generatedUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get openResult => $composableBuilder(
    column: $table.openResult,
    builder: (column) => column,
  );

  $$SearchHistoryEntriesTableAnnotationComposer get searchHistoryId {
    final $$SearchHistoryEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.searchHistoryId,
          referencedTable: $db.searchHistoryEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SearchHistoryEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.searchHistoryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SearchHistorySuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchHistorySuppliersTable,
          SearchHistorySupplierRow,
          $$SearchHistorySuppliersTableFilterComposer,
          $$SearchHistorySuppliersTableOrderingComposer,
          $$SearchHistorySuppliersTableAnnotationComposer,
          $$SearchHistorySuppliersTableCreateCompanionBuilder,
          $$SearchHistorySuppliersTableUpdateCompanionBuilder,
          (SearchHistorySupplierRow, $$SearchHistorySuppliersTableReferences),
          SearchHistorySupplierRow,
          PrefetchHooks Function({bool searchHistoryId, bool supplierId})
        > {
  $$SearchHistorySuppliersTableTableManager(
    _$AppDatabase db,
    $SearchHistorySuppliersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchHistorySuppliersTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SearchHistorySuppliersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SearchHistorySuppliersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> searchHistoryId = const Value.absent(),
                Value<String?> supplierId = const Value.absent(),
                Value<String> supplierName = const Value.absent(),
                Value<String> generatedUrl = const Value.absent(),
                Value<String?> openResult = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchHistorySuppliersCompanion(
                id: id,
                searchHistoryId: searchHistoryId,
                supplierId: supplierId,
                supplierName: supplierName,
                generatedUrl: generatedUrl,
                openResult: openResult,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String searchHistoryId,
                Value<String?> supplierId = const Value.absent(),
                required String supplierName,
                required String generatedUrl,
                Value<String?> openResult = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SearchHistorySuppliersCompanion.insert(
                id: id,
                searchHistoryId: searchHistoryId,
                supplierId: supplierId,
                supplierName: supplierName,
                generatedUrl: generatedUrl,
                openResult: openResult,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SearchHistorySuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({searchHistoryId = false, supplierId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (searchHistoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.searchHistoryId,
                                    referencedTable:
                                        $$SearchHistorySuppliersTableReferences
                                            ._searchHistoryIdTable(db),
                                    referencedColumn:
                                        $$SearchHistorySuppliersTableReferences
                                            ._searchHistoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$SearchHistorySuppliersTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$SearchHistorySuppliersTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$SearchHistorySuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchHistorySuppliersTable,
      SearchHistorySupplierRow,
      $$SearchHistorySuppliersTableFilterComposer,
      $$SearchHistorySuppliersTableOrderingComposer,
      $$SearchHistorySuppliersTableAnnotationComposer,
      $$SearchHistorySuppliersTableCreateCompanionBuilder,
      $$SearchHistorySuppliersTableUpdateCompanionBuilder,
      (SearchHistorySupplierRow, $$SearchHistorySuppliersTableReferences),
      SearchHistorySupplierRow,
      PrefetchHooks Function({bool searchHistoryId, bool supplierId})
    >;
typedef $$FavoritesTableCreateCompanionBuilder =
    FavoritesCompanion Function({
      required String id,
      required String name,
      required String deviceTypeId,
      required String brandId,
      required String deviceModelId,
      required String componentId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$FavoritesTableUpdateCompanionBuilder =
    FavoritesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> deviceTypeId,
      Value<String> brandId,
      Value<String> deviceModelId,
      Value<String> componentId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$FavoritesTableReferences
    extends BaseReferences<_$AppDatabase, $FavoritesTable, FavoriteRow> {
  $$FavoritesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DeviceTypesTable _deviceTypeIdTable(_$AppDatabase db) =>
      db.deviceTypes.createAlias('favorites__device_type_id__device_types__id');

  $$DeviceTypesTableProcessedTableManager get deviceTypeId {
    final $_column = $_itemColumn<String>('device_type_id')!;

    final manager = $$DeviceTypesTableTableManager(
      $_db,
      $_db.deviceTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BrandsTable _brandIdTable(_$AppDatabase db) =>
      db.brands.createAlias('favorites__brand_id__brands__id');

  $$BrandsTableProcessedTableManager get brandId {
    final $_column = $_itemColumn<String>('brand_id')!;

    final manager = $$BrandsTableTableManager(
      $_db,
      $_db.brands,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_brandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DeviceModelsTable _deviceModelIdTable(_$AppDatabase db) => db
      .deviceModels
      .createAlias('favorites__device_model_id__device_models__id');

  $$DeviceModelsTableProcessedTableManager get deviceModelId {
    final $_column = $_itemColumn<String>('device_model_id')!;

    final manager = $$DeviceModelsTableTableManager(
      $_db,
      $_db.deviceModels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deviceModelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ComponentsTable _componentIdTable(_$AppDatabase db) =>
      db.components.createAlias('favorites__component_id__components__id');

  $$ComponentsTableProcessedTableManager get componentId {
    final $_column = $_itemColumn<String>('component_id')!;

    final manager = $$ComponentsTableTableManager(
      $_db,
      $_db.components,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_componentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FavoriteSuppliersTable, List<FavoriteSupplierRow>>
  _favoriteSuppliersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.favoriteSuppliers,
        aliasName: 'favorites__id__favorite_suppliers__favorite_id',
      );

  $$FavoriteSuppliersTableProcessedTableManager get favoriteSuppliersRefs {
    final manager = $$FavoriteSuppliersTableTableManager(
      $_db,
      $_db.favoriteSuppliers,
    ).filter((f) => f.favoriteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _favoriteSuppliersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DeviceTypesTableFilterComposer get deviceTypeId {
    final $$DeviceTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableFilterComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableFilterComposer get brandId {
    final $$BrandsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableFilterComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DeviceModelsTableFilterComposer get deviceModelId {
    final $$DeviceModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceModelId,
      referencedTable: $db.deviceModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceModelsTableFilterComposer(
            $db: $db,
            $table: $db.deviceModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComponentsTableFilterComposer get componentId {
    final $$ComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.componentId,
      referencedTable: $db.components,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComponentsTableFilterComposer(
            $db: $db,
            $table: $db.components,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> favoriteSuppliersRefs(
    Expression<bool> Function($$FavoriteSuppliersTableFilterComposer f) f,
  ) {
    final $$FavoriteSuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favoriteSuppliers,
      getReferencedColumn: (t) => t.favoriteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoriteSuppliersTableFilterComposer(
            $db: $db,
            $table: $db.favoriteSuppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DeviceTypesTableOrderingComposer get deviceTypeId {
    final $$DeviceTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableOrderingComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableOrderingComposer get brandId {
    final $$BrandsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableOrderingComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DeviceModelsTableOrderingComposer get deviceModelId {
    final $$DeviceModelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceModelId,
      referencedTable: $db.deviceModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceModelsTableOrderingComposer(
            $db: $db,
            $table: $db.deviceModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComponentsTableOrderingComposer get componentId {
    final $$ComponentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.componentId,
      referencedTable: $db.components,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComponentsTableOrderingComposer(
            $db: $db,
            $table: $db.components,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DeviceTypesTableAnnotationComposer get deviceTypeId {
    final $$DeviceTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceTypeId,
      referencedTable: $db.deviceTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BrandsTableAnnotationComposer get brandId {
    final $$BrandsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.brandId,
      referencedTable: $db.brands,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BrandsTableAnnotationComposer(
            $db: $db,
            $table: $db.brands,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DeviceModelsTableAnnotationComposer get deviceModelId {
    final $$DeviceModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deviceModelId,
      referencedTable: $db.deviceModels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeviceModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.deviceModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComponentsTableAnnotationComposer get componentId {
    final $$ComponentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.componentId,
      referencedTable: $db.components,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComponentsTableAnnotationComposer(
            $db: $db,
            $table: $db.components,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> favoriteSuppliersRefs<T extends Object>(
    Expression<T> Function($$FavoriteSuppliersTableAnnotationComposer a) f,
  ) {
    final $$FavoriteSuppliersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.favoriteSuppliers,
          getReferencedColumn: (t) => t.favoriteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FavoriteSuppliersTableAnnotationComposer(
                $db: $db,
                $table: $db.favoriteSuppliers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          FavoriteRow,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (FavoriteRow, $$FavoritesTableReferences),
          FavoriteRow,
          PrefetchHooks Function({
            bool deviceTypeId,
            bool brandId,
            bool deviceModelId,
            bool componentId,
            bool favoriteSuppliersRefs,
          })
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> deviceTypeId = const Value.absent(),
                Value<String> brandId = const Value.absent(),
                Value<String> deviceModelId = const Value.absent(),
                Value<String> componentId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion(
                id: id,
                name: name,
                deviceTypeId: deviceTypeId,
                brandId: brandId,
                deviceModelId: deviceModelId,
                componentId: componentId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String deviceTypeId,
                required String brandId,
                required String deviceModelId,
                required String componentId,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion.insert(
                id: id,
                name: name,
                deviceTypeId: deviceTypeId,
                brandId: brandId,
                deviceModelId: deviceModelId,
                componentId: componentId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FavoritesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                deviceTypeId = false,
                brandId = false,
                deviceModelId = false,
                componentId = false,
                favoriteSuppliersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (favoriteSuppliersRefs) db.favoriteSuppliers,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (deviceTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.deviceTypeId,
                                    referencedTable: $$FavoritesTableReferences
                                        ._deviceTypeIdTable(db),
                                    referencedColumn: $$FavoritesTableReferences
                                        ._deviceTypeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (brandId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.brandId,
                                    referencedTable: $$FavoritesTableReferences
                                        ._brandIdTable(db),
                                    referencedColumn: $$FavoritesTableReferences
                                        ._brandIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (deviceModelId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.deviceModelId,
                                    referencedTable: $$FavoritesTableReferences
                                        ._deviceModelIdTable(db),
                                    referencedColumn: $$FavoritesTableReferences
                                        ._deviceModelIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (componentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.componentId,
                                    referencedTable: $$FavoritesTableReferences
                                        ._componentIdTable(db),
                                    referencedColumn: $$FavoritesTableReferences
                                        ._componentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (favoriteSuppliersRefs)
                        await $_getPrefetchedData<
                          FavoriteRow,
                          $FavoritesTable,
                          FavoriteSupplierRow
                        >(
                          currentTable: table,
                          referencedTable: $$FavoritesTableReferences
                              ._favoriteSuppliersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FavoritesTableReferences(
                                db,
                                table,
                                p0,
                              ).favoriteSuppliersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.favoriteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      FavoriteRow,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (FavoriteRow, $$FavoritesTableReferences),
      FavoriteRow,
      PrefetchHooks Function({
        bool deviceTypeId,
        bool brandId,
        bool deviceModelId,
        bool componentId,
        bool favoriteSuppliersRefs,
      })
    >;
typedef $$FavoriteSuppliersTableCreateCompanionBuilder =
    FavoriteSuppliersCompanion Function({
      required String favoriteId,
      required String supplierId,
      Value<int> rowid,
    });
typedef $$FavoriteSuppliersTableUpdateCompanionBuilder =
    FavoriteSuppliersCompanion Function({
      Value<String> favoriteId,
      Value<String> supplierId,
      Value<int> rowid,
    });

final class $$FavoriteSuppliersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FavoriteSuppliersTable,
          FavoriteSupplierRow
        > {
  $$FavoriteSuppliersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FavoritesTable _favoriteIdTable(_$AppDatabase db) => db.favorites
      .createAlias('favorite_suppliers__favorite_id__favorites__id');

  $$FavoritesTableProcessedTableManager get favoriteId {
    final $_column = $_itemColumn<String>('favorite_id')!;

    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_favoriteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) => db.suppliers
      .createAlias('favorite_suppliers__supplier_id__suppliers__id');

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<String>('supplier_id')!;

    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FavoriteSuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteSuppliersTable> {
  $$FavoriteSuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$FavoritesTableFilterComposer get favoriteId {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favoriteId,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoriteSuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteSuppliersTable> {
  $$FavoriteSuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$FavoritesTableOrderingComposer get favoriteId {
    final $$FavoritesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favoriteId,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableOrderingComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoriteSuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteSuppliersTable> {
  $$FavoriteSuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$FavoritesTableAnnotationComposer get favoriteId {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favoriteId,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoriteSuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteSuppliersTable,
          FavoriteSupplierRow,
          $$FavoriteSuppliersTableFilterComposer,
          $$FavoriteSuppliersTableOrderingComposer,
          $$FavoriteSuppliersTableAnnotationComposer,
          $$FavoriteSuppliersTableCreateCompanionBuilder,
          $$FavoriteSuppliersTableUpdateCompanionBuilder,
          (FavoriteSupplierRow, $$FavoriteSuppliersTableReferences),
          FavoriteSupplierRow,
          PrefetchHooks Function({bool favoriteId, bool supplierId})
        > {
  $$FavoriteSuppliersTableTableManager(
    _$AppDatabase db,
    $FavoriteSuppliersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteSuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteSuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteSuppliersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> favoriteId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteSuppliersCompanion(
                favoriteId: favoriteId,
                supplierId: supplierId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String favoriteId,
                required String supplierId,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteSuppliersCompanion.insert(
                favoriteId: favoriteId,
                supplierId: supplierId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FavoriteSuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({favoriteId = false, supplierId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (favoriteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.favoriteId,
                                referencedTable:
                                    $$FavoriteSuppliersTableReferences
                                        ._favoriteIdTable(db),
                                referencedColumn:
                                    $$FavoriteSuppliersTableReferences
                                        ._favoriteIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (supplierId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.supplierId,
                                referencedTable:
                                    $$FavoriteSuppliersTableReferences
                                        ._supplierIdTable(db),
                                referencedColumn:
                                    $$FavoriteSuppliersTableReferences
                                        ._supplierIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FavoriteSuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteSuppliersTable,
      FavoriteSupplierRow,
      $$FavoriteSuppliersTableFilterComposer,
      $$FavoriteSuppliersTableOrderingComposer,
      $$FavoriteSuppliersTableAnnotationComposer,
      $$FavoriteSuppliersTableCreateCompanionBuilder,
      $$FavoriteSuppliersTableUpdateCompanionBuilder,
      (FavoriteSupplierRow, $$FavoriteSuppliersTableReferences),
      FavoriteSupplierRow,
      PrefetchHooks Function({bool favoriteId, bool supplierId})
    >;
typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      required String id,
      Value<int> maxPagesToOpen,
      Value<bool> requireConfirmation,
      Value<bool> historyEnabled,
      Value<int> demoSeedVersion,
      Value<int> rowid,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<String> id,
      Value<int> maxPagesToOpen,
      Value<bool> requireConfirmation,
      Value<bool> historyEnabled,
      Value<int> demoSeedVersion,
      Value<int> rowid,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxPagesToOpen => $composableBuilder(
    column: $table.maxPagesToOpen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requireConfirmation => $composableBuilder(
    column: $table.requireConfirmation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get historyEnabled => $composableBuilder(
    column: $table.historyEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get demoSeedVersion => $composableBuilder(
    column: $table.demoSeedVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxPagesToOpen => $composableBuilder(
    column: $table.maxPagesToOpen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requireConfirmation => $composableBuilder(
    column: $table.requireConfirmation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get historyEnabled => $composableBuilder(
    column: $table.historyEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get demoSeedVersion => $composableBuilder(
    column: $table.demoSeedVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get maxPagesToOpen => $composableBuilder(
    column: $table.maxPagesToOpen,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requireConfirmation => $composableBuilder(
    column: $table.requireConfirmation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get historyEnabled => $composableBuilder(
    column: $table.historyEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get demoSeedVersion => $composableBuilder(
    column: $table.demoSeedVersion,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsRow,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            AppSettingsRow,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTableTable,
              AppSettingsRow
            >,
          ),
          AppSettingsRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> maxPagesToOpen = const Value.absent(),
                Value<bool> requireConfirmation = const Value.absent(),
                Value<bool> historyEnabled = const Value.absent(),
                Value<int> demoSeedVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion(
                id: id,
                maxPagesToOpen: maxPagesToOpen,
                requireConfirmation: requireConfirmation,
                historyEnabled: historyEnabled,
                demoSeedVersion: demoSeedVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> maxPagesToOpen = const Value.absent(),
                Value<bool> requireConfirmation = const Value.absent(),
                Value<bool> historyEnabled = const Value.absent(),
                Value<int> demoSeedVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsTableCompanion.insert(
                id: id,
                maxPagesToOpen: maxPagesToOpen,
                requireConfirmation: requireConfirmation,
                historyEnabled: historyEnabled,
                demoSeedVersion: demoSeedVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      AppSettingsRow,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        AppSettingsRow,
        BaseReferences<_$AppDatabase, $AppSettingsTableTable, AppSettingsRow>,
      ),
      AppSettingsRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DeviceTypesTableTableManager get deviceTypes =>
      $$DeviceTypesTableTableManager(_db, _db.deviceTypes);
  $$BrandsTableTableManager get brands =>
      $$BrandsTableTableManager(_db, _db.brands);
  $$DeviceModelsTableTableManager get deviceModels =>
      $$DeviceModelsTableTableManager(_db, _db.deviceModels);
  $$ComponentsTableTableManager get components =>
      $$ComponentsTableTableManager(_db, _db.components);
  $$DeviceTypeComponentsTableTableManager get deviceTypeComponents =>
      $$DeviceTypeComponentsTableTableManager(_db, _db.deviceTypeComponents);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$SupplierDeviceTypesTableTableManager get supplierDeviceTypes =>
      $$SupplierDeviceTypesTableTableManager(_db, _db.supplierDeviceTypes);
  $$SearchHistoryEntriesTableTableManager get searchHistoryEntries =>
      $$SearchHistoryEntriesTableTableManager(_db, _db.searchHistoryEntries);
  $$SearchHistorySuppliersTableTableManager get searchHistorySuppliers =>
      $$SearchHistorySuppliersTableTableManager(
        _db,
        _db.searchHistorySuppliers,
      );
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$FavoriteSuppliersTableTableManager get favoriteSuppliers =>
      $$FavoriteSuppliersTableTableManager(_db, _db.favoriteSuppliers);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
}
