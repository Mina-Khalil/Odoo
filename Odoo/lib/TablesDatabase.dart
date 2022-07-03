import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odoo/CreateTable.dart';
import 'package:odoo/HomePage.dart';
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';
import 'api/TestAPI.dart';
import 'package:http/http.dart' as http;

class Tables extends StatefulWidget {
  String? DataBaseName;

  Tables(String data) {
    DataBaseName = data;
  }
  @override
  State<Tables> createState() => _TablesState(DataBaseName!);
}

class _TablesState extends State<Tables> {
  String? Dname;
  _TablesState(String DataBaseName) {
    Dname = DataBaseName;
  }

  var myController = TextEditingController();
  List<dynamic>? tables = [];
  Future<bool> GetTables() async {
    try {
      String url = "http://192.168.1.4:8080/api/selectall/";
      List<String>? data;
      String? res;
      String id = Provider.of<MyProvider>(context, listen: false).id;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";

      url += "therooteddata+tables+name+name+" + Dname! + "+true";
      final Dio dio = Dio();
      print(url);
      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        setState(() {
          tables = Response.data;
        });
        //DataBases = res!.split("\t");

        return true;
      } else {
        return false;
      }
    } catch (E) {
      print(E.toString());
      return false;
    }
  }

  Widget textField() {
    return TextField(
      decoration: const InputDecoration(
        label: Text("Table name "),
        hintText: "Name",
      ),
      keyboardType: TextInputType.text,
      controller: myController,
    );
  }

  List<bool>? IsCkecked = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await GetTables();
              },
              icon: Icon(Icons.search))
        ],
        title: const Text("Tables DataBase"),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: Colors.grey,
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...tables!
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(e.id!.toString())),
                                ))
                            .toList()
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateTable()));
                    });

                    // final AlertDialog alert = AlertDialog(
                    //   title: const Text("Add table"),
                    //   content: SizedBox(
                    //     height: 250,
                    //     child: Column(
                    //       children: [
                    //         const Divider(
                    //           color: Colors.black,
                    //         ),
                    //         textField(),
                    //         const SizedBox(
                    //           height: 7,
                    //         ),
                    //         SizedBox(
                    //           width: double.infinity,
                    //           child: ElevatedButton(
                    //               onPressed: () {
                    //                 setState(() {
                    //                   // tables.add(Table(
                    //                   //     name: myController
                    //                   //         .text)); //هنا الزرار الي بيحولني لصفحه تانيه
                    //                   // myController.text = "";
                    //                 });
                    //                 Navigator.of(context).pop();
                    //               },
                    //               child: const Text("ADD")),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return alert;
                    //     });
                  },
                  icon: const Icon(Icons.add_circle),
                  color: Colors.white,
                )
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 0),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    return val!.isEmpty ? "No Data" : null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Name DataType',
                    prefixIcon: const Icon(Icons.edit),
                  ),
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 60 / 100,
            child: !show
                ? null
                : ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: IconButton(
                          icon: const Icon(Icons.create_rounded),
                          onPressed: () {},
                        ),
                        leading: Checkbox(
                          value: IsCkecked![index],
                          onChanged: (bool? val) {
                            setState(() {
                              IsCkecked![index] = val!;
                            });
                          },
                        ),
                        title: const Text("Name: "),
                        subtitle: const Text("ID: "),
                      );
                    },
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () async {
                    setState(() {});
                  },
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () async {}, icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () async {},
                  icon: const Icon(Icons.create_rounded)),
            ],
          ),
        ],
      ),
    );
  }
}
