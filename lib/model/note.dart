import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum NoteType { Link, Normal }

class Note {
  int? id;
  String? title;
  String? description;
  int? color;
  int? timeAgo;

  NoteType? noteType;

  Note(
      {this.id,
      this.title,
      this.description,
      this.color,
      this.timeAgo,
      this.noteType = NoteType.Normal});

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, color: $color)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'timeAgo': timeAgo,
      'noteType': noteType?.name
    };
  }

  factory Note.fromMap(Map map) {
    return Note(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      color: map['color'] != null ? map['color'] as int : null,
      timeAgo: map['timeAgo'] != null ? map['timeAgo'] as int : null,
      noteType: map['noteType'] != null
          ? NoteType.values
              .firstWhere((element) => element.name == map['noteType'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);
}
