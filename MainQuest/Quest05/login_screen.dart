// lib/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40), // 위쪽 여백 추가
            // GIF 이미지 추가
            Image.asset(
              "assets/images/cheer_up.gif",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            // 이름 입력 필드
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '이름을 입력하세요'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  Navigator.pushNamed(context, '/channel', arguments: _nameController.text);
                }
              },
              child: Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
