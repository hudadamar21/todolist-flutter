import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class Todo {
  Uuid id;
  String title;
  DateTime date;
  bool isDone;

  Todo(this.id, this.title, this.date, this.isDone);
}

class TodoController extends GetxController {
  List<Todo> todos = [];

  void addNewTodo(todo) {
    todos.add(todo);
  }

  void removeTodo(todo) {
    todos.removeWhere((todo) => todo.id == todo.id);
  }

  void updateIsDoneTodo(todoId, value) {
    for (var todo in todos) {
      if (todo.id == todoId) {
        todo.isDone = value;
        break;
      }
    }
  }
}
