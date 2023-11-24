import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String title;
  final String description;
  final String id;
  bool? isDone;


  Task({
    required this.title,
    required this.description,
    required this.id,
    this.isDone,
  }){
    isDone = isDone ?? false;
  }

  Task copyWith({
    
    String? title,
    String? description,
    String? id,
    bool? isDone, 

  }){
    return Task(
      title: title ?? this.title,
      description: title ?? this.description,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'title': title,
      'description': description,
      'id':'id',
      'isDone': isDone,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map){
    return Task(

      title: map['title'] ?? '',
      description: map['description'] ?? '',
      id: map['id'] ?? '',
      isDone: map['isDone'],

    );
  }
  
  @override
  List<Object?> get props =>[
    title,
    description,
    id, 
    isDone, 
  ];

}


