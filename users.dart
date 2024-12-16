import 'dart:convert'; // استيراد مكتبة تحويل البيانات بين JSON وكائنات Dart

// دالة لتحويل سلسلة JSON إلى كائن من نوع Users
Users usersFromMap(String str) => Users.fromMap(json.decode(str));

// دالة لتحويل كائن من نوع Users إلى سلسلة JSON
String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? id; // معرف المستخدم، يمكن أن يكون فارغًا
  String username; // اسم المستخدم
  String password; // كلمة المرور
  String? gender; // إضافة خاصية الجنس، يمكن أن تكون فارغة

  // Constructor لإنشاء كائن من نوع Users
  Users({
    this.id, // يمكن أن يكون معرف المستخدم فارغًا
    required this.username, // اسم المستخدم مطلوب
    required this.password, // كلمة المرور مطلوبة
    this.gender, // الجنس اختياري
  });

  // تحويل الـ JSON إلى كائن Users
  factory Users.fromMap(Map<String, dynamic> json) => Users(
    id: json["id"], // تحويل قيمة id من الـ JSON إلى الخاصية id في الكائن
    username: json["username"], // تحويل قيمة username من الـ JSON إلى الخاصية username في الكائن
    password: json["password"], // تحويل قيمة password من الـ JSON إلى الخاصية password في الكائن
    gender: json["gender"], // تحويل قيمة gender من الـ JSON إلى الخاصية gender في الكائن
  );

  // تحويل كائن Users إلى Map
  Map<String, dynamic> toMap() => {
    "id": id, // تحويل الخاصية id إلى قيمة في الـ Map
    "username": username, // تحويل الخاصية username إلى قيمة في الـ Map
    "password": password, // تحويل الخاصية password إلى قيمة في الـ Map
    "gender": gender, // تحويل الخاصية gender إلى قيمة في الـ Map
  };
}
