import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odoo/CreateTable.dart';
import 'package:odoo/Registration.dart';
import 'package:odoo/TablesDatabase.dart';
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController CDataBaseController = TextEditingController();

  List<dynamic>? DataBases = [];

  Future<bool> GetDataBase() async {
    try {
      String url = "http://20.89.56.192:8080/api/selectall/";
      // String url = "http://192.168.1.4:8080/api/selectall/";

      List<String>? data;
      String? res;
      String id = Provider.of<MyProvider>(context, listen: false).id;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";
      url += "therooteddata+schemas+name+user_id+" + id + "+false";
      final Dio dio = Dio();
      print(url);
      final Response = await dio.get(url);

      if (Response.statusCode == 200 && Response.data != null) {
        setState(() {
          DataBases = Response.data;
        });
        removenewline();
        return true;
      } else {
        return false;
      }
    } catch (E) {
      print(E.toString());
      return false;
    }
  }

  Future<bool> CreateDataBase() async {
    try {
      String url = "http://20.89.56.192:8080/api/createdb/";
      // String url = "http://192.168.1.4:8080/api/createdb/";
      List<String>? data;
      String? res;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";
      url += CDataBaseController.text +
          "_" +
          Provider.of<MyProvider>(context, listen: false).id;

      final Dio dio = Dio();
      print(url);
      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        setState(() {
          res = Response.data;
        });

        if (res == "db") {
          return false;
        }
        GetDataBase();
        return true;
      } else {
        return false;
      }
    } catch (E) {
      print(E.toString());
      return false;
    }
  }

  void removenewline() {
    for (var i = 0; i < DataBases!.length; i++) {
      String str = DataBases![i];
      DataBases![i] = str.replaceAll("\n", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool subdrawer1 = false;
    bool subdrawer2 = false;
    bool subdrawer4 = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                await GetDataBase();
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: 400,
            height: 550,
            margin: const EdgeInsets.all(10),
            color: Colors.grey,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              scrollDirection: Axis.vertical,
              children: [
                ...DataBases!
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Provider.of<MyProvider>(context, listen: false)
                                    .databaseName = e;
                                print(e);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tables()));
                              },
                              child: SingleChildScrollView(child: Text(e))),
                        ))
                    .toList()
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("Enter Name DataBase"),
                    content: TextFormField(
                      controller: CDataBaseController,
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        return val!.isEmpty ? "No Data" : null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                          CDataBaseController.text = "";
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await CreateDataBase();
                          await GetDataBase();

                          Navigator.pop(context, 'Ok');
                          CDataBaseController.clear();
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
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
