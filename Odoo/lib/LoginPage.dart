import 'package:flutter/material.dart';
import 'package:odoo/ForgetPassword.dart';
import 'package:odoo/HomePage.dart';
import 'package:odoo/Registration.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);
  static const String _title = 'Odoo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: const Text('Sing in',
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: 'User Name',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
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

            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ForgetPassword()),);
                //forgot password screen
              },
              child: const Text('Forget your Password',),
            ),
            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: ElevatedButton(
                  child: const Text('Log in ' ,
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage()),);
                  },
                )
            ),
            //////////// create account
             Row(
               children: <Widget>[
                 const Text('Does not have account?'),
                TextButton(
                  child: const Text(

                     'Sign up ',
                     style: TextStyle(decoration: TextDecoration.underline,fontSize: 20,fontWeight: FontWeight.bold),
                   ),
                   onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) =>  Registration()),);
                   },
                 )
               ],
               mainAxisAlignment: MainAxisAlignment.center,
             ),
          ],
        ));
  }
}