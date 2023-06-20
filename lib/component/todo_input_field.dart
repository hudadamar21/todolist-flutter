import 'package:flutter/material.dart';
import 'package:todo_app1/getx/todo.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class TodoInputField extends StatelessWidget {
  TodoInputField({
    super.key,
    required this.todoController,
    required this.editTodoId,
    required this.isEditMode,
    required this.onAfterUpdate,
  });

  final TodoController todoController;
  String? editTodoId;
  bool isEditMode;
  final VoidCallback onAfterUpdate;
  static const uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                todoController.inputValue = value;
              },
              controller:
                  TextEditingController(text: todoController.inputValue),
              decoration: const InputDecoration(
                labelText: 'Enter your to do',
                hintText: 'your todo..',
                prefixIcon: Icon(Icons.today_rounded),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              if (todoController.inputValue.isNotEmpty) {
                if (isEditMode) {
                  if (editTodoId!.isNotEmpty) {
                    todoController.updateTodo(
                      Todo(
                        editTodoId!,
                        todoController.inputValue,
                        DateTime.now(),
                        false,
                      ),
                    );
                    onAfterUpdate();
                  }
                } else {
                  todoController.addNewTodo(
                    Todo(
                      uuid.v4(),
                      todoController.inputValue,
                      DateTime.now(),
                      false,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 22,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(isEditMode ? 'Update' : 'Create'),
          )
        ],
      ),
    );
  }
}
