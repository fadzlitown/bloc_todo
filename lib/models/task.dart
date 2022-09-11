import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String desc;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFav;

  Task({
    required this.id,
    required this.title,
    required this.desc,
    required this.date,
    this.isDone,
    this.isDeleted,
    this.isFav,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFav = isFav ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    String? desc,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFav,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFav: isFav ?? this.isFav,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFav': isFav,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      desc: map['desc'] as String,
      date: map['date'] as String,
      isDone: map['isDone'] as bool,
      isDeleted: map['isDeleted'] as bool,
      isFav: map['isFav'] as bool,
    );
  }

  //todo Object to dynamic
  @override
  List<dynamic> get props => [id, title, desc, date, isDone, isDeleted, isFav];
}
