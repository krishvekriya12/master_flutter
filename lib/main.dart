import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '09_user_info_ui_prectis/user_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserInfoScreen(),
    );
  }
}
