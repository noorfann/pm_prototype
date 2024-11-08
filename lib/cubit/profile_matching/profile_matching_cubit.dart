import 'package:core/common/enums.dart';
import 'package:core/core.dart';
import 'package:core/utils/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pm_prototype/cubit/profile_matching/profile_matching_state.dart';

class ProfileMatchingCubit extends Cubit<ProfileMatchingState> {
  final AssessmentRepository _assessmentRepository;

  ProfileMatchingCubit(this._assessmentRepository)
      : super(ProfileMatchingInitial());

  Future<void> calculateProfileMatching({
    required String taskTitle,
    required String roleId,
    required List<CriteriaDetailForm> targetValues,
    required List<Criteria> criteria,
  }) async {
    try {
      emit(ProfileMatchingLoading());
      logger.logInfo(
          'Starting Profile Matching calculation for task: $taskTitle');

      // Fetch assessments using repository
      logger.logInfo('Fetching assessments data...');
      final assessmentsResult = await _assessmentRepository.getAssessment();

      assessmentsResult.fold(
        (error) {
          logger.logError('Failed to fetch assessments: $error');
          emit(ProfileMatchingError(error));
        },
        (assessments) {
          logger.logInfo(
              'Successfully fetched ${assessments.length} assessments');

          // Filter assessments by role
          final filteredAssessments = assessments
              .where((assessment) => assessment.employee.role?.id == roleId)
              .toList();

          logger.logInfo(
              'Filtered ${filteredAssessments.length} assessments for role: $roleId');

          List<EmployeeResult> results = [];

          for (var assessment in filteredAssessments) {
            logger.logInfo(
                'Processing assessment for employee: ${assessment.employee.name}');

            // 1. Calculate Gap for each criteria
            Map<String, double> gaps = {};
            Map<String, double> weightedGaps = {};

            for (var targetValue in targetValues) {
              // Find matching assessment detail for criteria
              var assessmentDetail = assessment.details.firstWhere(
                (detail) => detail.criteria.id == targetValue.criteria.id,
                orElse: () {
                  logger.logWarning(
                      'No assessment detail found for criteria: ${targetValue.criteria.name}, using default value');
                  return AssessmentDetail(
                    id: '',
                    score: 0,
                    criteria: targetValue.criteria,
                    assesmentId: assessment.id,
                  );
                },
              );

              // Calculate gap
              double gap =
                  assessmentDetail.score - (targetValue.weight?.value ?? 0);
              gaps[targetValue.criteria.id] = gap;

              logger.logInfo('Criteria: ${targetValue.criteria.name}, '
                  'Employee Score: ${assessmentDetail.score}, '
                  'Target Score: ${targetValue.weight?.value}, '
                  'Gap: $gap');

              // Convert gap to weight
              double weight = convertGapToWeight(gap);
              weightedGaps[targetValue.criteria.id] = weight;

              logger.logInfo(
                  'Converted gap $gap to weight: $weight for criteria: ${targetValue.criteria.name}');
            }

            // 2. Calculate Core Factor
            double coreFactor = calculateCoreFactor(weightedGaps, criteria);
            logger.logInfo('Core Factor calculation result: $coreFactor');

            // 3. Calculate Secondary Factor
            double secondaryFactor =
                calculateSecondaryFactor(weightedGaps, criteria);
            logger.logInfo(
                'Secondary Factor calculation result: $secondaryFactor');

            // 4. Calculate Total Score
            double totalScore = (0.6 * coreFactor) + (0.4 * secondaryFactor);
            logger.logInfo(
                'Total Score for ${assessment.employee.name}: $totalScore '
                '(CF: $coreFactor, SF: $secondaryFactor)');

            results.add(EmployeeResult(
              employee: assessment.employee,
              totalScore: totalScore,
              gapValues: gaps,
              coreFactor: coreFactor,
              secondaryFactor: secondaryFactor,
            ));
          }

          // Sort results by total score
          results.sort((a, b) => b.totalScore.compareTo(a.totalScore));

          logger.logInfo(
              'Profile Matching calculation completed. Results sorted by total score:');
          for (var i = 0; i < results.length; i++) {
            logger.logInfo('Rank ${i + 1}: ${results[i].employee.name} - '
                'Score: ${results[i].totalScore.toStringAsFixed(2)}');
          }

          emit(ProfileMatchingSuccess(results));
        },
      );
    } catch (e) {
      logger.logError('Error in Profile Matching calculation: ${e.toString()}');
      emit(ProfileMatchingError(e.toString()));
    }
  }

  double convertGapToWeight(double gap) {
    logger.logInfo('Converting gap: $gap to weight');
    double weight;
    switch (gap.toInt()) {
      case 0:
        weight = 5.0;
        break;
      case 1:
        weight = 4.5;
        break;
      case -1:
        weight = 4.0;
        break;
      case 2:
        weight = 3.5;
        break;
      case -2:
        weight = 3.0;
        break;
      case 3:
        weight = 2.5;
        break;
      case -3:
        weight = 2.0;
        break;
      case 4:
        weight = 1.5;
        break;
      case -4:
        weight = 1.0;
        break;
      default:
        weight = 0.0;
    }
    logger.logInfo('Gap $gap converted to weight: $weight');
    return weight;
  }

  double calculateCoreFactor(
      Map<String, double> weightedGaps, List<Criteria> criteria) {
    logger.logInfo('Calculating Core Factor');
    var coreFactors =
        criteria.where((c) => c.criteriaType == CriteriaType.coreFactor);
    if (coreFactors.isEmpty) {
      logger.logWarning('No core factors found in criteria');
      return 0;
    }

    double sum = 0;
    for (var criterion in coreFactors) {
      double value = weightedGaps[criterion.id] ?? 0;
      sum += value;
      logger.logInfo('Core Factor - ${criterion.name}: $value');
    }

    double result = sum / coreFactors.length;
    logger.logInfo('Core Factor final result: $result');
    return result;
  }

  double calculateSecondaryFactor(
      Map<String, double> weightedGaps, List<Criteria> criteria) {
    logger.logInfo('Calculating Secondary Factor');
    var secondaryFactors =
        criteria.where((c) => c.criteriaType == CriteriaType.secondaryFactor);
    if (secondaryFactors.isEmpty) {
      logger.logWarning('No secondary factors found in criteria');
      return 0;
    }

    double sum = 0;
    for (var criterion in secondaryFactors) {
      double value = weightedGaps[criterion.id] ?? 0;
      sum += value;
      logger.logInfo('Secondary Factor - ${criterion.name}: $value');
    }

    double result = sum / secondaryFactors.length;
    logger.logInfo('Secondary Factor final result: $result');
    return result;
  }
}
