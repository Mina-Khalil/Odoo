import 'package:flutter/material.dart';
import 'package:odoo/LoginPage.dart';

class RestPassword extends StatelessWidget {
  const RestPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
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
  var _passwordVisible = false;
  var _confirmaPaVisible = false;
  TextEditingController ConfirmPasswordController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

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
                  'Rest your password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
           /// Pin Number
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Pin',
                  prefixIcon: const Icon(Icons.confirmation_num),
                ),
              ),
            ),
            /// reset password
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: PasswordController,
                obscureText:
                !_passwordVisible, //This will obscure text dynamically
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'New Password ',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            /// Confirm Password
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                controller: ConfirmPasswordController,
                obscureText:
                !_confirmaPaVisible, //This will obscure text dynamically
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)),
                  labelText: ' Confirm Password ',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmaPaVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmaPaVisible = !_confirmaPaVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            /// Send message button
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Create',
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
