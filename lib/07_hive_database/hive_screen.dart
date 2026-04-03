import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveScreen extends StatefulWidget {
  const HiveScreen({super.key});

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen> {
  List<String> todos = [];
  TextEditingController controller = TextEditingController();
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('todos');
    loadTodos();
  }

  void loadTodos() {
    setState(() {
      todos = box.values.cast<String>().toList();
    });
  }

  void addTodo() {
    if (controller.text.isNotEmpty) {
      box.add(controller.text);
      controller.clear();
      loadTodos();
    }
  }

  void deleteTodo(int index) {
    box.deleteAt(index);
    loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-do App", style: TextStyle(fontSize: 20))),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter Todo"),
            ),
            ElevatedButton(onPressed: addTodo, child: Text("Add")),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index]),
                    trailing: IconButton(
                      onPressed: () => deleteTodo(index),
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
