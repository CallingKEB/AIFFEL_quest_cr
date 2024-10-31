// lib/attendance_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Map<String, String> attendanceRecords = {}; // 각 날짜의 출석 상태를 관리
  double attendanceRate = 0.0; // 출석률 저장 변수

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 선택한 날짜들을 받아와서 초기 출석 상태를 "X"로 설정
    final List<DateTime> selectedDates =
        ModalRoute.of(context)?.settings.arguments as List<DateTime>? ?? [];
    for (var date in selectedDates) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      attendanceRecords[formattedDate] = "X"; // 초기 상태는 "X"로 설정
    }
  }

  // 출석 상태를 토글하는 함수
  void toggleAttendanceStatus(String date) {
    setState(() {
      attendanceRecords[date] = attendanceRecords[date] == "O" ? "X" : "O";
    });
  }

  // 출석률을 계산하는 함수
  void calculateAttendanceRate() {
    int completedGoals = attendanceRecords.values.where((status) => status == "O").length;
    int totalGoals = attendanceRecords.length;

    setState(() {
      attendanceRate = totalGoals > 0 ? (completedGoals / totalGoals) * 100 : 0;
    });

    // 출석률 결과를 보여주는 스낵바
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("목표 달성률: ${attendanceRate.toStringAsFixed(1)}%")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("출석 확인")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("선택한 날짜의 출석 상태", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: attendanceRecords.keys.length,
                itemBuilder: (context, index) {
                  String date = attendanceRecords.keys.elementAt(index);
                  return ListTile(
                    title: Text("날짜: $date"),
                    subtitle: Text("출석 여부: ${attendanceRecords[date]}"),
                    trailing: ElevatedButton(
                      onPressed: () => toggleAttendanceStatus(date),
                      child: Text(
                        attendanceRecords[date] == "O" ? "완료됨" : "목표완료",
                        style: TextStyle(color: attendanceRecords[date] == "O" ? Colors.green : Colors.red),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateAttendanceRate,
              child: Text("목표 달성 여부"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/channel'); // 내 채널 목록 화면으로 이동
              },
              child: Text("내 채널 목록으로 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
