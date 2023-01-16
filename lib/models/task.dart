import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  bool? isDone;
  bool? isDeleted;

  Task({required this.title, this.isDone, this.isDeleted}) {
    isDone ??= false;
    isDeleted ??= false;
  }

  Task copyWith({String? title, bool? isDone, bool? isDeleted}) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "isDone": isDone,
      "isDeleted": isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> mp) {
    return Task(
      title: mp["title"],
      isDone: mp["isDone"],
      isDeleted: mp["isDeleted"],
    );
  }

  @override
  List<Object?> get props => [
        title,
        isDone,
        isDeleted,
      ];
}
