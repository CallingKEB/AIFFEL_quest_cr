// lib/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> habits = ["운동하기", "책 읽기", "공부하기"]; // 초기 습관 목록
  Map<String, bool> habitStatus = {}; // 각 습관의 완료 상태 관리

  @override
  void initState() {
    super.initState();
    // 각 습관의 완료 상태 초기화
    habitStatus = {for (var habit in habits) habit: false};
  }

  // 새로운 습관 추가
  void addHabit(String habit) {
    setState(() {
      habits.add(habit);
      habitStatus[habit] = false; // 새 습관은 미완료 상태로 초기화
    });
  }

  // AddHabitScreen으로 이동하여 새로운 습관을 추가하는 메서드
  Future<void> _navigateToAddHabitScreen() async {
    final newHabit = await Navigator.pushNamed(context, '/add');
    if (newHabit != null && newHabit is String && newHabit.isNotEmpty) {
      addHabit(newHabit); // 새로운 습관 추가
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Habit Tracker")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                String habit = habits[index];
                return ListTile(
                  title: Text(habit),
                  trailing: Checkbox(
                    value: habitStatus[habit],
                    onChanged: (bool? value) {
                      setState(() {
                        habitStatus[habit] = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddHabitScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}
