import 'package:flutter/material.dart';
import 'package:myarchiveidea/Screen/main_screen.dart';
import 'package:myarchiveidea/Screen/splash_screen.dart';
import 'package:myarchiveidea/data/idea_info.dart';

import 'Screen/edit_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archive Idea',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          //1.아이디어 기록값을 넘기지 못한다면 작성 시나리오

          //2.아이디어 기록값을 넘길 수 있다면 수정 시나리오
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;
          return MaterialPageRoute(
            builder: (context) {
              return EditScreen();
            },
          );
        }
        return null;
      },
    );
  }
}
