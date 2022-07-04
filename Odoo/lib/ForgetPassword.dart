import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odoo/LoginPage.dart';
import 'package:odoo/RestPassword.dart';
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
  String? pin;
  TextEditingController EmailController = new TextEditingController();
  Future<bool> GetPinFun() async {
    try {
      String url = "http://20.89.56.192:8080/api/sendpin/";
      // String url = "http://192.168.1.4:8080/api/sendpin/";
      List<String>? data;
      String? res;
      url += EmailController.text;
      final Dio dio = Dio();

      print(url);

      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        setState(() {
          pin = Response.data;
        });
        print(pin);

        return true;
      } else {
        return false;
      }
    } catch (E) {
      print(E.toString());
      return false;
    }
  }

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
                controller: EmailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black87),
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
                  onPressed: () async {
                    bool t = await GetPinFun();
                    if (t) {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RestPassword())); // new password
                      });
                    } else {
                      // no Email found
                    }
                  },
                )),
          ],
        ));
  }
}
