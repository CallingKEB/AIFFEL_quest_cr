// lib/habit_management_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HabitManagementScreen extends StatefulWidget {
  @override
  _HabitManagementScreenState createState() => _HabitManagementScreenState();
}

class _HabitManagementScreenState extends State<HabitManagementScreen> {
  Map<String, List<String>> habitCategories = {
    "운동": ["걷기", "스트레칭", "근력 운동"],
    "독서": ["매일 10분 독서", "자기계발서 읽기"],
    "건강": ["매일 아침 물 마시기", "스트레스 관리"]
  };

  List<String> recommendedHabits = [];

  Future<void> fetchRecommendedHabits() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/recommend_habits'), // 추천 습관을 가져오는 API 주소
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        recommendedHabits = List<String>.from(data['recommended_habits']);
      });
    } else {
      setState(() {
        recommendedHabits = ["추천 습관을 불러오는 데 실패했습니다."];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecommendedHabits(); // 화면 초기화 시 추천 습관 가져오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("습관 관리")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("카테고리별 습관", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: habitCategories.entries.map((entry) {
                  return ExpansionTile(
                    title: Text(entry.key, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    children: entry.value.map((habit) => ListTile(title: Text(habit))).toList(),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text("추천 습관", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            if (recommendedHabits.isNotEmpty)
              Column(
                children: recommendedHabits.map((habit) => ListTile(title: Text(habit))).toList(),
              ),
            if (recommendedHabits.isEmpty)
              Center(child: CircularProgressIndicator()), // 로딩 중 표시
          ],
        ),
      ),
    );
  }
}
