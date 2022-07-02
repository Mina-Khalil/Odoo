import 'package:flutter/material.dart';
import 'package:odoo/LoginPage.dart';
class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Registration"),
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
  bool _passwordVisible = false;
  var _confirmaPaVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            /// First Name
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.name,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: 'First Name',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ),
            /// Last Name
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.name,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: ' Last Name',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ),
            ///Number Phone
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: ' Number Phone',
                  prefixIcon: const Icon(Icons.phone_android),
                ),
              ),
            ),
            ///Email
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: 'E-mail',
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
            ),
            /// Password
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                obscureText: !_passwordVisible,//This will obscure text dynamically
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: ' Password ',
                  prefixIcon:const Icon(Icons.lock_outline,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                obscureText: !_confirmaPaVisible,//This will obscure text dynamically
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: ' Confirm Password ',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmaPaVisible ? Icons.visibility : Icons.visibility_off,
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
                  child: const Text('Create',style: TextStyle(fontSize: 35),),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text('complete the addition'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ));
  }
}