import 'package:asd4477/loginpage.dart';
import 'package:asd4477/showpage.dart';
import 'package:asd4477/sqldb.dart';
import 'package:flutter/material.dart';
import 'package:asd4477/json/users.dart';

@immutable
class UpdatePage extends StatelessWidget {
  final userController = TextEditingController();
  final passController = TextEditingController();

  // تأكد من أن المستخدم `user` هو خاصية `final`
  final Users user;

  // بناء الكائن يجب أن يتم عن طريق الممر
  UpdatePage({required this.user});

  updateU(BuildContext context) async {
    user.username = userController.text.toString();
    user.password = passController.text.toString();
    var response = await SqlDb.instance.updateUser(user);

    if (response > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Populate the controllers with current user data for editing
    userController.text = user.username;
    passController.text = user.password;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Update Page'),
      ),
      body: Container(
        color: const Color.fromARGB(100, 100, 109, 5),
        child: Column(
          children: <Widget>[
            // ID Display
            Container(
              color: const Color.fromRGBO(255, 255, 255, 10),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${user.id}',
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
                    '${user.username}',
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
                    '${user.password}',
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

            // Username Input
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: userController,
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(hintText: 'username'),
              ),
            ),

            // Password Input
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: passController,
                style: const TextStyle(fontSize: 22),
                decoration: InputDecoration(hintText: 'password'),
              ),
            ),

            // Buttons
            Container(
              margin: const EdgeInsets.all(15),
              color: const Color.fromARGB(100, 100, 19, 5),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Update Button
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.purple,
                    textColor: Colors.white,
                    onPressed: () async {
                      // Calling the update function
                      await updateU(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowPage(usr: user)),
                      );
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),

                  // Delete Button
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      String username = userController.text.trim();
                      String password = passController.text.trim();

                      // Call delete function
                      int result = await SqlDb.instance.deleteUserByCredentials(username, password);

                      if (result > 0) {
                        // Success
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("User deleted successfully!")),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } else {
                        // Failure
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Failed to delete user. Check credentials!")),
                        );
                      }
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),

                  // Back Button
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.limeAccent,
                    textColor: Colors.blue,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ShowPage(usr: user)),
                      );
                    },
                    child: const Text(
                      "Back",
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
