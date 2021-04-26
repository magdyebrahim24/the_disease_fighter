import 'languages.dart';

class LanguageAr extends Languages {
  @override
  Map get setting => {
        'labelSelectLanguage': "اختار اللغة",
        'settingLabel': 'الاعدادات',
        'password': 'تغيير كلمة المرور',
        'notification': 'الاشعارات',
        'language': 'اللغة',
        'logOut': 'تسجيل الخروج',
        'faceBook': 'الفيس بوك',
        'twitter': 'تويتر',
        'whatsApp': 'واتساب',
        'shareApp': 'مشاركة الابلكيشن'
      };

  @override
  Map get changePassword => {
        'oldPasswordLabel': 'كلمة المرور القديمة',
        'oldPasswordHint': 'ادخل كلمة المرور القديمة',
        'newPasswordLabel': 'كلمة المرور الجديدة',
        'newPasswordHint': 'ادخل كلمة المرور الجديدة',
        'confirmPasswordLabel': 'تاكيد كلمة المرور',
        'ConfirmPasswordHint': 'اعد ادخال كلمة المرور',
        'doneBtn': 'تغيير',
      };

  @override
  List get introInformation => [
        {
          'headTxt': 'التشخيص الاولى باستخدام الذكاء الاصطناعى',
          'subTxt':
              'يرجع التشخيص الأولي للمرض باستخدام الذكاء الاصطناعى إلى تحليل الإشاعات وتحليلات المريض .'
        },
        {
          'headTxt': 'سهولة الحجز والترشيح',
          'subTxt':
              'مساعدة المرضى بالحجز بسهولة وترشيح الطبيب المناسب من خلال أعراض المريض .'
        },
        {
          'headTxt': 'الاحتفاظ بالبيانات السابقة',
          'subTxt': 'الاحتفاظ بجميع بيانات وتحليلات و تشخيصات المريض السابقة.'
        },
      ];

  @override
  String get introSkip => 'تخطى';

  @override
  Map get signIn => {
        'welcome': 'اهلا بعودتك!',
        'email': 'البريد الالكترونى',
        'emailHint': 'من فضلك ادخل الاميل',
        'password': 'كلمة المرور',
        'passwordHint': 'من فضلك ادخل كلمة المرور',
        'forgetPassword': 'نسيت كلمة المرور',
        'signButtonTxt': 'تسجيل الدخول',
        'orSignWith': 'أو سجل من خلال',
        'dontHaveAccount': 'ليس لديك حساب',
        'signUpTxt': 'انشاء حساب'
      };

  Map get forgetPasswordScreen => {
        'header': 'نسيت كلمة المرور ؟',
        'emailSubTxt': 'ادخل بريدك الالكترونى وسوف نرسل لك \n كود عبر البريد.',
        'emailLabel': "البريد الالكترونى",
        'emailHint': "ادخل بريدك الالكترونى",
        'nextBTN': 'التالى',
        'dontHaveAccount': 'ليس لديك حساب',
        'signUpTxt': 'انشاء حساب',
        'codeSubTxt': 'من فضلك ادخل الكود الذى استلمته فى بريدك الالكترونى .',
        'codeLabel': 'الكود',
        'CodeHint': 'ادخل الكود',
        'verifyBTN': 'تحقق',
        'passwordLabel': 'كلمة المرور',
        'passwordHint': 'من فضلك ادخل كلمة المرور',
        'confirmPassword': 'تاكيد كلمة المرور',
        'confirmPasswordHint': 'ادخل كلمة المرور مرة اخرى',
        'newPassHint': 'اكتب كلمة المرور الجديدة',
        'changeBTN': 'تغيير'
      };

  @override
  Map get signUp => {
        'doctorBTN': 'دكتور',
        'patientBTN': 'مريض',
        'name': 'الاسم',
        'nameHint': 'من فضلك ادخل اسمك',
        'email': 'البريد الالكترونى',
        'emailHint': 'من فضلك ادخل البريد',
        'password': 'كلمة المرور',
        'passwordHint': 'من فضلك ادخل كلمة المرور',
        'confirmPassword': 'تاكيد كلمة المرور',
        'confirmPasswordHint': 'ادخل كلمة المرور مرة اخرى',
        'signButtonTxt': 'انشاء حساب',
        'orSignWith': 'أو انشىء حساب من خلال',
        'dontHaveAccount': 'لديك حساب بالفعل',
        'signUpTxt': 'سجل دخول'
      };

  @override
  Map get signUpPatientInfo => {
        'header': 'أنت على وشك الإنتهاء!',
        'addressLabel': 'العنوان',
        'addressHint': 'من فضلك ادخل عنوانك',
        'phoneLabel': 'رقم الهاتف',
        'phoneHint': 'من فضلك ادخل رقم الهاتف',
        'DateLabel': 'تاريخ الميلاد',
        'helperText': 'اختر تاريخ ميلادك',
        'genderLabel': 'النوع',
        'genderHint': 'اختر نوعك',
        'subText': 'بالضغط على "القيام به" أنت توافق على',
        'terms': 'البنود و الشروط',
        'done': 'الانتهاء'
      };

  @override
  Map get signUpDoctorInfo => {
        'header': 'أنت على وشك الإنتهاء!',
        'phoneLabel': 'رقم الهاتف',
        'phoneHint': 'من فضلك ادخل رقم الهاتف',
        'genderLabel': 'النوع',
        'genderHint': 'اختر نوعك',
        'DateLabel': 'تاريخ الميلاد',
        'helperText': 'اختر تاريخ ميلادك',
        'specialistLabel': 'التخصص',
        'specialistHint': 'اختر تخصصك',
        'clinicLocationLabel': 'عنوان العيادة',
        'clinicLocationHint': 'ادخل عنوان العيادة',
        'clinicDaterHeader': 'أدخل مواعيد العيادة المتاحة',
        'clinicOpen': 'يوم فتح العيادة :',
        'dayHint': 'اختر يوم العياده تفتح فيه',
        'from': 'من :',
        'fromHelper': 'ادخل معاد فتح العياده',
        'to': 'الى :',
        'toHelper': 'ادخل معاد اغلاق العيادة',
        'addBTN': 'اضافة',
        'subText': 'بالضغط على "القيام به" أنت توافق على',
        'terms': 'البنود و الشروط',
        'submit': 'الانتهاء'
      };

  @override
  Map get notificationScreen => {'tittle': 'الاشعارات'};

  @override
  Map get rateScreen => {
        'reviewLabel': 'تقييم',
        'reviewHint': "من فضلك اكتب تقييمك عن اداء الدكتور .",
        'done': "تـم",
      };

  @override
  Map get patientHome => {
        'clinics': 'العيادات',
        'viewAllBTN': 'المزيد',
        'topDoctors': 'أفضل الأطباء',
        'snackBarLabel': 'تم الحجز',
        'snackBarBTN': 'عرض',
      };

  @override
  Map get allClinicsScreen => {
        'tittle': 'كل العيادات',
        'brain': 'عيادة المخ',
        'brainDoctors': 'دكاترة المخ',
        'chest': 'عيادة الصدر',
        'chestDoctors': 'دكاتر ة الصدر',
        'physical': 'عيادة العلاج الطبيعى',
        'physicalDoctors': 'دكاترة العلاج الطبيعى',
        'bone': 'عيادة العظام',
        'boneDoctors': 'دكاترة العظام',
        'urology': 'عيادة المسالك البولية',
        'urologyDoctors': 'دكاترة المسالك البولية',
        'surgery': 'عيادة الجراحه',
        'surgeryDoctors': 'دكاترة الجراحه',
        'teeth': 'عيادة الاسنان',
        'teethDoctors': 'دكاترة الاسنان',
        'internal': 'عيادة الباطنة',
        'internalDoctors': 'دكاترة الباطنة',
        'heart': 'عيادة القلب',
        'heartDoctors': 'دكاترة القلب',
        'kids': 'عيادة الاطفال',
        'kidsDoctors': 'دكاترة الاطفال',
        'dermatology': 'عيادة الجلدية',
        'dermatologyDoctors': 'دكاترة الجلدية',
        'mlHeader': 'تحليل باستخدام الذكاء الاصطناعى',
      };

  @override
  Map get doctorDetails => {
        'about': 'نبذه',
        'clinicAppointments': 'مواعيد العيادة',
        'patientReviews': 'تقييمات المرضى',
        'bookBtn': 'حجز معاد',
        'snackBarAddLabel': 'ضيفت لقائمة المفضلة',
        'snackBarAddBTN': 'عرض',
        'snackBarRemove': 'حذفت من  قائمة المفضلة',
        'reviewsTittle': 'التقييمات',
      };

  @override
  Map get drawer => {
        'menu': 'القائمة',
        'appointments': 'مواعيدى',
        'profile': 'الملف الشخصى',
        'favoriteDoc': 'الدكاترة المفضلة',
        'setting': 'الاعدادات',
        'about': 'عن الابلكيشن',
        'usingAi': 'استخدم الذكاء الاصطناعى',
      };

  @override
  String get search => 'ابحث عن طبيب ...';

  @override
  Map get bookAppointment => {
        'appointmentDateLabel': 'تاريخ الموعد',
        'appointmentDateHint': 'اختر تاريخ الموعد',
        'appointmentTimeLabel': 'وقت الموعد',
        'appointmentTimeHint': 'اوقات العيادة المتاحة',
        'nameLabel': 'الاسم',
        'nameHint': 'اكتب اسم المريض',
        'genderLabel': 'النوع',
        'genderHint': 'نوع..',
        'phoneLabel': 'رقم الهاتف',
        'phoneHint': 'ادخل رقم الهاتف',
        'appointmentNote': 'ملاحظة',
        'appointmentNoteHint': "اكتب ملاحظتك ...",
        'bookBTN': 'احجز المعاد',
        'editBTN': 'تعديل',
        'deleteBTN': 'حذف',
        'cancelBtn': 'الغاء',
        'saveBTN': 'حفظ'
      };

  @override
  Map get allDoctors => {
        'all': 'الكل',
        'brain': 'المخ',
        'chest': 'الصدر',
        'physical': 'العلاج الطبيعى',
        'bone': 'العظام',
        'internalMedicine': 'الباطنة',
        'surgery': 'الجراحه',
        'teeth': 'الاسنان',
        'urology': 'المسالك البولية',
        'heart': 'القلب',
        'kids': 'الاطفال',
        'dermatology': 'الجلدية',
        'bookBtn': 'حجز'
      };

  @override
  Map get patientAppointments => {
        'myAppointmentTap': 'حجوزاتى',
        'previousTap': 'السابقه',
        'detailsBTN': 'تفاصيل الحجز',
        'showMoreBTN': 'المزيد',
      };

  @override
  Map get previousAppointmentDetails => {
        'tittle': 'التفاصيل',
        'diagnosis': 'التشخيص',
        'medicines': 'الادوية',
        'files': 'الملفات'
      };

  @override
  Map get favoriteDoctors => {'tittle': 'الدكاترة المفضلة', 'bookBTN': 'حجز'};

  @override
  Map get aboutScreen => {
        'about': 'عن الابلكيشن',
        'version': 'الاصدار',
        'termsOfUse': 'تعليمات الاستخدام',
        'contactUS': 'تواصل معنا',
        'faceBook': 'فيس بوك',
        'twitter': 'تويتر',
        'gmail': 'الجميل',
        'whatsApp': 'واتساب',
      };

  @override
  Map get termsOfUse => {
        'tittle': 'تعليمات الاستخدام',
        'termsSubTxt':
            "هذه شروط الاستخدام تحكم استخدامك من MEGA MAR، وأي معلومات أو نصوص أو رسومات أو صور أو مواد أخرى تم تحميلها أو تنزيلها أو الظهور في الحل الطبي، الرجوع إلى هذه الشروط. لا يمكنك استخدام الحل الطبي الخاص بنا توافق عليهم، لذا يرجى قراءتها بعناية. قبل استخدام أي من الحل الطبي، يجب عليك قراءة هذه الشروط وفهمها. يمكنك فقط الوصول إلى الحل الطبي بعد القراءة وقبول هذه الشروط الاستخدام. ",
        'privacy': 'الخصوصية',
        'privacySubTxt':
            "يتم دمج سياسة خصوصية الحل الطبي في هذه الشروط. من خلال قبول هذه الشروط، فإنك توافق على جمع المعلومات الخاصة بك واستخدامها وتبادلها من خلال الخدمات وفقا لسياسة الخصوصية",
        'userContent': 'محتوى المستخدم',
        'userContentSubTxt':
            "تتكون الخدمات من الميزات والمناطق التفاعلية التي تتيح للمستخدمين إنشاء ومحتوى نشر وإرسال و / أو تخزين المحتوى، بما في ذلك على سبيل المثال لا الحصر على الصور أو مقاطع الفيديو والنصوص أو الرسومات أو العناصر أو المواد الأخرى (مجتمعة،). أنت تفهم أن تكون مسؤولا عن جميع رسوم البيانات التي تتكبدها باستخدام الخدمات. تفهم أيضا أن محتوى المستخدم قد يكون قابلا للعرض من قبل الآخرين وأن يكون لديك القدرة على التحكم في من يمكنه الوصول إلى هذا المحتوى عن طريق ضبط إعدادات الخصوصية الخاصة بك. وموافقت على الالتزام بإرشادات مجتمعنا، والتي قد يتم تحديثها من وقت لآخر ",
        'feedback': 'تعليق',
        'feedbackSubTxt':
            "أنت توافق على أن أي ردود فعل أو اقتراحات أو أفكار أو معلومات أو مواد أخرى تتعلق بالثلوج أو الخدمات التي تقدمها، سواء عن طريق البريد الإلكتروني أو غير ذلك (ردود الفعل)، غير سرية وتصبح الملكية الوحيدة للثلوج. سنكون يحق له الحصول على الاستخدام غير المقيد ونشر هذه الملاحظات لأي غرض أو تجاري أو غير ذلك، دون الاعتراف أو تعويضك. أنت تتنازل عن أي حقوق قد تضطر إلى ردود الفعل (بما في ذلك أي حقوق نشر أو حقوق أخلاقية). نودمع الاستماع من المستخدمين، ولكن من فضلك لا تشارك أفكارك معنا إذا كنت تتوقع أن تدفع أو ترغب في مواصلة امتلاك حقوقها أو الادعاء بها فيها. ",
      };

  @override
  Map get patientProfile => {
        'email': 'البريد الالكترونى',
        'emailHint': 'من فضلك ادخل الاميل',
        'addressLabel': 'العنوان',
        'addressHint': 'من فضلك ادخل عنوانك',
        'phoneLabel': 'رقم الهاتف',
        'phoneHint': 'من فضلك ادخل رقم الهاتف',
        'DateLabel': 'تاريخ الميلاد',
        'helperText': 'اختر تاريخ ميلادك',
        'genderLabel': 'النوع',
        'genderHint': 'اختر نوعك',
        'cancelBtn': 'الغاء',
        'saveBtn': 'حفظ'
      };

  @override
  Map get doctorHome =>
      {'todayTap': 'اليوم', 'allTap': 'الكل', 'showBtn': 'عـرض'};

  @override
  Map get doctorUpcomingMeeting => {
        'tittle': 'تفاصيل الحجز',
        'delayBtn': 'تاجيل',
        'startBtn': 'يدأ المعاد',
        'about': 'عن المريض',
        'delayAlertDateLabel': 'التاريخ',
        'delayAlertDateHint': 'اختر تاريخ الميعاد',
        'delayAlertTimeLabel': 'الوقت',
        'delayAlertCancelBtn': 'الغاء',
        'delayAlertDoneBtn': 'تـم',
        'delayAlertDeleteBtn': 'حذف الميعاد',
      };

  @override
  Map get doctorStartMeeting => {
        'tittle': 'الحجز',
        'addDiagnosis': 'اضافة التشخيص',
        'addMedicine': 'اضافة الدواء',
        'addFiles': 'اضافة الملفات',
        'recentFiles': 'الملفات السابقة',
        'endBtn': 'انهاء الاجتماع',
        'endAlertTittle': "هل انت متاكد من انك تريد انهاء الاجتماع",
        'endAlertCancelBtn': "الغاء",
        'endAlertOkBtn': "حسنا",
      };

  @override
  Map get doctorProfile => {
        'ifoTap': 'معلوماتك',
        'previousTap': 'السابقة',
        'infoTapAbout': 'نبذة',
        'prevTapMoreBtn': 'المزيد',
        'editProfile': {
          'phoneLabel': 'رقم الهاتف',
          'phoneHint': 'ادخل رقم الهاتف',
          'email': 'البريد الالكترونى',
          'emailHint': 'ادخل البريد الالكترونى',
          'clinicAddressLabel': 'عنوان العيادة',
          'clinicAddressHint': 'ادخل عنوان العيادة',
          'saveBtn': 'حفظ',
          'cancelBtn': 'الغاء',
        }
      };
}
