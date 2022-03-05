


import 'package:equatable/equatable.dart';
import 'package:todolist/todolist/model/todolist_model.dart';

// ignore: must_be_immutable
class TodoListBlocState extends Equatable {

  List<TodoListModel> todoList;

  TodoListBlocState({ this.todoList });

  void addTodoList(TodoListModel item) {
    todoList.add(item);
  }

  void updateTodoList(TodoListModel item, int index) {
    todoList[index] = item;
  }

  void removeTodoList(int index) {
    todoList.removeAt(index);
  }

  TodoListBlocState copyWith() => TodoListBlocState(todoList: todoList);

  @override
  List<Object> get props => [todoList];

}

