import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String username = "";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadName();
  }

  Future<void> saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", controller.text);
    setState(() {
      username = controller.text;
    });
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('name') ?? "No User Name Saved";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: controller),
            SizedBox(height: 10),
            ElevatedButton(onPressed: saveName, child: Text("Edit")),
          ],
        ),
      ),
    );
  }
}
