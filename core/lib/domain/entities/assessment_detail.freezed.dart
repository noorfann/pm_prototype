// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AssessmentDetail {
  String get id => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  String get assesmentId => throw _privateConstructorUsedError;
  Criteria get criteria => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentDetailCopyWith<AssessmentDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentDetailCopyWith<$Res> {
  factory $AssessmentDetailCopyWith(
          AssessmentDetail value, $Res Function(AssessmentDetail) then) =
      _$AssessmentDetailCopyWithImpl<$Res, AssessmentDetail>;
  @useResult
  $Res call({String id, double score, String assesmentId, Criteria criteria});

  $CriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class _$AssessmentDetailCopyWithImpl<$Res, $Val extends AssessmentDetail>
    implements $AssessmentDetailCopyWith<$Res> {
  _$AssessmentDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? score = null,
    Object? assesmentId = null,
    Object? criteria = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      assesmentId: null == assesmentId
          ? _value.assesmentId
          : assesmentId // ignore: cast_nullable_to_non_nullable
              as String,
      criteria: null == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Criteria,
    ) as $Val);
  }

  /// Create a copy of AssessmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CriteriaCopyWith<$Res> get criteria {
    return $CriteriaCopyWith<$Res>(_value.criteria, (value) {
      return _then(_value.copyWith(criteria: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AssessmentDetailImplCopyWith<$Res>
    implements $AssessmentDetailCopyWith<$Res> {
  factory _$$AssessmentDetailImplCopyWith(_$AssessmentDetailImpl value,
          $Res Function(_$AssessmentDetailImpl) then) =
      __$$AssessmentDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, double score, String assesmentId, Criteria criteria});

  @override
  $CriteriaCopyWith<$Res> get criteria;
}

/// @nodoc
class __$$AssessmentDetailImplCopyWithImpl<$Res>
    extends _$AssessmentDetailCopyWithImpl<$Res, _$AssessmentDetailImpl>
    implements _$$AssessmentDetailImplCopyWith<$Res> {
  __$$AssessmentDetailImplCopyWithImpl(_$AssessmentDetailImpl _value,
      $Res Function(_$AssessmentDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AssessmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? score = null,
    Object? assesmentId = null,
    Object? criteria = null,
  }) {
    return _then(_$AssessmentDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      assesmentId: null == assesmentId
          ? _value.assesmentId
          : assesmentId // ignore: cast_nullable_to_non_nullable
              as String,
      criteria: null == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Criteria,
    ));
  }
}

/// @nodoc

class _$AssessmentDetailImpl implements _AssessmentDetail {
  const _$AssessmentDetailImpl(
      {required this.id,
      required this.score,
      required this.assesmentId,
      required this.criteria});

  @override
  final String id;
  @override
  final double score;
  @override
  final String assesmentId;
  @override
  final Criteria criteria;

  @override
  String toString() {
    return 'AssessmentDetail(id: $id, score: $score, assesmentId: $assesmentId, criteria: $criteria)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.assesmentId, assesmentId) ||
                other.assesmentId == assesmentId) &&
            (identical(other.criteria, criteria) ||
                other.criteria == criteria));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, score, assesmentId, criteria);

  /// Create a copy of AssessmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentDetailImplCopyWith<_$AssessmentDetailImpl> get copyWith =>
      __$$AssessmentDetailImplCopyWithImpl<_$AssessmentDetailImpl>(
          this, _$identity);
}

abstract class _AssessmentDetail implements AssessmentDetail {
  const factory _AssessmentDetail(
      {required final String id,
      required final double score,
      required final String assesmentId,
      required final Criteria criteria}) = _$AssessmentDetailImpl;

  @override
  String get id;
  @override
  double get score;
  @override
  String get assesmentId;
  @override
  Criteria get criteria;

  /// Create a copy of AssessmentDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentDetailImplCopyWith<_$AssessmentDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
