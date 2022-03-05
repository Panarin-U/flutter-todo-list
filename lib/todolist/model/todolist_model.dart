



import 'package:equatable/equatable.dart';

class TodoListModel extends Equatable {
  final String id;
  final String text;

  TodoListModel({ this.text, this.id });

  @override
  // TODO: implement props
  List<Object> get props => [id, text];

}