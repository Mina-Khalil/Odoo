import 'package:flutter/material.dart';
import 'package:odoo/CreateTable.dart';
import 'package:odoo/LoginPage.dart';
import 'package:odoo/Registration.dart';
import 'package:odoo/TablesDatabase.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageF();
  }
}

class HomePageF extends StatefulWidget {
  const HomePageF({Key? key}) : super(key: key);

  @override
  State<HomePageF> createState() => _HomePage();
}

class _HomePage extends State<HomePageF> {
  bool subdrawer1 = false;
  bool subdrawer2 = false;
  bool subdrawer3 = false;
  bool subdrawer4 = false;
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(children: [
        ElevatedButton(
          child: const Text(
            'Back',
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogIn()));
            });
          },
        ),
        ElevatedButton(
          child: const Text(
            'TablesBataBase',
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Tables()));
            });
          },
        ),
        ElevatedButton(
          child: const Text(
            'CreateTable',
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateTable()));
            });
          },
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.indigo,
                Colors.blue,
              ])),
              child: Text(
                "Odoo",
                style: TextStyle(fontSize: 35),
              ),
            ),
            ///////////// Fist Choose
            ListTile(
              title: const Text('The First '),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    subdrawer1 = !subdrawer1;
                  });
                },
              ),
              subtitle: subdrawer1
                  ? Column(
                      children: [
                        TextButton(onPressed: () {}, child: const Text("1.1")),
                        TextButton(onPressed: () {}, child: const Text("1.2")),
                        TextButton(onPressed: () {}, child: const Text("1.3")),
                        TextButton(onPressed: () {}, child: const Text("1.4")),
                      ],
                    )
                  : null,
            ),
            ///////////// Second Choose
            ListTile(
              title: const Text('The Second'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    subdrawer2 = !subdrawer2;
                  });
                },
              ),
              subtitle: subdrawer2
                  ? Column(
                      children: [
                        TextButton(onPressed: () {}, child: const Text("2.1")),
                        TextButton(
                          onPressed: () {},
                          child: const Text("2.2"),
                        ),
                      ],
                    )
                  : null,
            ),
            //////////// Third Choose
            ListTile(
              title: const Text('The Third '),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    subdrawer4 = !subdrawer4;
                  });
                },
              ),
              subtitle: subdrawer4
                  ? Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Registration()));
                              });
                            },
                            child: const Text("3.1 ")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Registration()));
                              });
                            },
                            child: const Text("3.2")),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Registration()));
                              });
                            },
                            child: const Text("3.3")),
                      ],
                    )
                  : null,
            ),
            //////////// Four Choose
            ListTile(
              title: const Text('The Fourth'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    ///action
                  });
                },
              ),
            ),
            //////////// Five Choose
            ListTile(
              title: const Text('The Fifth'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    ///action
                  });
                },
              ),
            ),
            //////////// Account
            ListTile(
              title: const Text('Account'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    ///action
                  });
                },
              ),
            ),
            /////////// Setting
            ListTile(
              title: const Text('Setting'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  setState(() {
                    ///action
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
