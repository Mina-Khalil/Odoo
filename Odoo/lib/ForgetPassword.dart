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
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: const Text('Did you forget your password',
                  style: TextStyle(fontSize: 25,	fontWeight: FontWeight.bold),
                )),
            Container(
                padding: EdgeInsets.all(50)
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1,color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)

                  ),
                  labelText: ' Number Phone',
                  prefixIcon: Icon(Icons.perm_phone_msg),
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: ElevatedButton(
                  child: const Text('Send Message',style: TextStyle(fontSize: 25),),
                  onPressed: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                    });
                  },
                )
            ),
          ],
        ));
  }
}