enum Gender {
  male(0, name: 'Male'),
  female(1, name: 'Female');

  final int id;
  final String name;

  const Gender(this.id, {required this.name});
}
