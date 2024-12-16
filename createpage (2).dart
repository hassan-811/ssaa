import 'package:asd4477/sqldb.dart';
import 'package:flutter/material.dart';
import 'package:asd4477/json/users.dart';

class CreatePage extends StatefulWidget {
  @override
  State<CreatePage> createState() => _CreateState();
}

class _CreateState extends State<CreatePage> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  String? selectedGender; // متغير لتخزين الجنس المختار

  insertUser() async {
    if (userController.text.isNotEmpty && passController.text.isNotEmpty && selectedGender != null) {
      var response = await SqlDb.instance.createUser(
        Users(
          username: userController.text,
          password: passController.text,
          gender: selectedGender!, // تمرير الجنس إلى قاعدة البيانات
        ),
      );
      if (response > 0) {
        Navigator.pop(context); // العودة بعد إضافة المستخدم
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("Error")),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(title: Text("Fields are Empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Create Page'),
      ),
      body: Container(
        color: const Color.fromARGB(100, 100, 109, 5),
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: userController,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: passController,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(hintText: 'Password'),
              ),
            ),
            // إضافة Radio Buttons لتحديد نوع الجنس بجانب بعضها
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Gender",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: "Male",
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          const Text("Male", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Radio<String>(
                            value: "Female",
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          const Text("Female", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              color: const Color.fromARGB(100, 100, 19, 5),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () async {
                      insertUser();
                    },
                    child: const Text(
                      "Insert User",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
