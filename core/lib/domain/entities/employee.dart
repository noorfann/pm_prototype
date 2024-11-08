import 'package:core/common/enums.dart';
import 'package:core/domain/entities/role.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'employee.freezed.dart';

@freezed
class Employee with _$Employee {
  const factory Employee(
      {required String id,
      required String name,
      required String email,
      required Gender gender,
      Role? role}) = _Employee;
}
