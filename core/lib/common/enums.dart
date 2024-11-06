enum Gender {
  male(0, name: 'Laki-laki'),
  female(1, name: 'Perempuan');

  final int id;
  final String name;

  const Gender(this.id, {required this.name});
}

enum CriteriaType {
  coreFactor(name: 'Core Factor', value: 'core_factor'),
  secondaryFactor(name: 'Secondary Factor', value: 'secondary_factor');

  final String name;
  final String value;

  const CriteriaType({required this.name, required this.value});
}
