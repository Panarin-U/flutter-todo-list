


abstract class TodoListBlocEvent {}


class AddTodoList extends TodoListBlocEvent {
  final String payload;
  AddTodoList({ this.payload });
}

class RemoveTodoList extends TodoListBlocEvent {
  final String id;
  RemoveTodoList({ this.id });
}

class UpdateTodoList extends TodoListBlocEvent {
  final String text;
  final String id;
  UpdateTodoList({ this.id, this.text });
}
