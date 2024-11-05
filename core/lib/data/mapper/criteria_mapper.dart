import 'package:core/common/enums.dart';
import 'package:core/domain/entities/criteria.dart';
import 'package:core/utils/app_logger.dart';

class CriteriaMapper {
  static Criteria fromJson(Map<String, dynamic> json) {
    logger.logInfo(json.toString());
    return Criteria(
      id: json['\$id'] as String,
      name: json['name'] as String,
      criteriaType: (json['type'] == 'core_factor')
          ? CriteriaType.coreFactor
          : CriteriaType.secondaryFactor,
    );
  }

  static Map<String, dynamic> toJson(Criteria criteria) {
    return {
      'name': criteria.name,
      'type': (criteria.criteriaType.value == 'core_factor')
          ? CriteriaType.coreFactor.value
          : CriteriaType.secondaryFactor.value
    };
  }
}
