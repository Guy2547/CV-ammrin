import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/cv_data.dart';
import '../services/pdf_service.dart';
import '../theme/app_theme.dart';
import '../widgets/cv_widgets.dart';

class CvScreen extends StatefulWidget {
  const CvScreen({super.key});
  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  AppLang _lang = AppLang.th;
  bool _exporting = false;

  Future<void> _launch(String uriStr) async {
    final uri = Uri.parse(uriStr);
    if (!await launchUrl(uri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_lang == AppLang.th ? 'เปิดลิงก์ไม่ได้: $uriStr' : 'Could not open: $uriStr')),
        );
      }
    }
  }

  Future<void> _exportPdf() async {
    setState(() => _exporting = true);
    try {
      await PdfService.sharePdf(_lang);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_lang == AppLang.th ? 'Export ไม่สำเร็จ: $e' : 'Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = _lang;
    return Scaffold(
      appBar: AppBar(
        title: Text(l == AppLang.th ? 'CV — ${CvData.nameTh}' : 'CV — ${CvData.nameEn}'),
        actions: [
          // ปุ่มสลับภาษา
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: SegmentedButton<AppLang>(
              segments: const [
                ButtonSegment(value: AppLang.th, label: Text('TH')),
                ButtonSegment(value: AppLang.en, label: Text('EN')),
              ],
              selected: {_lang},
              onSelectionChanged: (s) => setState(() => _lang = s.first),
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                backgroundColor: WidgetStateProperty.resolveWith(
                  (states) => states.contains(WidgetState.selected) ? Colors.white : null,
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: l == AppLang.th ? 'ดูตัวอย่าง PDF' : 'Preview PDF',
            onPressed: () => PdfService.previewPdf(_lang),
            icon: const Icon(Icons.picture_as_pdf_outlined),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _exporting
                ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)))
                : FilledButton.icon(
                    onPressed: _exportPdf,
                    icon: const Icon(Icons.download, size: 18),
                    label: Text(l == AppLang.th ? 'PDF' : 'PDF'),
                  ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth > 800;
          if (wide) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _Header(
                      lang: l,
                      onCall: () => _launch('tel:${CvData.phone.replaceAll('-', '')}'),
                      onMail: () => _launch('mailto:${CvData.email}'),
                      onGithub: () => _launch(CvData.githubProfile)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 330, child: _LeftColumn(lang: l)),
                        const SizedBox(width: 16),
                        Expanded(
                            child: _RightColumn(
                                lang: l,
                                onCall: () => _launch('tel:${CvData.phone.replaceAll('-', '')}'),
                                onMail: () => _launch('mailto:${CvData.email}'),
                                onOpen: _launch)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                _Header(
                    lang: l,
                    onCall: () => _launch('tel:${CvData.phone.replaceAll('-', '')}'),
                    onMail: () => _launch('mailto:${CvData.email}'),
                    onGithub: () => _launch(CvData.githubProfile)),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _LeftColumn(lang: l),
                      const SizedBox(height: 16),
                      _RightColumn(
                          lang: l,
                          onCall: () => _launch('tel:${CvData.phone.replaceAll('-', '')}'),
                          onMail: () => _launch('mailto:${CvData.email}'),
                          onOpen: _launch),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final AppLang lang;
  final VoidCallback onCall;
  final VoidCallback onMail;
  final VoidCallback onGithub;
  const _Header({required this.lang, required this.onCall, required this.onMail, required this.onGithub});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Wrap(
        spacing: 20,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // รูปโปรไฟล์: assets/images/profile.png (ถ้าไม่มีไฟล์จะโชว์ตัวอักษร ก แทน)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 130,
              height: 160,
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.blue,
                  alignment: Alignment.center,
                  child: const Text('ก',
                      style: TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 260, maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang == AppLang.th ? CvData.nameTh : CvData.nameEn,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, height: 1.3),
                ),
                const SizedBox(height: 6),
                Text(CvData.title(lang),
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(height: 4),
                Text(CvData.subtitle(lang),
                    style: const TextStyle(fontSize: 13, color: Colors.white70, height: 1.5)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      avatar: const Icon(Icons.phone, size: 16),
                      label: Text(CvData.phone),
                      onPressed: onCall,
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.email, size: 16),
                      label: Text(CvData.email),
                      onPressed: onMail,
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.code, size: 16),
                      label: const Text('GitHub: Guy2547'),
                      onPressed: onGithub,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftColumn extends StatelessWidget {
  final AppLang lang;
  const _LeftColumn({required this.lang});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionTitle(CvData.aboutTitle(lang), dark: true),
          const SizedBox(height: 10),
          Text(CvData.aboutBody(lang),
              style: const TextStyle(color: Colors.white, fontSize: 13.5, height: 1.7)),
          const SizedBox(height: 18),
          SectionTitle(CvData.objectiveTitle(lang), dark: true),
          const SizedBox(height: 10),
          Text(CvData.objectiveBody(lang),
              style: const TextStyle(color: Colors.white, fontSize: 13.5, height: 1.7)),
          const SizedBox(height: 18),
          SectionTitle(CvData.infoTitle(lang), dark: true),
          const SizedBox(height: 6),
          ...CvData.personalInfo(lang).map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 13.5, height: 1.5, color: Colors.white),
                        children: [
                          TextSpan(text: '${e[0]} : ', style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: e[1]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          SectionTitle(CvData.skillTitle(lang), dark: true),
          const SizedBox(height: 8),
          ...CvData.hardSkills.map((s) => SkillBar(
              name: lang == AppLang.th ? s.nameTh : s.nameEn, level: s.level, dark: true)),
          const SizedBox(height: 6),
          ...CvData.softSkills(lang).map((s) => Bullet(s, dark: true)),
          const SizedBox(height: 18),
          SectionTitle(CvData.langTitle(lang), dark: true),
          const SizedBox(height: 8),
          ...CvData.languages(lang).map((e) => Bullet('${e[0]} — ${e[1]}', dark: true)),
        ],
      ),
    );
  }
}

class _RightColumn extends StatelessWidget {
  final AppLang lang;
  final VoidCallback onCall;
  final VoidCallback onMail;
  final void Function(String url) onOpen;
  const _RightColumn({required this.lang, required this.onCall, required this.onMail, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.navy, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionTitle(CvData.eduTitle(lang)),
          const SizedBox(height: 12),
          ...CvData.educations.map((e) => _TimelineTile(
                title: lang == AppLang.th ? e.schoolTh : e.schoolEn,
                subtitle: lang == AppLang.th ? e.levelTh : e.levelEn,
                year: e.year,
              )),
          const SizedBox(height: 12),
          SectionTitle('${CvData.expTitle(lang)} • ${CvData.expPeriod(lang)}'),
          const SizedBox(height: 8),
          Text(CvData.expRole(lang),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(CvData.expCompany(lang),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 6),
          ...CvData.expBullets(lang).map((b) => Bullet(b)),
          const SizedBox(height: 12),
          SectionTitle(CvData.projectTitle(lang)),
          const SizedBox(height: 8),
          ...CvData.projects.map((p) => _ProjectCard(
                title: lang == AppLang.th ? p.titleTh : p.titleEn,
                desc: lang == AppLang.th ? p.descTh : p.descEn,
                tech: p.tech,
                githubUrl: p.githubUrl,
                demoUrl: p.demoUrl,
                onOpen: onOpen,
              )),
          const SizedBox(height: 12),
          SectionTitle(CvData.contactTitle(lang)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              FilledButton.icon(onPressed: onCall, icon: const Icon(Icons.phone, size: 18), label: Text(CvData.phone)),
              OutlinedButton.icon(onPressed: onMail, icon: const Icon(Icons.email, size: 18), label: Text(CvData.email)),
              OutlinedButton.icon(
                  onPressed: () => onOpen(CvData.githubProfile),
                  icon: const Icon(Icons.code, size: 18),
                  label: const Text('GitHub')),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            lang == AppLang.th
                ? 'รูปโปรไฟล์: assets/images/profile.png (เปลี่ยนรูปได้โดยวางไฟล์ชื่อเดิมทับ)'
                : 'Profile photo: assets/images/profile.png (replace the file with the same name to change)',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final String title;
  final String desc;
  final String tech;
  final String githubUrl;
  final String? demoUrl;
  final void Function(String url) onOpen;
  const _ProjectCard({
    required this.title,
    required this.desc,
    required this.tech,
    required this.githubUrl,
    this.demoUrl,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.lightBlue.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.work_outline, color: AppColors.navy),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 12.5, height: 1.5)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: AppColors.navy.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(tech, style: const TextStyle(fontSize: 11, color: AppColors.navy)),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                TextButton.icon(
                  onPressed: () => onOpen(githubUrl),
                  icon: const Icon(Icons.code, size: 16),
                  label: const Text('GitHub', style: TextStyle(fontSize: 12)),
                ),
                if (demoUrl != null)
                  TextButton.icon(
                    onPressed: () => onOpen(demoUrl!),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('Live Demo', style: TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String year;
  const _TimelineTile({required this.title, required this.subtitle, required this.year});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle)),
              Expanded(child: Container(width: 2, color: AppColors.navy.withValues(alpha: 0.4))),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(14)),
                    child: Text(title,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13.5)),
                  ),
                  const SizedBox(height: 3),
                  Text('$subtitle  •  $year', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
