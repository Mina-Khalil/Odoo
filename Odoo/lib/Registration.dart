import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odoo/LoginPage.dart';
import 'package:provider/provider.dart';

import 'provider/my_provider.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
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
  bool _passwordVisible = false;
  var _confirmaPaVisible = false;
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  Future<bool> SignUpFun() async {
    try {
      String url = "http://20.89.56.192:8080/api/newuser/";

      url += FirstNameController.text +
          LastNameController.text +
          "+" +
          EmailController.text +
          "+" +
          PasswordController.text +
          "+" +
          PhoneNumberController.text;
      final Dio dio = Dio();

      print(url);

      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        return Response.data;
      } else {
        return Response.data;
      }
    } catch (E) {
      print(E.toString());
      return false;
    }
  }

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _keyForm,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              /// First Name
              Container(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: FirstNameController,
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    return val!.isEmpty ? "No Data" : null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black87),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'First Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),

              /// Last Name
              Container(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: LastNameController,
                  keyboardType: TextInputType.name,
                  validator: (val) {
                    return val!.isEmpty ? "No Data" : null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black87),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: ' Last Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),

              ///Number Phone
              Container(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: PhoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    return val!.isEmpty ? "No Data" : null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black87),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: ' Number Phone',
                    prefixIcon: const Icon(Icons.phone_android),
                  ),
                ),
              ),

              ///Email
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
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
              ),

              /// Password
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

              /// Create Account button
              Container(
                height: 70,
                padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
                child: ElevatedButton(
                  child: const Text(
                    'Create',
                    style: TextStyle(fontSize: 35),
                  ),
                  onPressed: () {
                    setState(() async {
                      if (_keyForm.currentState!.validate()) {
                        if (PasswordController.text ==
                            ConfirmPasswordController.text) {
                          bool t = await SignUpFun();
                          if (t) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      content: Text('Successful'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Ok');
                                            setState(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LogIn()),
                                              );
                                            });
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      content: Text('Wrong Connection'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'ok');
                                            setState(() {
                                              FirstNameController.clear();
                                              LastNameController.clear();
                                              PhoneNumberController.clear();
                                              EmailController.clear();
                                              ConfirmPasswordController.clear();
                                              PasswordController.clear();
                                            });
                                          },
                                          child: const Text('ok'),
                                        ),
                                      ],
                                    ));
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    content: Text('ُWrong Password'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'ok');
                                          setState(() {
                                            FirstNameController.clear();
                                            LastNameController.clear();
                                            PhoneNumberController.clear();
                                            EmailController.clear();
                                            ConfirmPasswordController.clear();
                                            PasswordController.clear();
                                          });
                                        },
                                        child: const Text('ok'),
                                      ),
                                    ],
                                  ));
                        }
                      }
                    });
                  },
                ),
              ),
            ],
          )),
    );
  }
}
