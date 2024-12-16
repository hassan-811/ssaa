import 'dart:async'; // لاستيراد مكتبة الـ asynchronous للتعامل مع العمليات غير المتزامنة
import 'package:asd4477/json/users.dart'; // لاستيراد ملف تعريف المستخدم
import 'package:path/path.dart'; // لاستيراد مكتبة التعامل مع مسارات الملفات
import 'package:sqflite/sqflite.dart'; // لاستيراد مكتبة التعامل مع SQLite

class SqlDb {
  // الكود التالي ينشئ نسخة واحدة فقط من الكلاس SqlDb باستخدام الـ Singleton pattern
  SqlDb._privateConstructor(); // Constructor خاص لإنشاء نسخة واحدة من الكلاس
  static final SqlDb instance = SqlDb._privateConstructor(); // الكود يعين الـ instance

  final databaseName = "userdb3.db"; // تحديد اسم قاعدة البيانات

  // استعلام إنشاء الجدول الذي يحتوي على حقل الـ gender
  String user = '''
    CREATE TABLE IF NOT EXISTS users(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      username TEXT, 
      password TEXT, 
      gender TEXT 
    )
  '''; // تم إضافة حقل الجنس في الجدول هنا

  // دالة لتهيئة قاعدة البيانات
  Future<Database> initializeDb() async {
    final databasePath = await getDatabasesPath(); // الحصول على مسار قاعدة البيانات
    final path = join(databasePath, databaseName); // دمج مسار قاعدة البيانات مع اسمها
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user); // تنفيذ استعلام إنشاء الجدول إذا لم يكن موجودًا
    });
  }

  // دالة لتسجيل الدخول والتحقق من صحة بيانات المستخدم
  Future<Users> loginUser(Users usr) async {
    final Database db = await initializeDb(); // تهيئة قاعدة البيانات
    // تنفيذ استعلام للبحث عن المستخدم في قاعدة البيانات باستخدام اسم المستخدم وكلمة المرور
    final result = await db.rawQuery(
        "SELECT * FROM users WHERE username = ? AND password = ?",
        [usr.username, usr.password]); // تمرير بيانات المستخدم في الاستعلام
    if (result.isNotEmpty) { // إذا كان يوجد نتيجة
      return Users.fromMap(result.first); // تحويل أول نتيجة إلى كائن مستخدم
    } else {
      throw Exception("Username or password not found"); // إذا لم تكن النتيجة موجودة
    }
  }

  // دالة لإنشاء مستخدم جديد في قاعدة البيانات
  Future<int> createUser(Users usr) async {
    final Database db = await initializeDb(); // تهيئة قاعدة البيانات
    return db.rawInsert(
        "INSERT INTO users (username, password, gender) VALUES (?, ?, ?)",
        [usr.username, usr.password, usr.gender]); // إدخال المستخدم الجديد مع اسم المستخدم وكلمة المرور والجنس
  }

  // دالة لحذف مستخدم باستخدام بيانات الاعتماد (اسم المستخدم وكلمة المرور)
  Future<int> deleteUserByCredentials(String username, String password) async {
    final Database db = await initializeDb(); // تهيئة قاعدة البيانات
    return await db.rawDelete(
      'DELETE FROM users WHERE username = ? AND password = ?',
      [username, password], // تمرير بيانات الاعتماد للمسح
    );
  }

  // دالة لتحديث بيانات مستخدم معين باستخدام معرف المستخدم
  Future<int> updateUser(Users usr) async {
    final Database db = await initializeDb(); // تهيئة قاعدة البيانات
    return await db.update(
      'users', // اسم الجدول
      usr.toMap(), // تحويل كائن المستخدم إلى خريطة لتحديثه
      where: "id = ?", // التحقق من العمود id
      whereArgs: [usr.id], // تمرير المعرف للمطابقة
    );
  }

  // دالة لاسترجاع جميع المستخدمين من قاعدة البيانات
  Future<List<Users>> getAllUsers() async {
    final Database db = await initializeDb(); // تهيئة قاعدة البيانات
    List<Map> list = await db.rawQuery('SELECT * FROM users'); // استعلام لاسترجاع جميع المستخدمين
    return list.map((usr) => Users.fromMap(usr as Map<String, dynamic>)).toList(); // تحويل النتائج إلى قائمة من كائنات المستخدمين
  }

  // دالة للبحث عن مستخدم باستخدام اسم المستخدم (مباراة دقيقة)
  Future<List<Users>> searchUserByExactName(String username) async {
    final Database db = await initializeDb(); // تهيئة قاعدة البيانات
    var res = await db.rawQuery("SELECT * FROM users WHERE username = ?", [username]); // استعلام للبحث عن اسم المستخدم
    return res.isNotEmpty
        ? res.map((user) => Users.fromMap(user)).toList() // إذا كانت النتائج موجودة
        : []; // العودة بقائمة فارغة إذا لم توجد نتائج
  }

  // دالة للبحث عن مستخدم باستخدام جزء من اسم المستخدم
  Future<List<Users>> searchUserByPartialName(String username) async {
    final Database db = await initializeDb(); // تهيئة قاعدة البيانات
    var res = await db.rawQuery("SELECT * FROM users WHERE username LIKE ?", ['%$username%']); // استعلام للبحث عن جزء من الاسم
    return res.isNotEmpty
        ? res.map((user) => Users.fromMap(user)).toList() // إذا كانت النتائج موجودة
        : []; // العودة بقائمة فارغة إذا لم توجد نتائج
  }
}
