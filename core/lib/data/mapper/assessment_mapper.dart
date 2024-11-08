import 'package:core/core.dart';
import 'package:core/utils/app_logger.dart';

class AssessmentMapper {
  static Assessment fromJson(
      Map<String, dynamic> json, List<AssessmentDetail> details) {
    logger.logInfo('Mapping Assessment from JSON');

    try {
      return Assessment(
        id: json['\$id'] as String,
        assessor: json['assessor'] as String,
        employee:
            EmployeeMapper.fromJson(json['employee'] as Map<String, dynamic>),
        details: details, // Menggunakan details yang sudah di-fetch
      );
    } catch (e) {
      logger.logError('Error mapping Assessment: ${e.toString()}');
      rethrow;
    }
  }

  static Map<String, dynamic> toJson(Assessment assessment) {
    return {
      'assessor': assessment.assessor,
      'employee': assessment.employee.id,
    };
  }
}
