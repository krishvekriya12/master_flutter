import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider extends ChangeNotifier {
  int counter = 0;

  void incriment() {
    counter++;
    notifyListeners();
  }

  void dicriment() {
    counter--;
    notifyListeners();
  }
}

class ProviderHome extends StatelessWidget {
  const ProviderHome({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Provider App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              counterProvider.counter.toString(),
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: counterProvider.incriment,
              child: Text("Incriment"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: counterProvider.dicriment,
              child: Text("Dicriment"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DublicateDataScreen(),
                  ),
                );
              },
              child: Text(
                "Go To Next Screen",
                style: TextStyle(color: Colors.pinkAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DublicateDataScreen extends StatelessWidget {
  const DublicateDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("DublicateDataScreen")),
      body: Center(
        child: Column(
          children: [
            Text(
              counterProvider.counter.toString(),
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
