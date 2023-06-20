import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import './getx/todo.dart';

import 'component/todo_input_field.dart';
import 'component/todo_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TodoController todoController = Get.put(TodoController());

  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  void handleClearStateUpdate() {
    todoController.editedTodoId.value = '';
    todoController.inputValue = '';
    todoController.isEditMode.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Todo App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Not Completed'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TodoInputField(
                  todoController: todoController,
                  editTodoId: todoController.editedTodoId.value,
                  isEditMode: todoController.isEditMode.value,
                  onAfterUpdate: handleClearStateUpdate,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      todoList(todos: todoController.notCompletedTodo),
                      todoList(todos: todoController.completedTodo),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
