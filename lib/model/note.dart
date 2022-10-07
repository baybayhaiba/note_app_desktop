import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
enum NoteType { Link, Normal }

class Note extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final int? color;
  final int? time;

  final NoteType? noteType;

  const Note(
      {this.id,
      this.title,
      this.description,
      this.color = -16777216,
      this.time,
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
      'timeAgo': time,
      'noteType': noteType?.name
    };
  }

  factory Note.fromMap(Map map) {
    return Note(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      color: map['color'] != null ? map['color'] as int : null,
      time: map['timeAgo'] != null ? map['timeAgo'] as int : null,
      noteType: map['noteType'] != null
          ? NoteType.values.firstWhere((element) => element.name == map['noteType'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [id];

  Note copyWith({
    int? id,
    String? title,
    String? description,
    int? color,
    int? timeAgo,
    NoteType? noteType,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      time: timeAgo ?? this.time,
      noteType: noteType ?? this.noteType,
    );
  }
}
