import 'package:core/common/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'criteria.freezed.dart';

@freezed
class Criteria with _$Criteria {
  const factory Criteria(
      {required String id,
      required String name,
      required CriteriaType criteriaType,
      int? score}) = _Criteria;
}
