// lib/channel_screen.dart
import 'package:flutter/material.dart';

class ChannelScreen extends StatefulWidget {
  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final TextEditingController _codeController = TextEditingController();
  List<String> joinedChannels = ["9월"]; // 이미 가입된 채널 예시

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2), // 스낵바 표시 시간을 2초로 설정
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? userName = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: Text(userName != null ? "$userName님" : "채널 화면")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (userName != null)
              Text(
                "$userName님 환영합니다!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: '코드로 채널 가입하기'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_codeController.text.isNotEmpty) {
                  String newChannel;
                  switch (_codeController.text) {
                    case "1":
                      newChannel = "10월";
                      break;
                    case "2":
                      newChannel = "책읽기";
                      break;
                    case "3":
                      newChannel = "영어 공부 하기";
                      break;
                    default:
                      newChannel = "온라인${_codeController.text}";
                      break;
                  }

                  if (!joinedChannels.contains(newChannel)) {
                    setState(() {
                      joinedChannels.add(newChannel);
                      _codeController.clear();
                    });
                    _showSnackBar(context, "$newChannel 채널에 가입되었습니다!");
                  } else {
                    _showSnackBar(context, "이미 가입된 채널입니다.");
                  }
                }
              },
              child: Text("가입"),
            ),
            SizedBox(height: 20),
            Text("내 채널 목록", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: joinedChannels.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(joinedChannels[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/calendar');
                          },
                          child: Text("채널 입장"),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/habitManagement'); // 습관 관리 화면으로 이동
                          },
                          child: Text("습관 관리"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
