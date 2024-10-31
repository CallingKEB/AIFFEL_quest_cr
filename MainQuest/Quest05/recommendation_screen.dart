import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  String recommendationMessage = "추천 습관을 받으세요";

  Future<void> fetchRecommendations(Map<String, bool> habitStatus) async {
    final response = await http.post(
      Uri.parse('https://your-ngrok-url.ngrok.io/recommend_habits'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(habitStatus),
    );

    if (response.statusCode == 200) {
      setState(() {
        recommendationMessage = jsonDecode(response.body)["recommendation"];
      });
    } else {
      setState(() {
        recommendationMessage = "추천을 불러오는 데 실패했습니다.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> habitStatus =
    ModalRoute.of(context)?.settings.arguments as Map<String, bool>;

    return Scaffold(
      appBar: AppBar(title: Text("추천 습관")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(recommendationMessage),
            ElevatedButton(
              onPressed: () => fetchRecommendations(habitStatus),
              child: Text("추천 받기"),
            ),
          ],
        ),
      ),
    );
  }
}
