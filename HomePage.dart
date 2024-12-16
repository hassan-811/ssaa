import 'dart:io';

import 'package:asd4477/loginpage.dart';
import 'package:flutter/material.dart';

import 'createpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home Page'),
      ),
      body:
      Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            color: const Color.fromARGB(100, 100, 19, 5),
            padding: const EdgeInsets.all(20),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // use whichever suits your need
              children: [
                //const Padding(padding: EdgeInsets.all(30)),
                MaterialButton(
                  padding: const EdgeInsets.all(10),
                  color: Colors.orange,
                  textColor: Colors.white,
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreatePage()));
                  },
                  child: const Text("Create Page",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                // Spacer(flex: 1),
                MaterialButton(
                  padding: const EdgeInsets.all(10),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text("Login Page",
                    style: TextStyle(fontSize: 22),
                  ),
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
              // use whichever suits your need
              children: [
                //const Padding(padding: EdgeInsets.all(30)),
                MaterialButton(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: () async {

                  },
                  child: const Text(
                    "Gallery",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                // Spacer(flex: 1),
                MaterialButton(
                  padding: const EdgeInsets.all(10),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () async {
                    exit(0);
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}