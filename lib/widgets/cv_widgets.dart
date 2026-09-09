import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final bool dark; // true = บนพื้นน้ำเงิน
  const SectionTitle(this.text, {super.key, this.dark = false});

  @override
  Widget build(BuildContext context) {
    if (dark) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.w700, fontSize: 16),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
      ),
    );
  }
}

class SkillBar extends StatelessWidget {
  final String name;
  final double level;
  final bool dark;
  const SkillBar({super.key, required this.name, required this.level, this.dark = false});

  @override
  Widget build(BuildContext context) {
    final bg = dark ? Colors.white24 : AppColors.lightBlue;
    final fg = dark ? Colors.white : AppColors.blue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  color: dark ? Colors.white : Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: level,
              minHeight: 8,
              backgroundColor: bg,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          ),
        ],
      ),
    );
  }
}

class Bullet extends StatelessWidget {
  final String text;
  final bool dark;
  const Bullet(this.text, {super.key, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•  ',
              style: TextStyle(
                  color: dark ? Colors.white : AppColors.navy,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          Expanded(
            child: Text(text,
                style: TextStyle(
                    color: dark ? Colors.white : Colors.black87, fontSize: 13.5, height: 1.5)),
          ),
        ],
      ),
    );
  }
}
