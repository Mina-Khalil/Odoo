import 'package:flutter/material.dart';
import 'package:odoo/HomePage.dart';
import 'package:odoo/LoginPage.dart';
class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Registration"),
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
  bool _passwordVisible = false;
  bool _ConfirmaPaVisible = false;
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
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: ' Firts Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            /// Last Name
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: ' Last Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            ///Number Phone
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: ' Number Phone',
                  prefixIcon: Icon(Icons.phone_android),
                ),
              ),
            ),
            ///Email
            Container(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            /// Password
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                obscureText: !_passwordVisible,//This will obscure text dynamically
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: ' Password ',
                  prefixIcon:Icon(Icons.lock_outline,),
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
                obscureText: !_ConfirmaPaVisible,//This will obscure text dynamically
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: ' Confirm Password ',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _ConfirmaPaVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _ConfirmaPaVisible = !_ConfirmaPaVisible;
                    });
                    },
                  ),
                ),
              ),
            ),
            /// Add
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(120, 20, 120, 0),
                child: ElevatedButton(
                  child: const Text('Add',style: TextStyle(fontSize: 25),),
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