import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../data/cv_data.dart';

/// สร้าง PDF ของ CV รองรับภาษาไทยด้วยฟอนต์ Prompt (โหลดผ่าน PdfGoogleFonts)
class PdfService {
  static Future<Uint8List> buildCvPdf(AppLang lang) async {
    final fontRegular = await PdfGoogleFonts.promptRegular();
    final fontMedium = await PdfGoogleFonts.promptMedium();
    final fontBold = await PdfGoogleFonts.promptBold();

    final navy = PdfColor.fromHex('#1E3A5F');
    final blue = PdfColor.fromHex('#2F6AA8');
    final cream = PdfColor.fromHex('#FFFBF2');

    final doc = pw.Document();

    pw.Widget header() {
      return pw.Container(
        width: double.infinity,
        color: navy,
        padding: const pw.EdgeInsets.all(20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              lang == AppLang.th ? CvData.nameTh : CvData.nameEn,
              style: pw.TextStyle(font: fontBold, fontSize: 22, color: PdfColors.white),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              CvData.title(lang),
              style: pw.TextStyle(font: fontMedium, fontSize: 14, color: PdfColors.white),
            ),
            pw.Text(
              CvData.subtitle(lang),
              style: pw.TextStyle(font: fontRegular, fontSize: 10, color: PdfColors.white),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              'Tel: ${CvData.phone}   •   Email: ${CvData.email}',
              style: pw.TextStyle(font: fontRegular, fontSize: 10, color: PdfColors.white),
            ),
          ],
        ),
      );
    }

    pw.Widget sectionHead(String text) {
      return pw.Container(
        margin: const pw.EdgeInsets.only(top: 12, bottom: 6),
        padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: pw.BoxDecoration(color: navy, borderRadius: pw.BorderRadius.circular(8)),
        child: pw.Text(text,
            style: pw.TextStyle(font: fontBold, fontSize: 13, color: PdfColors.white)),
      );
    }

    pw.Widget bullet(String text) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 2),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('•  ', style: pw.TextStyle(font: fontBold, fontSize: 10, color: navy)),
            pw.Expanded(
              child: pw.Text(text,
                  style: pw.TextStyle(font: fontRegular, fontSize: 10, lineSpacing: 2)),
            ),
          ],
        ),
      );
    }

    // โหลดรูปโปรไฟล์ (assets/images/profile.png) — ถ้าไม่มีก็ข้าม
    pw.MemoryImage? profileImage;
    try {
      final bytes = await rootBundle.load('assets/images/profile.png');
      profileImage = pw.MemoryImage(bytes.buffer.asUint8List());
    } catch (_) {
      try {
        final bytes = await rootBundle.load('assets/images/profile.jpg');
        profileImage = pw.MemoryImage(bytes.buffer.asUint8List());
      } catch (_) {
        profileImage = null;
      }
    }

    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(0),
          buildBackground: (context) => pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(color: cream),
          ),
        ),
        build: (context) => [
          header(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (profileImage != null)
                  pw.Center(
                    child: pw.Container(
                      width: 100,
                      height: 120,
                      decoration: pw.BoxDecoration(border: pw.Border.all(color: blue, width: 2)),
                      child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                    ),
                  ),
                sectionHead(CvData.aboutTitle(lang)),
                pw.Text(CvData.aboutBody(lang),
                    style: pw.TextStyle(font: fontRegular, fontSize: 10, lineSpacing: 3)),
                sectionHead(CvData.objectiveTitle(lang)),
                pw.Text(CvData.objectiveBody(lang),
                    style: pw.TextStyle(font: fontRegular, fontSize: 10, lineSpacing: 3)),
                sectionHead(CvData.infoTitle(lang)),
                ...CvData.personalInfo(lang).map(
                  (e) => pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                            width: 90,
                            child: pw.Text('${e[0]}:',
                                style: pw.TextStyle(font: fontBold, fontSize: 10, color: navy))),
                        pw.Expanded(
                            child: pw.Text(e[1],
                                style: pw.TextStyle(font: fontRegular, fontSize: 10))),
                      ],
                    ),
                  ),
                ),
                sectionHead(CvData.eduTitle(lang)),
                ...CvData.educations.map(
                  (e) => pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 2),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                            width: 8,
                            height: 8,
                            margin: const pw.EdgeInsets.only(top: 3, right: 6),
                            decoration: const pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFF2F6AA8), shape: pw.BoxShape.circle)),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                lang == AppLang.th ? e.schoolTh : e.schoolEn,
                                style: pw.TextStyle(font: fontBold, fontSize: 10),
                              ),
                              pw.Text(
                                '${lang == AppLang.th ? e.levelTh : e.levelEn}  (${e.year})',
                                style: pw.TextStyle(font: fontRegular, fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sectionHead('${CvData.expTitle(lang)} — ${CvData.expPeriod(lang)}'),
                pw.Text(CvData.expRole(lang),
                    style: pw.TextStyle(font: fontBold, fontSize: 11, color: navy)),
                pw.Text(CvData.expCompany(lang),
                    style: pw.TextStyle(font: fontRegular, fontSize: 10)),
                ...CvData.expBullets(lang).map(bullet),
                sectionHead(CvData.skillTitle(lang)),
                ...CvData.softSkills(lang).map(bullet),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Technical: Node.js/Express, PostgreSQL (JOIN + parameterized + pooling), JWT (RBAC) + bcrypt, helmet/cors/rate-limit, Socket.io + audit log, Jest+Supertest, Docker, Electron, Java/C, HTML/CSS, Dart/Flutter, Git',
                  style: pw.TextStyle(font: fontRegular, fontSize: 10),
                ),
                sectionHead(CvData.projectTitle(lang)),
                ...CvData.projects.map(
                  (p) => pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 3),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                            '• ${lang == AppLang.th ? p.titleTh : p.titleEn}',
                            style: pw.TextStyle(font: fontBold, fontSize: 10)),
                        pw.Text(
                            '   ${lang == AppLang.th ? p.descTh : p.descEn}',
                            style: pw.TextStyle(font: fontRegular, fontSize: 9)),
                        pw.Text('   Tech: ${p.tech}',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8)),
                        pw.Text('   GitHub: ${p.githubUrl}',
                            style: pw.TextStyle(font: fontRegular, fontSize: 8)),
                        if (p.demoUrl != null)
                          pw.Text('   Demo: ${p.demoUrl}',
                              style: pw.TextStyle(font: fontRegular, fontSize: 8)),
                      ],
                    ),
                  ),
                ),
                sectionHead(CvData.langTitle(lang)),
                ...CvData.languages(lang).map((e) => bullet('${e[0]} — ${e[1]}')),
                sectionHead(CvData.contactTitle(lang)),
                bullet('Phone: ${CvData.phone}'),
                bullet('Email: ${CvData.email}'),
                bullet('GitHub: ${CvData.githubProfile}'),
              ],
            ),
          ),
        ],
      ),
    );

    return doc.save();
  }

  /// เปิดหน้าพรีวิว/แชร์ PDF (ใช้ได้ทั้งมือถือและเดสก์ท็อป)
  static Future<void> sharePdf(AppLang lang) async {
    final bytes = await buildCvPdf(lang);
    final name = lang == AppLang.th ? 'CV-Ammarin-TH.pdf' : 'CV-Ammarin-EN.pdf';
    await Printing.sharePdf(bytes: bytes, filename: name);
  }

  static Future<void> previewPdf(AppLang lang) async {
    final bytes = await buildCvPdf(lang);
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }
}
