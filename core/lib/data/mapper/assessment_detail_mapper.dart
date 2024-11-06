import 'package:core/core.dart';
import 'package:core/utils/app_logger.dart';

class AssessmentDetailMapper {
  static AssessmentDetail fromJson(Map<String, dynamic> json) {
    logger.logInfo("assesment detail ${json.toString()}");
    return AssessmentDetail(
      id: json['\$id'] as String,
      score: json['score'] as double,
      assesmentId:
          AssessmentMapper.fromJson(json['assessment'] as Map<String, dynamic>)
              .id,
      criteria:
          CriteriaMapper.fromJson(json['criteria'] as Map<String, dynamic>),
    );
  }

  static Map<String, dynamic> toJson(AssessmentDetail entity) => {
        'score': entity.score,
        'assessment': entity.assesmentId,
        'criteria': entity.criteria.id,
      };
}
