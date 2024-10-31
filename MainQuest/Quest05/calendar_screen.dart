import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<DateTime> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("날짜 선택")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => selectedDates.contains(day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (selectedDates.contains(selectedDay)) {
                  selectedDates.remove(selectedDay); // 선택 해제
                } else {
                  selectedDates.add(selectedDay); // 선택 추가
                }
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (selectedDates.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  '/attendance', // 경로를 확인해 주세요.
                  arguments: selectedDates, // 선택한 날짜 목록 전달
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("날짜를 선택해 주세요.")),
                );
              }
            },
            child: Text("출석 확인으로 이동"),
          ),
        ],
      ),
    );
  }
}
