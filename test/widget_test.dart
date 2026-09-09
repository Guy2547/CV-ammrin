import 'package:flutter_test/flutter_test.dart';

import 'package:cvammarin0084/main.dart';

void main() {
  testWidgets('CV app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const CvApp());
    await tester.pumpAndSettle();

    // ชื่อภาษาไทยต้องปรากฏ
    expect(find.textContaining('อมรินทร์'), findsWidgets);
    // ปุ่ม Export PDF ต้องมี
    expect(find.text('PDF'), findsOneWidget);
  });
}
