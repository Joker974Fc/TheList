class Medic {
  String name;
  String description;
  bool isSelected;

  Medic(this.name, this.description, this.isSelected);

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'isSelected': isSelected};
  }

  factory Medic.fromMap(Map<String, dynamic> map) =>
      new Medic(map['name'], map['description'], map['isSelected'] == 1);
}
