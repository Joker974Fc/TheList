final String tableProd = 'prods';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, name, description, isSelected
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String description = 'description';
  static final String isSelected = 'isSelected';
}

class Note {
  final int? id;
  final String name;
  final String description;
  final bool isSelected;

  const Note({
    this.id,
    required this.name,
    required this.description,
    required this.isSelected,
  });

  Note copy({
    int? id,
    String? name,
    String? description,
    bool? isSelected,
  }) =>
      Note(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        isSelected: isSelected ?? this.isSelected,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        name: json[NoteFields.name] as String,
        description: json[NoteFields.description] as String,
        isSelected: json[NoteFields.isSelected] == 0,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.name: name,
        NoteFields.description: description,
        NoteFields.isSelected: isSelected ? 1 : 0,
      };
}
