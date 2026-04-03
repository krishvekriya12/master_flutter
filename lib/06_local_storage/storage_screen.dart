import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String savedName = "";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadName();
  }

  Future<void> saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', controller.text);
    setState(() {
      savedName = controller.text;
    });
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedName = prefs.getString('name') ?? "No name Saved";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Local Storage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Saved : $savedName", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter Your Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveName, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
