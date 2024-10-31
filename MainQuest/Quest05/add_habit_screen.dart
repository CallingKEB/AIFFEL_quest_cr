// lib/add_habit_screen.dart
import 'package:flutter/material.dart';

class AddHabitScreen extends StatelessWidget {
  final TextEditingController habitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("새 습관 추가")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: habitController,
              decoration: InputDecoration(labelText: "새 습관 이름"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 습관 추가 후 이전 화면으로 돌아가면서 새로운 습관을 전달
                Navigator.pop(context, habitController.text);
              },
              child: Text("추가"),
            ),
          ],
        ),
      ),
    );
  }
}
