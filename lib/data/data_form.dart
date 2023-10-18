class DataForm {
  String name = '';
  String account = '';
  String phone = '';
  String place = '';
  String status = '';
  String city = '';

  List<String> problemsCheckbox = [
    'فاصل',
    'كابل',
    'الانترنت ضعيف',
    'الانترنت يفصل',
    'اعدادات راوتر',
    'تغير مكان',
    'تغير مكان علي نفس السطح',
    'انتينا بدل فاقد',
    'استبدال انتينا',
    'تغيير RJ',
    'راوتر',
    'لا توجد مشكلة',
    'خظا في التوصيل',
    'عدم تعبئة الرصيد',
    'استهلاك ضعيف',
    'مشكلة كاميرات',
    'تركيبة جديدة',
    'لاتوجد رؤية',
    'عطل وصلة PoE',
    'بُعد مسافة',
    'أنتينا',
    'محول انتينا',
    'محول راوتر',
    'نقل مستخدمين',
    'Full sector',
    'Interference',
    'أعمال صيانة',
  ];

  List<bool> problemCheckboxGroup = List.generate(28, (index) => false);
  List<bool> solutionCheckboxGroup = List.generate(28, (index) => false);
}
