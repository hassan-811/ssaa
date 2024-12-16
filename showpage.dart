import 'package:flutter/material.dart';
import 'package:asd4477/loginpage.dart';
import 'package:asd4477/sqldb.dart';
import 'package:asd4477/updatepage.dart';
import 'package:asd4477/json/users.dart';

class ShowPage extends StatefulWidget {
  final Users usr;

  ShowPage({super.key, required this.usr});

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  final db = SqlDb.instance;
  List<Users> usersList = [];
  final userController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load initial data when the page is loaded
    loadUsers();
  }

  // Load all users initially
  loadUsers() async {
    var users = await db.getAllUsers();
    setState(() {
      usersList = users;
    });
  }

  // Search users by username (using partial match)
  searchUser(String query) async {
    var users = await db.searchUserByExactName(query);  // Use the correct search method
    setState(() {
      usersList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        title: const Text('Show Page'),
      ),
      body: Container(
        color: const Color.fromARGB(100, 100, 80, 5),
        child: Column(
          children: [
            // User info section
            Container(
              color: const Color.fromRGBO(255, 255, 255, 10),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${widget.usr.id}',
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[900]!,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.usr.username}',
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[900]!,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.usr.password}',
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[900]!,
                    ),
                  ),
                  Spacer(),
                  // Display Gender (with null check)
                  Text(
                    '${widget.usr.gender ?? "Unknown"}',
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[900]!,
                    ),
                  ),
                ],
              ),
            ),

            // Buttons Section
            Container(
              margin: const EdgeInsets.all(10),
              color: const Color.fromARGB(100, 100, 19, 5),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdatePage(user: widget.usr)),
                      );
                    },
                    child: const Text(
                      "Update Page",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),

            // Search Section
            Container(
              margin: const EdgeInsets.all(10),
              color: const Color.fromARGB(100, 100, 19, 5),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Search TextField
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: TextField(
                        controller: userController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  // Search Button
                  MaterialButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      String query = userController.text;
                      if (query.isEmpty) {
                        // إذا كان حقل البحث فارغًا، نعرض جميع المستخدمين
                        loadUsers();  // استدعاء دالة loadUsers لعرض جميع المستخدمين
                      } else {
                        // إذا كان حقل البحث يحتوي على نص، نقوم بالبحث عن المستخدمين المطابقين
                        searchUser(query);
                      }
                    },
                    child: const Text(
                      "Search",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black38,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ID',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Username',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Password',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Gender',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Displaying Users List
            Expanded(
              child: Container(
                color: Colors.black38,
                child: usersList.isEmpty
                    ? const Center(child: Text('No users found'))
                    : ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    Users user = usersList[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ID
                            Text(
                              '${user.id}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Username
                            Text(
                              user.username,
                              style: const TextStyle(fontSize: 20),
                            ),
                            // Password
                            Text(
                              user.password,
                              style: const TextStyle(fontSize: 20),
                            ),
                            // Gender
                            Text(
                              user.gender ?? "Unknown", // Default to "Unknown" if null
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
