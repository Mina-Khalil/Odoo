import 'package:flutter/material.dart';
import 'package:odoo/LoginPage.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogIn()),
              );
            },
          ),
        ),
        body: const MyStatefulWidget(),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            /// Text Forget Password
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: const Text(
                  'Did you forget your password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Container(padding: const EdgeInsets.all(50)),
            /// input Email to send reset the password
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.perm_phone_msg),
                ),
              ),
            ),
            /// Send message button
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Send Message',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LogIn()));
                    });
                  },
                )),
          ],
        ));
  }
}
