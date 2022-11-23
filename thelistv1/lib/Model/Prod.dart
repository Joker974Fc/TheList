class Prod {
  String name;
  String description;
  bool isSelected;

  Prod(this.name, this.description, this.isSelected);

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'isSelected': isSelected};
  }

  factory Prod.fromMap(Map<String, dynamic> map) => new Prod(
        map['name'],
        map['description'],
        map['isSelected'] == 1,
      );
}
