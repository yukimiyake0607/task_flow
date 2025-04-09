// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'long_term_todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LongTermTodoModel _$LongTermTodoModelFromJson(Map<String, dynamic> json) {
  return _LongTermTodoModel.fromJson(json);
}

/// @nodoc
mixin _$LongTermTodoModel {
  String get id => throw _privateConstructorUsedError;
  String get todoTitle => throw _privateConstructorUsedError;
  DateTime get createdDate => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  String get successBorder => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  List<String>? get step => throw _privateConstructorUsedError;

  /// Serializes this LongTermTodoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LongTermTodoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LongTermTodoModelCopyWith<LongTermTodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LongTermTodoModelCopyWith<$Res> {
  factory $LongTermTodoModelCopyWith(
          LongTermTodoModel value, $Res Function(LongTermTodoModel) then) =
      _$LongTermTodoModelCopyWithImpl<$Res, LongTermTodoModel>;
  @useResult
  $Res call(
      {String id,
      String todoTitle,
      DateTime createdDate,
      DateTime dueDate,
      String successBorder,
      String purpose,
      List<String>? step});
}

/// @nodoc
class _$LongTermTodoModelCopyWithImpl<$Res, $Val extends LongTermTodoModel>
    implements $LongTermTodoModelCopyWith<$Res> {
  _$LongTermTodoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LongTermTodoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? todoTitle = null,
    Object? createdDate = null,
    Object? dueDate = null,
    Object? successBorder = null,
    Object? purpose = null,
    Object? step = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      todoTitle: null == todoTitle
          ? _value.todoTitle
          : todoTitle // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      successBorder: null == successBorder
          ? _value.successBorder
          : successBorder // ignore: cast_nullable_to_non_nullable
              as String,
      purpose: null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LongTermTodoModelImplCopyWith<$Res>
    implements $LongTermTodoModelCopyWith<$Res> {
  factory _$$LongTermTodoModelImplCopyWith(_$LongTermTodoModelImpl value,
          $Res Function(_$LongTermTodoModelImpl) then) =
      __$$LongTermTodoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String todoTitle,
      DateTime createdDate,
      DateTime dueDate,
      String successBorder,
      String purpose,
      List<String>? step});
}

/// @nodoc
class __$$LongTermTodoModelImplCopyWithImpl<$Res>
    extends _$LongTermTodoModelCopyWithImpl<$Res, _$LongTermTodoModelImpl>
    implements _$$LongTermTodoModelImplCopyWith<$Res> {
  __$$LongTermTodoModelImplCopyWithImpl(_$LongTermTodoModelImpl _value,
      $Res Function(_$LongTermTodoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LongTermTodoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? todoTitle = null,
    Object? createdDate = null,
    Object? dueDate = null,
    Object? successBorder = null,
    Object? purpose = null,
    Object? step = freezed,
  }) {
    return _then(_$LongTermTodoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      todoTitle: null == todoTitle
          ? _value.todoTitle
          : todoTitle // ignore: cast_nullable_to_non_nullable
              as String,
      createdDate: null == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      successBorder: null == successBorder
          ? _value.successBorder
          : successBorder // ignore: cast_nullable_to_non_nullable
              as String,
      purpose: null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      step: freezed == step
          ? _value._step
          : step // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LongTermTodoModelImpl implements _LongTermTodoModel {
  const _$LongTermTodoModelImpl(
      {required this.id,
      required this.todoTitle,
      required this.createdDate,
      required this.dueDate,
      required this.successBorder,
      required this.purpose,
      required final List<String>? step})
      : _step = step;

  factory _$LongTermTodoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LongTermTodoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String todoTitle;
  @override
  final DateTime createdDate;
  @override
  final DateTime dueDate;
  @override
  final String successBorder;
  @override
  final String purpose;
  final List<String>? _step;
  @override
  List<String>? get step {
    final value = _step;
    if (value == null) return null;
    if (_step is EqualUnmodifiableListView) return _step;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LongTermTodoModel(id: $id, todoTitle: $todoTitle, createdDate: $createdDate, dueDate: $dueDate, successBorder: $successBorder, purpose: $purpose, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LongTermTodoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.todoTitle, todoTitle) ||
                other.todoTitle == todoTitle) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.successBorder, successBorder) ||
                other.successBorder == successBorder) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            const DeepCollectionEquality().equals(other._step, _step));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      todoTitle,
      createdDate,
      dueDate,
      successBorder,
      purpose,
      const DeepCollectionEquality().hash(_step));

  /// Create a copy of LongTermTodoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LongTermTodoModelImplCopyWith<_$LongTermTodoModelImpl> get copyWith =>
      __$$LongTermTodoModelImplCopyWithImpl<_$LongTermTodoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LongTermTodoModelImplToJson(
      this,
    );
  }
}

abstract class _LongTermTodoModel implements LongTermTodoModel {
  const factory _LongTermTodoModel(
      {required final String id,
      required final String todoTitle,
      required final DateTime createdDate,
      required final DateTime dueDate,
      required final String successBorder,
      required final String purpose,
      required final List<String>? step}) = _$LongTermTodoModelImpl;

  factory _LongTermTodoModel.fromJson(Map<String, dynamic> json) =
      _$LongTermTodoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get todoTitle;
  @override
  DateTime get createdDate;
  @override
  DateTime get dueDate;
  @override
  String get successBorder;
  @override
  String get purpose;
  @override
  List<String>? get step;

  /// Create a copy of LongTermTodoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LongTermTodoModelImplCopyWith<_$LongTermTodoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
