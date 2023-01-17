// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String id;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;

  Task({
    required this.title,
    required this.description,
    required this.id,
    required this.date,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone ??= false;
    isDeleted ??= false;
    isFavorite ??= false;
  }

  Task copyWith({
    String? title,
    String? description,
    String? id,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "id": id,
      "date": date,
      "isDone": isDone,
      "isDeleted": isDeleted,
      "isFavorite": isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> mp) {
    return Task(
      title: mp["title"],
      description: mp["description"],
      id: mp["id"],
      date: mp["date"],
      isDone: mp["isDone"],
      isDeleted: mp["isDeleted"],
      isFavorite: mp["isFavorite"],
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        id,
        date,
        isDone,
        isDeleted,
        isFavorite,
      ];
}
