import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:todo_app1/getx/todo.dart';

Widget todoList({required List<Todo> todos}) {
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  final TodoController todoController = Get.put(TodoController());
  return ListView.builder(
    itemCount: todos.length,
    itemBuilder: (context, index) {
      return ListTile(
        contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todos[index].title),
            Text(
              formatter.format(
                todos[index].date,
              ),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: Wrap(
          spacing: 12,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                todoController.editedTodoId.value = todos[index].id;
                todoController.inputValue = todos[index].title;
                todoController.isEditMode.value =
                    !todoController.isEditMode.value;
                print(todoController.editedTodoId);
                print(todoController.isEditMode.value);
              },
              icon: Icon(
                Icons.edit,
                color: todoController.isEditMode.value &&
                        todoController.editedTodoId.value == todos[index].id
                    ? Colors.orange
                    : Colors.grey.shade700,
              ),
            ),
            IconButton(
              onPressed: () {
                todoController.removeTodo(todos[index].id);
              },
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                todoController.updateIsDoneTodo(todos[index].id);
              },
              icon: Icon(
                todos[index].isCompleted ? Icons.check_circle : Icons.done,
                color: todos[index].isCompleted
                    ? Colors.green
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    },
  );
}
