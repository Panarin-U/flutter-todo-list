




import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/todolist/bloc/event.dart';
import 'package:todolist/todolist/bloc/state.dart';
import 'package:todolist/todolist/model/todolist_model.dart';

class TodoListBloc extends Bloc<TodoListBlocEvent, TodoListBlocState> {

  static const ID_DIGIT = 5;

  TodoListBloc() : super(TodoListBlocState(todoList: [])) {
    on<AddTodoList>((event, emit) => onAdd(event, emit));
    on<RemoveTodoList>((event, emit) => onRemove(event, emit));
    on<UpdateTodoList>((event, emit) => onUpdate(event, emit));
  }


  void onAdd(AddTodoList event, Emitter<TodoListBlocState> emit) {
    print(event);
    String id = _RandomString().getRandomString(ID_DIGIT);
    TodoListModel model = TodoListModel(id: id, text: event.payload);
    state.addTodoList(model);
    emit(state.copyWith());
  }

  void onRemove(RemoveTodoList event, Emitter<TodoListBlocState> emit) {
    int id = state.todoList.indexWhere((element) => element.id == event.id);
    state.removeTodoList(id);
    emit(state);
  }

  void onUpdate(UpdateTodoList event, Emitter<TodoListBlocState> emit) {
    int id = state.todoList.indexWhere((element) => element.id == event.id);
    TodoListModel model = TodoListModel(id: event.id, text: event.text);
    state.updateTodoList(model, id);
    emit(state);
  }

}


class _RandomString {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}