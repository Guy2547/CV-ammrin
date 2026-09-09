import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/cv_screen.dart';

void main() {
  runApp(const CvApp());
}

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV — อมรินทร์ ขวัญคีรี',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const CvScreen(),
    );
  }
}
