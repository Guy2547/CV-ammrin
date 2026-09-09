// ข้อมูล CV 2 ภาษา — แก้ที่ไฟล์นี้ไฟล์เดียว
// รูปโปรไฟล์: วางไฟล์ที่ assets/images/profile.jpg (ครอปจาก PDF เดิม)

enum AppLang { th, en }

class EducationItem {
  final String schoolTh;
  final String schoolEn;
  final String levelTh;
  final String levelEn;
  final String year;
  const EducationItem({
    required this.schoolTh,
    required this.schoolEn,
    required this.levelTh,
    required this.levelEn,
    required this.year,
  });
}

class SkillItem {
  final String nameTh;
  final String nameEn;
  final double level; // 0.0 - 1.0
  const SkillItem({required this.nameTh, required this.nameEn, required this.level});
}

class ProjectItem {
  final String titleTh;
  final String titleEn;
  final String descTh;
  final String descEn;
  final String tech;
  final String githubUrl;
  final String? demoUrl;
  const ProjectItem({
    required this.titleTh,
    required this.titleEn,
    required this.descTh,
    required this.descEn,
    required this.tech,
    required this.githubUrl,
    this.demoUrl,
  });
}

class CvData {
  static const nameTh = 'นายอมรินทร์ ขวัญคีรี';
  static const nameEn = 'Ammarin Khwankhiri';
  static const nicknameTh = 'กาย';
  static const nicknameEn = 'Guy';
  static const phone = '095-271-2693';
  static const email = 'guy200887@gmail.com';
  static const githubProfile = 'https://github.com/Guy2547';

  static String t(AppLang l, String th, String en) => l == AppLang.th ? th : en;

  static const educations = [
    EducationItem(
      schoolTh: 'โรงเรียนอนุบาลปิยะรัตน์',
      schoolEn: 'Anuban Piyarath School',
      levelTh: 'อนุบาลศึกษา',
      levelEn: 'Kindergarten',
      year: '2554',
    ),
    EducationItem(
      schoolTh: 'โรงเรียนวัดพระมหาธาตุ',
      schoolEn: 'Wat Phra Mahathat School',
      levelTh: 'ประถมศึกษา',
      levelEn: 'Primary School',
      year: '2560',
    ),
    EducationItem(
      schoolTh: 'โรงเรียนศรีธรรมราชศึกษา',
      schoolEn: 'Sithammarat Suksa School',
      levelTh: 'มัธยมศึกษาตอนต้น',
      levelEn: 'Lower Secondary School',
      year: '2562',
    ),
    EducationItem(
      schoolTh: 'วิทยาลัยอาชีวศึกษานครศรีธรรมราช',
      schoolEn: 'Nakhon Si Thammarat Vocational College',
      levelTh: 'ปวช./ปวส. — สาขาคอมพิวเตอร์ (ตัวอย่าง แก้ปี/สาขาได้)',
      levelEn: 'Vocational Certificate — Computer (edit year/major)',
      year: '2562 – 2566',
    ),
    EducationItem(
      schoolTh: 'มหาวิทยาลัยเทคโนโลยีราชมงคลพระนคร',
      schoolEn: 'Rajamangala University of Technology Phra Nakhon',
      levelTh: 'ปริญญาตรี (ต่อเนื่อง 2 ปี) — วิศวกรรมคอมพิวเตอร์ • สำเร็จการศึกษา',
      levelEn: 'B.Eng. (2-year continuing) — Computer Engineering • Graduated',
      year: '2567 – ปัจจุบัน',
    ),
  ];

  // สกิลที่พิสูจน์จากโค้ดจริงใน GitHub (เช็ค app.js, routes, Dockerfile, main.js, logs.test.js แล้ว)
  static const hardSkills = [
    SkillItem(nameTh: 'Node.js / Express / REST API', nameEn: 'Node.js / Express / REST API', level: 0.75),
    SkillItem(nameTh: 'PostgreSQL (JOIN + parameterized + pooling)', nameEn: 'PostgreSQL (JOIN + parameterized + pooling)', level: 0.7),
    SkillItem(nameTh: 'JWT (RBAC roles) + bcrypt', nameEn: 'JWT (RBAC roles) + bcrypt', level: 0.7),
    SkillItem(nameTh: 'Security: helmet / cors / rate-limit', nameEn: 'Security: helmet / cors / rate-limit', level: 0.65),
    SkillItem(nameTh: 'Socket.io Realtime + Audit log', nameEn: 'Socket.io Realtime + Audit log', level: 0.65),
    SkillItem(nameTh: 'Jest + Supertest (Mock DB)', nameEn: 'Jest + Supertest (Mock DB)', level: 0.6),
    SkillItem(nameTh: 'Docker + Deploy Vercel/Railway', nameEn: 'Docker + Deploy Vercel/Railway', level: 0.6),
    SkillItem(nameTh: 'Electron Desktop + NSIS Installer', nameEn: 'Electron Desktop + NSIS Installer', level: 0.55),
    SkillItem(nameTh: 'Java / C / HTML / CSS (พื้นฐาน)', nameEn: 'Java / C / HTML / CSS (Basic)', level: 0.6),
    SkillItem(nameTh: 'Dart / Flutter (กำลังเรียนรู้)', nameEn: 'Dart / Flutter (Learning)', level: 0.45),
    SkillItem(nameTh: 'ซ่อมบำรุงอุปกรณ์ IT', nameEn: 'IT Maintenance', level: 0.75),
    SkillItem(nameTh: 'Git / VS Code', nameEn: 'Git / VS Code', level: 0.65),
  ];

  // ข้อความ UI ทั้งหมด — key เดียวใช้ทั้งแอปและ PDF
  static String title(AppLang l) => t(l, 'Software Engineer (วิศวกรซอฟต์แวร์)', 'Software Engineer');
  static String subtitle(AppLang l) => t(
      l,
      'สาขาวิศวกรรมคอมพิวเตอร์\nมหาวิทยาลัยเทคโนโลยีราชมงคลพระนคร',
      'Computer Engineering\nRajamangala University of Technology Phra Nakhon');
  static String aboutTitle(AppLang l) => t(l, 'เกี่ยวกับฉัน', 'About Me');
  static String aboutBody(AppLang l) => t(
      l,
      'ผมจบการศึกษาปริญญาตรี (ต่อเนื่อง 2 ปี) สาขาวิศวกรรมคอมพิวเตอร์ มีประสบการณ์ทำ Backend จริง (Node.js + Express + PostgreSQL + Socket.io) และงานซ่อมบำรุง IT สนใจการวิเคราะห์ระบบ (System Analysis), ออกแบบอัลกอริทึม (Algorithm Design), เขียนโปรแกรม (Programming) และการทดสอบแก้ไขข้อผิดพลาด (Debugging)',
      'I graduated with a bachelor’s degree (2-year continuing program) in Computer Engineering. I have real backend experience (Node.js + Express + PostgreSQL + Socket.io) plus IT maintenance work, with interests in System Analysis, Algorithm Design, Programming and Debugging.');

  static String infoTitle(AppLang l) => t(l, 'ข้อมูลส่วนตัว', 'Personal Info');
  static List<List<String>> personalInfo(AppLang l) => [
        [t(l, 'ชื่อ - สกุล', 'Name'), l == AppLang.th ? '$nameTh ($nicknameTh)' : '$nameEn ($nicknameEn)'],
        [t(l, 'ชื่อเล่น', 'Nickname'), t(l, nicknameTh, nicknameEn)],
        [t(l, 'อายุ', 'Age'), t(l, '21 ปี', '21 years')],
        [t(l, 'วันเกิด', 'Birthday'), t(l, '7 กรกฎาคม 2004', '7 July 2004')],
        [t(l, 'ศาสนา', 'Religion'), t(l, 'พุทธ', 'Buddhism')],
        [t(l, 'สัญชาติ', 'Nationality'), t(l, 'ไทย', 'Thai')],
      ];

  static String eduTitle(AppLang l) => t(l, 'ประวัติการศึกษา', 'Education');
  static String expTitle(AppLang l) => t(l, 'ประวัติการฝึกงาน', 'Internship');
  static String expRole(AppLang l) => t(l, 'IT Support Intern (ฝึกงานสายช่าง/ซัพพอร์ต)', 'IT Support Intern');
  static String expCompany(AppLang l) =>
      t(l, 'บริษัท ทรู ดิสทริบิวชั่น แอนด์ เซลล์ จำกัด', 'True Distribution & Sales Co., Ltd.');
  static String expPeriod(AppLang l) => '2564 – 2565 (2021 – 2022)';
  static List<String> expBullets(AppLang l) => l == AppLang.th
      ? [
          'ติดตั้ง ตรวจสอบ และซ่อมบำรุงคอมพิวเตอร์และอุปกรณ์ต่อพ่วงเบื้องต้น ลง Windows/โปรแกรมพื้นฐาน แก้ปัญหาเน็ตเวิร์กเบื้องต้น',
          'บันทึกงานซ่อม ดูแลการเบิก-สต็อกอุปกรณ์ ประสานงานทีมขายและลูกค้าหน้าร้าน',
          'ฝึกวินัยตรงเวลา ทำงานเป็นทีม และสื่อสารกับผู้ใช้ที่ไม่ใช่สายเทคนิค',
        ]
      : [
          'Installed, inspected and maintained PCs/peripherals; installed Windows/apps and fixed basic network issues.',
          'Logged repair jobs, handled stock requisition and coordinated with sales team and shop customers.',
          'Punctuality, teamwork and communicating with non-technical users.',
        ];

  static String skillTitle(AppLang l) => t(l, 'ทักษะความสามารถ', 'Skills');
  static List<String> softSkills(AppLang l) => l == AppLang.th
      ? [
          'ทำ Backend จริงเป็น: ออกแบบ REST API แยก routes/controllers/services/middleware + เขียนเทส (ดูโค้ดใน GitHub ได้)',
          'เข้าใจ Security พื้นฐาน: JWT (RBAC roles) + bcrypt, helmet/cors/rate-limit, audit log, Electron secure defaults',
          'มีความรู้พื้นฐาน Java, C, HTML',
          'ซ่อมบำรุงอุปกรณ์ไอทีได้',
          'มนุษยสัมพันธ์ดี ทำงานร่วมกับผู้อื่นได้',
          'ช่างสงสัย ใฝ่เรียนรู้ เปิดรับความรู้ใหม่ตลอด',
        ]
      : [
          'Real backend: REST API with routes/controllers/services/middleware + tests (see GitHub).',
          'Basic security: JWT (RBAC roles) + bcrypt, helmet/cors/rate-limit, audit logging, Electron secure defaults.',
          'Basic Java, C, HTML programming',
          'IT hardware maintenance & troubleshooting',
          'Good interpersonal skills, teamwork',
          'Curious, fast learner, open to new knowledge',
        ];

  static String langTitle(AppLang l) => t(l, 'ภาษา', 'Languages');
  static List<List<String>> languages(AppLang l) => [
        [t(l, 'ไทย', 'Thai'), t(l, 'เจ้าของภาษา', 'Native')],
        [t(l, 'อังกฤษ', 'English'), t(l, 'พอสื่อสารได้ (อ่านคู่มือ/เขียนโค้ดได้)', 'Fair (read docs / code)')],
      ];

  static String projectTitle(AppLang l) => t(l, 'โปรเจกต์', 'Projects');
  static const projects = [
    ProjectItem(
      titleTh: 'Server Logs Dashboard — ระบบดู Log แบบเรียลไทม์',
      titleEn: 'Server Logs Dashboard — Realtime Log Viewer',
      descTh: 'Backend จริง: แยกชั้น routes/controllers/services/middleware มี auth + JWT (RBAC roles) + query แบบ JOIN/parameterized, login แยกสาเหตุล้มเหลว (ไม่มีไอดี/รหัสผิด/ถูกระงับ) พร้อม audit log ไฟล์+DB+realtime emit มีเทส Jest + Supertest + Deploy บน Vercel ต่อ Railway PostgreSQL',
      descEn: 'Real backend: layered routes/controllers/services/middleware with JWT auth (RBAC roles) and JOIN/parameterized queries. Login distinguishes failure causes (unknown ID/wrong password/deactivated) with file+DB+realtime audit logging, Jest + Supertest tests and Vercel deploy with Railway PostgreSQL.',
      tech: 'Node.js • Express 5 • PostgreSQL (pg Pool) • Socket.io • JWT + bcrypt • helmet/cors/rate-limit • Jest • Docker',
      githubUrl: 'https://github.com/Guy2547/server-logs-dashboard',
      demoUrl: 'https://server-logs-dashboard.vercel.app',
    ),
    ProjectItem(
      titleTh: 'Win App (Data Login System) — แอป Desktop',
      titleEn: 'Win App (Data Login System) — Desktop App',
      descTh: 'แอป Desktop ติดตั้งบน Windows ได้: ตั้งค่า secure defaults (contextIsolation, ปิด nodeIntegration) ระบบ login ด้วย JWT เชื่อม API ผ่าน axios + Socket.io แพ็กเป็น installer ด้วย electron-builder',
      descEn: 'Installable Windows desktop app: secure defaults (contextIsolation, no nodeIntegration), JWT login, axios + Socket.io client, packaged with electron-builder (NSIS).',
      tech: 'Electron • JWT • Socket.io-client • axios • NSIS Installer',
      githubUrl: 'https://github.com/Guy2547/win-app',
    ),
    ProjectItem(
      titleTh: 'แอป CV ส่วนตัว (Flutter — แอปนี้เอง)',
      titleEn: 'Personal CV App (Flutter — this app)',
      descTh: 'แอปนี้เอง: แสดง CV 2 ภาษา responsive + กด Export เป็น PDF ภาษาไทยได้',
      descEn: 'This app: bilingual responsive CV showcase with Thai PDF export.',
      tech: 'Flutter • Dart • pdf • printing',
      githubUrl: 'https://github.com/Guy2547',
    ),
  ];

  static String contactTitle(AppLang l) => t(l, 'ติดต่อ', 'Contact');
  static String objectiveTitle(AppLang l) => t(l, 'เป้าหมายการทำงาน', 'Career Objective');
  static String objectiveBody(AppLang l) => t(
      l,
      'มองหางานประจำสาย Software / Backend / IT Support เพื่อใช้ทักษะ Node.js + Express + PostgreSQL + Socket.io จากโปรเจกต์จริง พัฒนาระบบงานจริงให้มีประสิทธิภาพ และพร้อมเรียนรู้เทคโนโลยีใหม่ (เช่น Flutter) อย่างรวดเร็ว',
      'Seeking a full-time Software / Backend / IT Support role to apply real-project skills (Node.js, Express, PostgreSQL, Socket.io), build efficient production systems, and pick up new tech (e.g. Flutter) quickly.');
}
