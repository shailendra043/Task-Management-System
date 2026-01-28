// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreateTaskDto _$CreateTaskDtoFromJson(Map<String, dynamic> json) {
  return _CreateTaskDto.fromJson(json);
}

/// @nodoc
mixin _$CreateTaskDto {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this CreateTaskDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateTaskDtoCopyWith<CreateTaskDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTaskDtoCopyWith<$Res> {
  factory $CreateTaskDtoCopyWith(
    CreateTaskDto value,
    $Res Function(CreateTaskDto) then,
  ) = _$CreateTaskDtoCopyWithImpl<$Res, CreateTaskDto>;
  @useResult
  $Res call({String title, String description});
}

/// @nodoc
class _$CreateTaskDtoCopyWithImpl<$Res, $Val extends CreateTaskDto>
    implements $CreateTaskDtoCopyWith<$Res> {
  _$CreateTaskDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? description = null}) {
    return _then(
      _value.copyWith(
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateTaskDtoImplCopyWith<$Res>
    implements $CreateTaskDtoCopyWith<$Res> {
  factory _$$CreateTaskDtoImplCopyWith(
    _$CreateTaskDtoImpl value,
    $Res Function(_$CreateTaskDtoImpl) then,
  ) = __$$CreateTaskDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String description});
}

/// @nodoc
class __$$CreateTaskDtoImplCopyWithImpl<$Res>
    extends _$CreateTaskDtoCopyWithImpl<$Res, _$CreateTaskDtoImpl>
    implements _$$CreateTaskDtoImplCopyWith<$Res> {
  __$$CreateTaskDtoImplCopyWithImpl(
    _$CreateTaskDtoImpl _value,
    $Res Function(_$CreateTaskDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? description = null}) {
    return _then(
      _$CreateTaskDtoImpl(
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTaskDtoImpl implements _CreateTaskDto {
  const _$CreateTaskDtoImpl({required this.title, required this.description});

  factory _$CreateTaskDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTaskDtoImplFromJson(json);

  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'CreateTaskDto(title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTaskDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, description);

  /// Create a copy of CreateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTaskDtoImplCopyWith<_$CreateTaskDtoImpl> get copyWith =>
      __$$CreateTaskDtoImplCopyWithImpl<_$CreateTaskDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTaskDtoImplToJson(this);
  }
}

abstract class _CreateTaskDto implements CreateTaskDto {
  const factory _CreateTaskDto({
    required final String title,
    required final String description,
  }) = _$CreateTaskDtoImpl;

  factory _CreateTaskDto.fromJson(Map<String, dynamic> json) =
      _$CreateTaskDtoImpl.fromJson;

  @override
  String get title;
  @override
  String get description;

  /// Create a copy of CreateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateTaskDtoImplCopyWith<_$CreateTaskDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateTaskDto _$UpdateTaskDtoFromJson(Map<String, dynamic> json) {
  return _UpdateTaskDto.fromJson(json);
}

/// @nodoc
mixin _$UpdateTaskDto {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool? get isCompleted => throw _privateConstructorUsedError;

  /// Serializes this UpdateTaskDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateTaskDtoCopyWith<UpdateTaskDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateTaskDtoCopyWith<$Res> {
  factory $UpdateTaskDtoCopyWith(
    UpdateTaskDto value,
    $Res Function(UpdateTaskDto) then,
  ) = _$UpdateTaskDtoCopyWithImpl<$Res, UpdateTaskDto>;
  @useResult
  $Res call({String? title, String? description, bool? isCompleted});
}

/// @nodoc
class _$UpdateTaskDtoCopyWithImpl<$Res, $Val extends UpdateTaskDto>
    implements $UpdateTaskDtoCopyWith<$Res> {
  _$UpdateTaskDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(
      _value.copyWith(
            title:
                freezed == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String?,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            isCompleted:
                freezed == isCompleted
                    ? _value.isCompleted
                    : isCompleted // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateTaskDtoImplCopyWith<$Res>
    implements $UpdateTaskDtoCopyWith<$Res> {
  factory _$$UpdateTaskDtoImplCopyWith(
    _$UpdateTaskDtoImpl value,
    $Res Function(_$UpdateTaskDtoImpl) then,
  ) = __$$UpdateTaskDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? description, bool? isCompleted});
}

/// @nodoc
class __$$UpdateTaskDtoImplCopyWithImpl<$Res>
    extends _$UpdateTaskDtoCopyWithImpl<$Res, _$UpdateTaskDtoImpl>
    implements _$$UpdateTaskDtoImplCopyWith<$Res> {
  __$$UpdateTaskDtoImplCopyWithImpl(
    _$UpdateTaskDtoImpl _value,
    $Res Function(_$UpdateTaskDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(
      _$UpdateTaskDtoImpl(
        title:
            freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String?,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        isCompleted:
            freezed == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateTaskDtoImpl implements _UpdateTaskDto {
  const _$UpdateTaskDtoImpl({this.title, this.description, this.isCompleted});

  factory _$UpdateTaskDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateTaskDtoImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final bool? isCompleted;

  @override
  String toString() {
    return 'UpdateTaskDto(title: $title, description: $description, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTaskDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, isCompleted);

  /// Create a copy of UpdateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTaskDtoImplCopyWith<_$UpdateTaskDtoImpl> get copyWith =>
      __$$UpdateTaskDtoImplCopyWithImpl<_$UpdateTaskDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateTaskDtoImplToJson(this);
  }
}

abstract class _UpdateTaskDto implements UpdateTaskDto {
  const factory _UpdateTaskDto({
    final String? title,
    final String? description,
    final bool? isCompleted,
  }) = _$UpdateTaskDtoImpl;

  factory _UpdateTaskDto.fromJson(Map<String, dynamic> json) =
      _$UpdateTaskDtoImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  bool? get isCompleted;

  /// Create a copy of UpdateTaskDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTaskDtoImplCopyWith<_$UpdateTaskDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskResponseDto _$TaskResponseDtoFromJson(Map<String, dynamic> json) {
  return _TaskResponseDto.fromJson(json);
}

/// @nodoc
mixin _$TaskResponseDto {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TaskResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskResponseDtoCopyWith<TaskResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskResponseDtoCopyWith<$Res> {
  factory $TaskResponseDtoCopyWith(
    TaskResponseDto value,
    $Res Function(TaskResponseDto) then,
  ) = _$TaskResponseDtoCopyWithImpl<$Res, TaskResponseDto>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    bool isCompleted,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$TaskResponseDtoCopyWithImpl<$Res, $Val extends TaskResponseDto>
    implements $TaskResponseDtoCopyWith<$Res> {
  _$TaskResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            isCompleted:
                null == isCompleted
                    ? _value.isCompleted
                    : isCompleted // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskResponseDtoImplCopyWith<$Res>
    implements $TaskResponseDtoCopyWith<$Res> {
  factory _$$TaskResponseDtoImplCopyWith(
    _$TaskResponseDtoImpl value,
    $Res Function(_$TaskResponseDtoImpl) then,
  ) = __$$TaskResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    bool isCompleted,
    DateTime createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$TaskResponseDtoImplCopyWithImpl<$Res>
    extends _$TaskResponseDtoCopyWithImpl<$Res, _$TaskResponseDtoImpl>
    implements _$$TaskResponseDtoImplCopyWith<$Res> {
  __$$TaskResponseDtoImplCopyWithImpl(
    _$TaskResponseDtoImpl _value,
    $Res Function(_$TaskResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? isCompleted = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$TaskResponseDtoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        isCompleted:
            null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskResponseDtoImpl implements _TaskResponseDto {
  const _$TaskResponseDtoImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    this.updatedAt,
  });

  factory _$TaskResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskResponseDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final bool isCompleted;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TaskResponseDto(id: $id, title: $title, description: $description, isCompleted: $isCompleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskResponseDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    isCompleted,
    createdAt,
    updatedAt,
  );

  /// Create a copy of TaskResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskResponseDtoImplCopyWith<_$TaskResponseDtoImpl> get copyWith =>
      __$$TaskResponseDtoImplCopyWithImpl<_$TaskResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskResponseDtoImplToJson(this);
  }
}

abstract class _TaskResponseDto implements TaskResponseDto {
  const factory _TaskResponseDto({
    required final String id,
    required final String title,
    required final String description,
    required final bool isCompleted,
    required final DateTime createdAt,
    final DateTime? updatedAt,
  }) = _$TaskResponseDtoImpl;

  factory _TaskResponseDto.fromJson(Map<String, dynamic> json) =
      _$TaskResponseDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  bool get isCompleted;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of TaskResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskResponseDtoImplCopyWith<_$TaskResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
