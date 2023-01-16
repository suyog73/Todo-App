// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String id;
  bool? isDone;
  bool? isDeleted;

  Task({required this.title, required this.id, this.isDone, this.isDeleted}) {
    isDone ??= false;
    isDeleted ??= false;
  }

  Task copyWith({String? title, String? id, bool? isDone, bool? isDeleted}) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "id": id,
      "isDone": isDone,
      "isDeleted": isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> mp) {
    return Task(
      title: mp["title"],
      id: mp["id"],
      isDone: mp["isDone"],
      isDeleted: mp["isDeleted"],
    );
  }

  @override
  List<Object?> get props => [
        title,
        id,
        isDone,
        isDeleted,
      ];
}
