import 'package:flutter/material.dart';
import 'package:myapp/locale_provider.dart';
import 'package:provider/provider.dart';

class AppTexts {
  final Locale locale;

  AppTexts(this.locale);

  static AppTexts of(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    return AppTexts(provider.locale);
  }

  static const LocalizationsDelegate<AppTexts> delegate = _AppTextsDelegate();

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'level': 'Level',
      'score': 'Score',
      'next': 'Next',
      'youWin': 'You Win!',
      'yourScore': 'Your Score:',
      'levelComplete': 'Level Complete',
      'selectMode': 'Appearance',
      'darkMode': 'Dark Mode',
      'addMedication': 'Add Medication',
      'medicationName': 'Medication Name',
      'medicationType': 'Medication Type',
      'pillsName': "Pill's Name",
      'date': 'Date',
      'startDate': 'Start Date',
      'endDate': 'End Date',
      'pleaseEnterA': 'Please enter a',
      'selectMedication': 'Select Medication',
      'pills': 'Pills',
      'dose': 'Dose',
      'tablet': 'Tablet',
      'ml': 'ml',
      'setFrequency': 'Set Frequency',
      'daily': 'Daily',
      'weekly': 'Weekly',
      'scheduleTime': 'Schedule Time',
      'done': 'Done',
      'cancel': 'Cancel',
      'medicationReminder': 'Medication Reminder',
      'itsTimeToTakeYour': "It's time to take your",
      'pressTheButtonAndStartSpeaking': 'Press the button and start speaking',
      'remindMeToTake': 'remind me to take',
      'at': ' at ',
      'auraCare': 'AuraCare',
      'reminder': 'Reminder',
      'aiChat': 'AI Chat',
      'healthCare': 'HealthCare',
      'music': 'Music',
      'game': 'Game',
      'faq': 'FAQ',
      'home': 'Home',
      'settings': 'Settings',
      'appInfo': 'App Info',
      'thisIsTheInformationPage': 'This is the Information Page.',
      'selectLanguage': 'Select Language',
      'english': 'English',
      'bahasaMelayu': 'Bahasa Melayu',
      'language': 'Language',
      'today': 'Today',
      'addMedicine': '+ Add Medicine',
      'sun': 'Sun',
      'mon': 'Mon',
      'tue': 'Tue',
      'wed': 'Wed',
      'thu': 'Thu',
      'fri': 'Fri',
      'sat': 'Sat',
      'noReminder': 'No Reminder',
      'noMedicationScheduleForToday': 'No Medication schedule for today',
      'missed': 'Missed',
      'upcoming': 'Upcoming',
      'taken': 'Taken',
      'notifications': 'Notifications',
      'privacy': 'Privacy',
      'tapToContinue': 'Tap to continue',
      'capsule': 'Capsule',
      'liquid': 'Liquid',
      'lotion': 'Lotion',
      'spray': 'Spray',
      'ointment': 'Ointment',
      'drops': 'Drops',
      'gel': 'Gel',
      'suppository': 'Suppository',
      'injection': 'Injection',
      'cream': 'Cream',
      'powder': 'Powder',
      'M': 'M',
      'T': 'T',
      'W': 'W',
      'F': 'F',
      'S': 'S',
      'frequentlyAskedQuestions': 'Frequently Asked Questions',
      'whoIsConsideredAnElderlyPerson': 'Who is considered an elderly person?',
      'whoIsConsideredAnElderlyPersonAnswer':
          'An elderly person is generally someone aged 60 years or older. Aging is a natural part of life, and everyone experiences it differently.',
      'whatAreCommonChallengesFacedByElderlyPeople':
          'What are common challenges faced by elderly people?',
      'whatAreCommonChallengesFacedByElderlyPeopleAnswer':
          'Some common challenges include:\n\n- Feeling lonely or isolated\n- Memory changes\n- Reduced mobility or physical strength\n- Managing health conditions\n- Difficulty using new technology\n\nNot everyone faces the same challenges, and many older adults remain active and independent.',
      'whyIsCompanionshipImportantForElderlyPeople':
          'Why is companionship important for elderly people?',
      'whyIsCompanionshipImportantForElderlyPeopleAnswer':
          'Companionship helps reduce loneliness, improves emotional well-being, and supports mental health. Regular interaction can help elderly people feel valued, heard, and connected.',
      'doElderlyPeopleNeedConstantHelp':
          'Do elderly people need constant help?',
      'doElderlyPeopleNeedConstantHelpAnswer':
          'Not always. Many elderly individuals are independent and capable. Support should be based on personal needs and provided with respect and dignity.',
      'howCanElderlyPeopleStayMentallyActive':
          'How can elderly people stay mentally active?',
      'howCanElderlyPeopleStayMentallyActiveAnswer':
          'They can stay mentally active by:\n\n- Talking regularly with others\n- Reading or listening to stories\n- Playing simple games or puzzles\n- Learning new things at their own pace\n\nMental activity helps keep the mind sharp and engaged.',
      'isForgetfulnessNormalInOldAge': 'Is forgetfulness normal in old age?',
      'isForgetfulnessNormalInOldAgeAnswer':
          'Mild forgetfulness can be a normal part of aging. However, frequent or severe memory problems should be discussed with a healthcare professional.',
      'howCanElderlyPeopleStayEmotionallyHealthy':
          'How can elderly people stay emotionally healthy?',
      'howCanElderlyPeopleStayEmotionallyHealthyAnswer':
          'Emotional health can be supported through:\n\n- Regular conversation and social interaction\n- Feeling listened to and respected\n- Maintaining daily routines\n- Having access to a supportive companion when needed',
      'whyIsPatienceImportantWhenInteractingWithElderlyPeople':
          'Why is patience important when interacting with elderly people?',
      'whyIsPatienceImportantWhenInteractingWithElderlyPeopleAnswer':
          'Aging may slow down thinking, movement, or hearing. Patience shows respect and helps elderly individuals feel comfortable and confident.',
      'canElderlyPeopleLearnNewThings': 'Can elderly people learn new things?',
      'canElderlyPeopleLearnNewThingsAnswer':
          'Yes. Elderly people can continue learning throughout life. Learning may take more time, but it can be enjoyable and rewarding.',
      'howCanTechnologySupportElderlyPeople':
          'How can technology support elderly people?',
      'howCanTechnologySupportElderlyPeopleAnswer':
          'Technology can help elderly people by:\n\n- Providing companionship\n- Offering reminders and guidance\n- Helping them stay connected with loved ones\n- Supporting independence in daily life',
      'fruits': 'Fruits',
      'animals': 'Animals',
      'vehicles': 'Vehicles',
      'shapes': 'Shapes',
      'colors': 'Colors',
      'numbers': 'Numbers',
      'memoryGame': 'Memory Game',
      'time': 'Time',
      'moves': 'Moves',
      'congratulations': 'Congratulations!',
      'youWonIn': 'You won in',
      'movesAnd': 'moves and',
      'playAgain': 'Play Again',
      'resetGame': 'Reset Game',
      'startGame': 'Start Game',
      'testNotification': 'Test Notification',
      'notificationsWorking': 'If you see this, notifications are working!',
      'chooseTheme': 'Choose a Theme',
      'nameTheMedicationType': 'Name the Medication Type',
      'quantity': 'Quantity',
    },
    'ms': {
      'level': 'Tahap',
      'score': 'Skor',
      'next': 'Seterusnya',
      'youWin': 'Anda Menang!',
      'yourScore': 'Skor Anda:',
      'levelComplete': 'Tahap Selesai',
      'selectMode': 'Penampilan',
      'darkMode': 'Mod Gelap',
      'addMedication': 'Tambah Ubat',
      'medicationName': 'Nama Ubat',
      'medicationType': 'Jenis Ubat',
      'pillsName': "Nama Pil",
      'date': 'Tarikh',
      'startDate': 'Tarikh Mula',
      'endDate': 'Tarikh Tamat',
      'pleaseEnterA': 'Sila masukkan',
      'selectMedication': 'Pilih Ubat',
      'pills': 'Pil',
      'dose': 'Dos',
      'tablet': 'Tablet',
      'ml': 'ml',
      'setFrequency': 'Tetapkan Kekerapan',
      'daily': 'Setiap Hari',
      'weekly': 'Setiap Minggu',
      'scheduleTime': 'Jadualkan Masa',
      'done': 'Selesai',
      'cancel': 'Batal',
      'medicationReminder': 'Peringatan Ubat',
      'itsTimeToTakeYour': "Masa untuk mengambil",
      'pressTheButtonAndStartSpeaking': 'Tekan butang dan mula bercakap',
      'remindMeToTake': 'ingatkan saya untuk mengambil',
      'at': ' pada ',
      'auraCare': 'AuraCare',
      'reminder': 'Peringatan',
      'aiChat': 'Sembang AI',
      'healthCare': 'Penjagaan Kesihatan',
      'music': 'Muzik',
      'game': 'Permainan',
      'faq': 'Soalan Lazim',
      'home': 'Laman Utama',
      'settings': 'Tetapan',
      'appInfo': 'Info Aplikasi',
      'thisIsTheInformationPage': 'Ini adalah Halaman Maklumat.',
      'selectLanguage': 'Pilih Bahasa',
      'english': 'English',
      'bahasaMelayu': 'Bahasa Melayu',
      'language': 'Bahasa',
      'today': 'Hari Ini',
      'addMedicine': '+ Tambah Ubat',
      'sun': 'Aha',
      'mon': 'Isn',
      'tue': 'Sel',
      'wed': 'Rab',
      'thu': 'Kha',
      'fri': 'Jum',
      'sat': 'Sab',
      'noReminder': 'Tiada Peringatan',
      'noMedicationScheduleForToday': 'Tiada jadual ubat untuk hari ini',
      'missed': 'Terlepas',
      'upcoming': 'Akan Datang',
      'taken': 'Diambil',
      'notifications': 'Pemberitahuan',
      'privacy': 'Privasi',
      'tapToContinue': 'Ketik untuk meneruskan',
      'capsule': 'Kapsul',
      'liquid': 'Cecair',
      'lotion': 'Losyen',
      'spray': 'Semburan',
      'ointment': 'Salap',
      'drops': 'Titisan',
      'gel': 'Gel',
      'suppository': 'Suppositori',
      'injection': 'Suntikan',
      'cream': 'Krim',
      'powder': 'Serbuk',
      'M': 'I',
      'T': 'S',
      'W': 'R',
      'F': 'J',
      'S': 'S',
      'frequentlyAskedQuestions': 'Soalan Lazim',
      'whoIsConsideredAnElderlyPerson':
          'Siapakah yang dianggap sebagai warga emas?',
      'whoIsConsideredAnElderlyPersonAnswer':
          'Warga emas secara amnya adalah seseorang yang berumur 60 tahun ke atas. Penuaan adalah sebahagian daripada kehidupan semula jadi, dan setiap orang mengalaminya secara berbeza.',
      'whatAreCommonChallengesFacedByElderlyPeople':
          'Apakah cabaran biasa yang dihadapi oleh warga emas?',
      'whatAreCommonChallengesFacedByElderlyPeopleAnswer':
          'Beberapa cabaran biasa termasuk:\n\n- Rasa sunyi atau terasing\n- Perubahan ingatan\n- Mobiliti atau kekuatan fizikal yang berkurangan\n- Menguruskan keadaan kesihatan\n- Kesukaran menggunakan teknologi baharu\n\nTidak semua orang menghadapi cabaran yang sama, dan ramai orang dewasa yang lebih tua kekal aktif dan berdikari.',
      'whyIsCompanionshipImportantForElderlyPeople':
          'Mengapakah persahabatan penting untuk warga emas?',
      'whyIsCompanionshipImportantForElderlyPeopleAnswer':
          'Persahabatan membantu mengurangkan kesunyian, meningkatkan kesejahteraan emosi, dan menyokong kesihatan mental. Interaksi yang kerap dapat membantu warga emas berasa dihargai, didengari dan berhubung.',
      'doElderlyPeopleNeedConstantHelp':
          'Adakah warga emas memerlukan bantuan berterusan?',
      'doElderlyPeopleNeedConstantHelpAnswer':
          'Tidak selalu. Ramai individu warga emas berdikari dan berkebolehan. Sokongan harus berdasarkan keperluan peribadi dan diberikan dengan rasa hormat dan maruah.',
      'howCanElderlyPeopleStayMentallyActive':
          'Bagaimanakah warga emas boleh kekal aktif secara mental?',
      'howCanElderlyPeopleStayMentallyActiveAnswer':
          'Mereka boleh kekal aktif dari segi mental dengan:\n\n- Bercakap secara kerap dengan orang lain\n- Membaca atau mendengar cerita\n- Bermain permainan atau teka-teki mudah\n- Mempelajari perkara baharu mengikut rentak mereka sendiri\n\nAktiviti mental membantu mengekalkan minda yang tajam dan sentiasa terlibat.',
      'isForgetfulnessNormalInOldAge':
          'Adakah kelupaan itu normal pada usia tua?',
      'isForgetfulnessNormalInOldAgeAnswer':
          'Kelupaan ringan boleh menjadi sebahagian biasa penuaan. Walau bagaimanapun, masalah ingatan yang kerap atau teruk perlu dibincangkan dengan profesional penjagaan kesihatan.',
      'howCanElderlyPeopleStayEmotionallyHealthy':
          'Bagaimanakah warga emas boleh kekal sihat dari segi emosi?',
      'howCanElderlyPeopleStayEmotionallyHealthyAnswer':
          'Kesihatan emosi boleh disokong melalui:\n\n- Perbualan dan interaksi sosial yang kerap\n- Rasa didengari dan dihormati\n- Mengekalkan rutin harian\n- Mempunyai akses kepada sokongan emosi apabila diperlukan',
      'whyIsPatienceImportantWhenInteractingWithElderlyPeople':
          'Mengapakah kesabaran penting apabila berinteraksi dengan warga emas?',
      'whyIsPatienceImportantWhenInteractingWithElderlyPeopleAnswer':
          'Penuaan boleh melambatkan pemikiran, pergerakan atau pendengaran. Kesabaran menunjukkan rasa hormat dan membantu individu warga emas berasa selesa dan yakin.',
      'canElderlyPeopleLearnNewThings':
          'Bolehkah warga emas mempelajari perkara baharu?',
      'canElderlyPeopleLearnNewThingsAnswer':
          'Ya. Warga emas boleh terus belajar sepanjang hayat. Pembelajaran mungkin mengambil lebih banyak masa, tetapi ia boleh menjadi menyeronokkan dan bermanfaat.',
      'howCanTechnologySupportElderlyPeople':
          'Bagaimanakah teknologi boleh menyokong warga emas?',
      'howCanTechnologySupportElderlyPeopleAnswer':
          'Teknologi boleh membantu warga emas dengan:\n\n- Menyediakan persahabatan\n- Menawarkan peringatan dan bimbingan\n- Membantu mereka kekal berhubung dengan orang tersayang\n- Menyokong kebebasan dalam kehidupan seharian',
      'fruits': 'Buah-buahan',
      'animals': 'Haiwan',
      'vehicles': 'Kenderaan',
      'shapes': 'Bentuk',
      'colors': 'Warna',
      'numbers': 'Nombor',
      'memoryGame': 'Permainan Memori',
      'time': 'Masa',
      'moves': 'Langkah',
      'congratulations': 'Tahniah!',
      'youWonIn': 'Anda menang dalam',
      'movesAnd': 'langkah dan',
      'playAgain': 'Main Semula',
      'resetGame': 'Tetapkan Semula Permainan',
      'startGame': 'Mulakan Permainan',
      'testNotification': 'Pemberitahuan Ujian',
      'notificationsWorking': 'Jika anda melihat ini, pemberitahuan berfungsi!',
      'chooseTheme': 'Pilih Tema',
      'nameTheMedicationType': 'Namakan Jenis Ubat',
      'quantity': 'Kuantiti',
    },
  };

  String get level => _localizedValues[locale.languageCode]!['level']!;
  String get score => _localizedValues[locale.languageCode]!['score']!;
  String get next => _localizedValues[locale.languageCode]!['next']!;
  String get youWin => _localizedValues[locale.languageCode]!['youWin']!;
  String get yourScore => _localizedValues[locale.languageCode]!['yourScore']!;
  String get levelComplete =>
      _localizedValues[locale.languageCode]!['levelComplete']!;

  String get selectMode =>
      _localizedValues[locale.languageCode]!['selectMode']!;
  String get darkMode => _localizedValues[locale.languageCode]!['darkMode']!;

  String get addMedication =>
      _localizedValues[locale.languageCode]!['addMedication']!;
  String get medicationName =>
      _localizedValues[locale.languageCode]!['medicationName']!;
  String get medicationType =>
      _localizedValues[locale.languageCode]!['medicationType']!;
  String get pillsName => _localizedValues[locale.languageCode]!['pillsName']!;
  String get date => _localizedValues[locale.languageCode]!['date']!;
  String get startDate => _localizedValues[locale.languageCode]!['startDate']!;
  String get endDate => _localizedValues[locale.languageCode]!['endDate']!;
  String get pleaseEnterA =>
      _localizedValues[locale.languageCode]!['pleaseEnterA']!;
  String get selectMedication =>
      _localizedValues[locale.languageCode]!['selectMedication']!;
  String get pills => _localizedValues[locale.languageCode]!['pills']!;
  String get dose => _localizedValues[locale.languageCode]!['dose']!;
  String get tablet => _localizedValues[locale.languageCode]!['tablet']!;
  String get ml => _localizedValues[locale.languageCode]!['ml']!;
  String get setFrequency =>
      _localizedValues[locale.languageCode]!['setFrequency']!;
  String get daily => _localizedValues[locale.languageCode]!['daily']!;
  String get weekly => _localizedValues[locale.languageCode]!['weekly']!;
  String get scheduleTime =>
      _localizedValues[locale.languageCode]!['scheduleTime']!;
  String get done => _localizedValues[locale.languageCode]!['done']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get medicationReminder =>
      _localizedValues[locale.languageCode]!['medicationReminder']!;
  String get itsTimeToTakeYour =>
      _localizedValues[locale.languageCode]!['itsTimeToTakeYour']!;
  String get pressTheButtonAndStartSpeaking =>
      _localizedValues[locale.languageCode]!['pressTheButtonAndStartSpeaking']!;
  String get remindMeToTake =>
      _localizedValues[locale.languageCode]!['remindMeToTake']!;
  String get at => _localizedValues[locale.languageCode]!['at']!;
  String get auraCare => _localizedValues[locale.languageCode]!['auraCare']!;
  String get reminder => _localizedValues[locale.languageCode]!['reminder']!;
  String get aiChat => _localizedValues[locale.languageCode]!['aiChat']!;
  String get healthCare =>
      _localizedValues[locale.languageCode]!['healthCare']!;
  String get music => _localizedValues[locale.languageCode]!['music']!;
  String get game => _localizedValues[locale.languageCode]!['game']!;
  String get faq => _localizedValues[locale.languageCode]!['faq']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get appInfo => _localizedValues[locale.languageCode]!['appInfo']!;
  String get thisIsTheInformationPage =>
      _localizedValues[locale.languageCode]!['thisIsTheInformationPage']!;
  String get selectLanguage =>
      _localizedValues[locale.languageCode]!['selectLanguage']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get bahasaMelayu =>
      _localizedValues[locale.languageCode]!['bahasaMelayu']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get today => _localizedValues[locale.languageCode]!['today']!;
  String get addMedicine =>
      _localizedValues[locale.languageCode]!['addMedicine']!;
  String get sun => _localizedValues[locale.languageCode]!['sun']!;
  String get mon => _localizedValues[locale.languageCode]!['mon']!;
  String get tue => _localizedValues[locale.languageCode]!['tue']!;
  String get wed => _localizedValues[locale.languageCode]!['wed']!;
  String get thu => _localizedValues[locale.languageCode]!['thu']!;
  String get fri => _localizedValues[locale.languageCode]!['fri']!;
  String get sat => _localizedValues[locale.languageCode]!['sat']!;
  String get noReminder =>
      _localizedValues[locale.languageCode]!['noReminder']!;
  String get noMedicationScheduleForToday =>
      _localizedValues[locale.languageCode]!['noMedicationScheduleForToday']!;
  String get missed => _localizedValues[locale.languageCode]!['missed']!;
  String get upcoming => _localizedValues[locale.languageCode]!['upcoming']!;
  String get taken => _localizedValues[locale.languageCode]!['taken']!;
  String get notifications =>
      _localizedValues[locale.languageCode]!['notifications']!;
  String get privacy => _localizedValues[locale.languageCode]!['privacy']!;
  String get tapToContinue =>
      _localizedValues[locale.languageCode]!['tapToContinue']!;
  String get capsule => _localizedValues[locale.languageCode]!['capsule']!;
  String get liquid => _localizedValues[locale.languageCode]!['liquid']!;
  String get lotion => _localizedValues[locale.languageCode]!['lotion']!;
  String get spray => _localizedValues[locale.languageCode]!['spray']!;
  String get ointment => _localizedValues[locale.languageCode]!['ointment']!;
  String get drops => _localizedValues[locale.languageCode]!['drops']!;
  String get gel => _localizedValues[locale.languageCode]!['gel']!;
  String get suppository =>
      _localizedValues[locale.languageCode]!['suppository']!;
  String get injection => _localizedValues[locale.languageCode]!['injection']!;
  String get cream => _localizedValues[locale.languageCode]!['cream']!;
  String get powder => _localizedValues[locale.languageCode]!['powder']!;
  String get M => _localizedValues[locale.languageCode]!['M']!;
  String get T => _localizedValues[locale.languageCode]!['T']!;
  String get W => _localizedValues[locale.languageCode]!['W']!;
  String get F => _localizedValues[locale.languageCode]!['F']!;
  String get S => _localizedValues[locale.languageCode]!['S']!;
  String get frequentlyAskedQuestions =>
      _localizedValues[locale.languageCode]!['frequentlyAskedQuestions']!;
  String get whoIsConsideredAnElderlyPerson =>
      _localizedValues[locale.languageCode]!['whoIsConsideredAnElderlyPerson']!;
  String get whoIsConsideredAnElderlyPersonAnswer => _localizedValues[
      locale.languageCode]!['whoIsConsideredAnElderlyPersonAnswer']!;
  String get whatAreCommonChallengesFacedByElderlyPeople => _localizedValues[
      locale.languageCode]!['whatAreCommonChallengesFacedByElderlyPeople']!;
  String get whatAreCommonChallengesFacedByElderlyPeopleAnswer =>
      _localizedValues[locale
          .languageCode]!['whatAreCommonChallengesFacedByElderlyPeopleAnswer']!;
  String get whyIsCompanionshipImportantForElderlyPeople => _localizedValues[
      locale.languageCode]!['whyIsCompanionshipImportantForElderlyPeople']!;
  String get whyIsCompanionshipImportantForElderlyPeopleAnswer =>
      _localizedValues[locale
          .languageCode]!['whyIsCompanionshipImportantForElderlyPeopleAnswer']!;
  String get doElderlyPeopleNeedConstantHelp => _localizedValues[
      locale.languageCode]!['doElderlyPeopleNeedConstantHelp']!;
  String get doElderlyPeopleNeedConstantHelpAnswer => _localizedValues[
      locale.languageCode]!['doElderlyPeopleNeedConstantHelpAnswer']!;
  String get howCanElderlyPeopleStayMentallyActive => _localizedValues[
      locale.languageCode]!['howCanElderlyPeopleStayMentallyActive']!;
  String get howCanElderlyPeopleStayMentallyActiveAnswer => _localizedValues[
      locale.languageCode]!['howCanElderlyPeopleStayMentallyActiveAnswer']!;
  String get isForgetfulnessNormalInOldAge =>
      _localizedValues[locale.languageCode]!['isForgetfulnessNormalInOldAge']!;
  String get isForgetfulnessNormalInOldAgeAnswer => _localizedValues[
      locale.languageCode]!['isForgetfulnessNormalInOldAgeAnswer']!;
  String get howCanElderlyPeopleStayEmotionallyHealthy => _localizedValues[
      locale.languageCode]!['howCanElderlyPeopleStayEmotionallyHealthy']!;
  String get howCanElderlyPeopleStayEmotionallyHealthyAnswer =>
      _localizedValues[locale
          .languageCode]!['howCanElderlyPeopleStayEmotionallyHealthyAnswer']!;
  String get whyIsPatienceImportantWhenInteractingWithElderlyPeople =>
      _localizedValues[locale
          .languageCode]!['whyIsPatienceImportantWhenInteractingWithElderlyPeople']!;
  String get whyIsPatienceImportantWhenInteractingWithElderlyPeopleAnswer =>
      _localizedValues[locale
          .languageCode]!['whyIsPatienceImportantWhenInteractingWithElderlyPeopleAnswer']!;
  String get canElderlyPeopleLearnNewThings =>
      _localizedValues[locale.languageCode]!['canElderlyPeopleLearnNewThings']!;
  String get canElderlyPeopleLearnNewThingsAnswer => _localizedValues[
      locale.languageCode]!['canElderlyPeopleLearnNewThingsAnswer']!;
  String get howCanTechnologySupportElderlyPeople => _localizedValues[
      locale.languageCode]!['howCanTechnologySupportElderlyPeople']!;
  String get howCanTechnologySupportElderlyPeopleAnswer => _localizedValues[
      locale.languageCode]!['howCanTechnologySupportElderlyPeopleAnswer']!;

  String get fruits => _localizedValues[locale.languageCode]!['fruits']!;
  String get animals => _localizedValues[locale.languageCode]!['animals']!;
  String get vehicles => _localizedValues[locale.languageCode]!['vehicles']!;
  String get shapes => _localizedValues[locale.languageCode]!['shapes']!;
  String get colors => _localizedValues[locale.languageCode]!['colors']!;
  String get numbers => _localizedValues[locale.languageCode]!['numbers']!;
  String get memoryGame =>
      _localizedValues[locale.languageCode]!['memoryGame']!;
  String get time => _localizedValues[locale.languageCode]!['time']!;
  String get moves => _localizedValues[locale.languageCode]!['moves']!;
  String get congratulations =>
      _localizedValues[locale.languageCode]!['congratulations']!;
  String get youWonIn => _localizedValues[locale.languageCode]!['youWonIn']!;
  String get movesAnd => _localizedValues[locale.languageCode]!['movesAnd']!;
  String get playAgain => _localizedValues[locale.languageCode]!['playAgain']!;
  String get resetGame => _localizedValues[locale.languageCode]!['resetGame']!;
  String get startGame => _localizedValues[locale.languageCode]!['startGame']!;
  String get chooseTheme =>
      _localizedValues[locale.languageCode]!['chooseTheme']!;

  String get testNotification =>
      _localizedValues[locale.languageCode]!['testNotification']!;
  String get notificationsWorking =>
      _localizedValues[locale.languageCode]!['notificationsWorking']!;
  String get nameTheMedicationType =>
      _localizedValues[locale.languageCode]!['nameTheMedicationType']!;
  String get quantity => _localizedValues[locale.languageCode]!['quantity']!;
}

class _AppTextsDelegate extends LocalizationsDelegate<AppTexts> {
  const _AppTextsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ms'].contains(locale.languageCode);
  }

  @override
  Future<AppTexts> load(Locale locale) async {
    return AppTexts(locale);
  }

  @override
  bool shouldReload(_AppTextsDelegate old) => false;
}
