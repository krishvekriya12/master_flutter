import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String weather = "";
  String city = "";
  bool isLoading = false;

  Future<void> getWeather() async {
    setState(() {
      isLoading = true;
    });

    String apiKey = "YOUR_API_KEY_HERE";
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        weather =
            "${data['main']['temp']}°C - ${data['weather'][0]['description']}";
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        weather = "Error: ${response.statusCode}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                city = value;
              },
              decoration: InputDecoration(hintText: "Enter  city name"),
            ),
            Text(city, style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : Text(weather, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: getWeather, child: Text("Get Weather")),
          ],
        ),
      ),
    );
  }
}
