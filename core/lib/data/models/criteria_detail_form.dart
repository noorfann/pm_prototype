import 'package:core/core.dart';

// this class is use for the criteria weight
class Weight {
  final String name;
  final double value;
  Weight(this.name, this.value);
}

class CriteriaDetailForm {
  Criteria criteria;
  Weight? weight;

  CriteriaDetailForm(this.criteria, this.weight);
}
