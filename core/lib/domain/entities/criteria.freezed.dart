// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'criteria.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Criteria {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  CriteriaType get criteriaType => throw _privateConstructorUsedError;
  int? get score => throw _privateConstructorUsedError;

  /// Create a copy of Criteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CriteriaCopyWith<Criteria> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CriteriaCopyWith<$Res> {
  factory $CriteriaCopyWith(Criteria value, $Res Function(Criteria) then) =
      _$CriteriaCopyWithImpl<$Res, Criteria>;
  @useResult
  $Res call({String id, String name, CriteriaType criteriaType, int? score});
}

/// @nodoc
class _$CriteriaCopyWithImpl<$Res, $Val extends Criteria>
    implements $CriteriaCopyWith<$Res> {
  _$CriteriaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Criteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? criteriaType = null,
    Object? score = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      criteriaType: null == criteriaType
          ? _value.criteriaType
          : criteriaType // ignore: cast_nullable_to_non_nullable
              as CriteriaType,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CriteriaImplCopyWith<$Res>
    implements $CriteriaCopyWith<$Res> {
  factory _$$CriteriaImplCopyWith(
          _$CriteriaImpl value, $Res Function(_$CriteriaImpl) then) =
      __$$CriteriaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, CriteriaType criteriaType, int? score});
}

/// @nodoc
class __$$CriteriaImplCopyWithImpl<$Res>
    extends _$CriteriaCopyWithImpl<$Res, _$CriteriaImpl>
    implements _$$CriteriaImplCopyWith<$Res> {
  __$$CriteriaImplCopyWithImpl(
      _$CriteriaImpl _value, $Res Function(_$CriteriaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Criteria
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? criteriaType = null,
    Object? score = freezed,
  }) {
    return _then(_$CriteriaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      criteriaType: null == criteriaType
          ? _value.criteriaType
          : criteriaType // ignore: cast_nullable_to_non_nullable
              as CriteriaType,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CriteriaImpl implements _Criteria {
  const _$CriteriaImpl(
      {required this.id,
      required this.name,
      required this.criteriaType,
      this.score});

  @override
  final String id;
  @override
  final String name;
  @override
  final CriteriaType criteriaType;
  @override
  final int? score;

  @override
  String toString() {
    return 'Criteria(id: $id, name: $name, criteriaType: $criteriaType, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CriteriaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.criteriaType, criteriaType) ||
                other.criteriaType == criteriaType) &&
            (identical(other.score, score) || other.score == score));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, criteriaType, score);

  /// Create a copy of Criteria
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CriteriaImplCopyWith<_$CriteriaImpl> get copyWith =>
      __$$CriteriaImplCopyWithImpl<_$CriteriaImpl>(this, _$identity);
}

abstract class _Criteria implements Criteria {
  const factory _Criteria(
      {required final String id,
      required final String name,
      required final CriteriaType criteriaType,
      final int? score}) = _$CriteriaImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  CriteriaType get criteriaType;
  @override
  int? get score;

  /// Create a copy of Criteria
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CriteriaImplCopyWith<_$CriteriaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
