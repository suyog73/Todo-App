// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String id;
  bool? isDone;
  bool? isDeleted;

  Task(
      {required this.title,
      required this.description,
      required this.id,
      this.isDone,
      this.isDeleted}) {
    isDone ??= false;
    isDeleted ??= false;
  }

  Task copyWith(
      {String? title,
      String? description,
      String? id,
      bool? isDone,
      bool? isDeleted}) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "id": id,
      "isDone": isDone,
      "isDeleted": isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> mp) {
    return Task(
      title: mp["title"],
      description: mp["description"],
      id: mp["id"],
      isDone: mp["isDone"],
      isDeleted: mp["isDeleted"],
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        id,
        isDone,
        isDeleted,
      ];
}
