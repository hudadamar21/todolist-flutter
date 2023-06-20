import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  DateTime date;
  bool isCompleted;

  Todo(this.id, this.title, this.date, this.isCompleted);
}

class TodoController extends GetxController {
  String inputValue = "";

  RxBool isEditMode = false.obs;
  RxString editedTodoId = ''.obs;

  RxList<Todo> todos = [
    Todo('1', 'Todo 1', DateTime.now(), false),
    Todo('2', 'Todo 2', DateTime.now(), false),
    Todo('3', 'Todo 3', DateTime.now(), false),
    Todo('4', 'Todo 4', DateTime.now(), false),
    Todo('5', 'Todo 5', DateTime.now(), false),
  ].obs;

  get notCompletedTodo =>
      todos.where((todo) => todo.isCompleted == false).toList();
  get completedTodo => todos.where((todo) => todo.isCompleted == true).toList();

  void addNewTodo(Todo todo) {
    todos.add(todo);
  }

  void editTodo(String id) {}

  void removeTodo(todoId) {
    todos.removeWhere((todo) => todo.id == todoId);
  }

  void updateTodo(newTodo) {
    final index = todos.indexWhere((todo) => todo.id == editedTodoId.value);
    todos[index] = newTodo;
    todos.refresh();
    editedTodoId.update((val) {
      val = '';
    });
    isEditMode.update((val) {
      val = false;
    });
  }

  void updateIsDoneTodo(todoId) {
    final index = todos.indexWhere((todo) => todo.id == todoId);
    todos[index].isCompleted = !todos[index].isCompleted;
    todos.refresh();
  }
}
