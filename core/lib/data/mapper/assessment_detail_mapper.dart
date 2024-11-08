import 'package:core/common/enums.dart';
import 'package:core/core.dart';
import 'package:core/utils/app_logger.dart';

class AssessmentDetailMapper {
  static AssessmentDetail fromJson(Map<String, dynamic> json) {
    logger.logInfo('Mapping AssessmentDetail from JSON: $json');

    try {
      // Periksa struktur JSON yang diterima
      logger.logInfo('ID: ${json['\$id']}');
      logger.logInfo('Score: ${json['score']}');
      logger.logInfo('Criteria: ${json['criteria']}');
      logger.logInfo('Assessment: ${json['assessment']}');

      return AssessmentDetail(
        id: json['\$id'] as String,
        score: (json['score'] as num).toDouble(),
        // Jika criteria adalah map/object langsung
        criteria: json['criteria'] is Map
            ? CriteriaMapper.fromJson(json['criteria'] as Map<String, dynamic>)
            // Jika criteria adalah reference ID
            : Criteria(
                id: json['criteria'].toString(),
                name: '', // Isi dengan default atau fetch data criteria
                criteriaType: CriteriaType.coreFactor, // Sesuaikan default
              ),
        assesmentId: json['assessment'] is Map
            ? json['assessment']['\$id'] as String
            : json['assessment'] as String,
      );
    } catch (e) {
      logger.logError('Error mapping AssessmentDetail: ${e.toString()}');
      logger.logError('JSON data: $json');
      rethrow;
    }
  }

  static Map<String, dynamic> toJson(AssessmentDetail detail) {
    return {
      'score': detail.score,
      'criteria': detail.criteria.id,
      'assessment': detail.assesmentId,
    };
  }
}
