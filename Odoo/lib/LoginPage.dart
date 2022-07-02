import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odoo/ForgetPassword.dart';
import 'package:odoo/HomePage.dart';
import 'package:odoo/Registration.dart';
import 'package:http/http.dart' as http;
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  Future<bool> LogInFun() async {
    try {
      String url = "http://localhost:8080/api/signin/";
      List<String>? data;
      String? res;
      url += nameController.text + "+" + passwordController.text;
      final Dio dio = Dio();

      print(url);

      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        setState(() {
          res = Response.data;
        });
        data = res!.split("\n");
        //print(data);
        Provider.of<MyProvider>(context, listen: false)
            .setData(data[1], data[0]);

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
    return Form(
      key: _keyForm,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              /// Text Sing in
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Sing in',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  )),

              /// Input Username
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    return val!.isEmpty ? "No Data" : null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black87),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'User Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),

              /// Input Password
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  validator: (val) {
                    return val!.isEmpty ? "No Data" : null;
                  }, //This will obscure text dynamically
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black87),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: ' Password ',
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

              /// Forget Password
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgetPassword()),
                  );
                  //forgot password screen
                },
                child: const Text(
                  'Forget your Password',
                ),
              ),

              /// button login
              Container(
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: ElevatedButton(
                    child: const Text(
                      'Log in ',
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () async {
                      if (_keyForm.currentState!.validate()) {
                        bool t = await LogInFun();
                        nameController.clear();
                        passwordController.clear();
                        if (t) {
                          print(Provider.of<MyProvider>(context, listen: false)
                                  .id +
                              "\n");
                          print(Provider.of<MyProvider>(context, listen: false)
                                  .token +
                              "\n");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } else {
                          //*******error message name and password is incorrect*****//
                        }
                      }
                    },
                  )),

              /// create account
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up ',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registration()),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}
