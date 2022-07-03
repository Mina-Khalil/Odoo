import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:odoo/CreateTable.dart';
import 'package:odoo/HomePage.dart';
=======
import 'package:odoo/RestPassword.dart';
>>>>>>> Stashed changes
import 'package:odoo/LoginPage.dart';
import 'package:odoo/Registration.dart';
import 'package:odoo/RestPassword.dart';
import 'package:odoo/TablesDatabase.dart';
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
      create: (_) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text("Odoo",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
          body: const MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 50, 5, 20),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Welcome to the Application',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Container(padding: const EdgeInsets.all(100)),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Sing Up',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registration()),
                    );
                  },
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                  child: const Text(
<<<<<<< Updated upstream
                    'HomePagw',
=======
                    'databaes',
>>>>>>> Stashed changes
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
<<<<<<< Updated upstream
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                )),
=======
                      MaterialPageRoute(builder: (context) => RestPassword()),
                    );
                  },
                )),

>>>>>>> Stashed changes
            //////////// create account
          ],
        ));
  }
}
