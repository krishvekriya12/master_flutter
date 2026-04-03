import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> todos = [];
  List<bool> isCompleted = [];

  TextEditingController controller = TextEditingController();

  void addTodo() {
    if (controller.text.isNotEmpty) {
      setState(() {
        todos.add(controller.text);
        isCompleted.add(false);
        controller.clear();
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Plase Add To-do")));
    }
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
      isCompleted.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do App")),
      body: Column(
        children: [
          TextField(controller: controller),
          SizedBox(height: 20),
          ElevatedButton(onPressed: addTodo, child: Text("Add To-do")),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: isCompleted[index],
                    onChanged: (value) {
                      setState(() {
                        isCompleted[index] = value!;
                      });
                    },
                  ),
                  title: Text(
                    todos[index],
                    style: TextStyle(
                      decoration: isCompleted[index]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      deleteTodo(index);
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
