import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odoo/CreateTable.dart';
import 'package:odoo/HomePage.dart';
import 'package:odoo/InsertData.dart';
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';
import 'api/TestAPI.dart';
import 'package:http/http.dart' as http;

class Tables extends StatefulWidget {
  String? DataBaseName;
  String? datavalue;
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

  TextEditingController columnNameController = TextEditingController();
  TextEditingController AddColumnController = TextEditingController();

  List<dynamic>? tables = [];
  List<String>? CName;
  List<String>? Type;
  String? tableName = "Users";
  List test = ['name', 'nnnn'];
  List<bool>? IsCkecked;
  String? typeValue;
  String? CoulmName;
  bool enable = true;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  Future<bool> GetTables() async {
    try {
      String url = "http://20.89.56.192:8080/api/selectall/";
      // String url = "http://192.168.1.4:8080/api/selectall/";
      List<String>? data;
      //String? res;
      //String id = Provider.of<MyProvider>(context, listen: false).id;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";

      url += "therooteddata+tables+name+schema_id+" + Dname! + "+true";
      final Dio dio = Dio();
      print(url);
      final Response = await dio.get(url);

      if (Response.statusCode == 200 && Response.data != null) {
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

  Future<bool> GetDataTables() async {
    try {
      String url = "http://20.89.56.192:8080/api/getnametype/";
      //  String url = "http://192.168.1.4:8080/api/getnametype/";

      List<String>? Data;
      String? res;
      //String id = Provider.of<MyProvider>(context, listen: false).id;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";
      tableName = tableName!.replaceAll("\n", "");
      url += Dname! + "+" + tableName!;
      final Dio dio = Dio();
      print(tableName! + "aaa");
      print(url);
      final r = await dio.get(url);
      if (r.statusCode == 200) {
        setState(() {
          res = r.data;
        });
        print(res);
        Data = res!.split('*');
        setState(() {
          CName = Data![0].split(',');
          Type = Data[1].split(',');
          IsCkecked = List.filled(CName!.length, false);
        });
        print(Data);
        print(CName);
        print(Type);

        return true;
      } else {
        return false;
      }
    } catch (E) {
      print(E.toString());
      return false;
    }
  }

  Future<bool> InsertCoulm() async {
    try {
      String url = "http://20.89.56.192:8080/api/altertable/";
      // String url = "http://192.168.1.4:8080/api/altertable/";
      List<String>? data;
      //String? res;
      //String id = Provider.of<MyProvider>(context, listen: false).id;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";
      tableName = tableName!.replaceAll("\n", "");
      url += Dname! + "+" + tableName! + "+add+";
      url += AddColumnController.text + "+" + typeValue! + "+%20+%20";
      final Dio dio = Dio();
      print(url);
      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        setState(() {
          // tables = Response.data;
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

  Future<bool> EditCoulm() async {
    try {
      String url = "http://20.89.56.192:8080/api/altertable/";
      // String url = "http://192.168.1.4:8080/api/altertable/";
      List<String>? data;
      //String? res;
      //String id = Provider.of<MyProvider>(context, listen: false).id;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";
      tableName = tableName!.replaceAll("\n", "");
      url += Dname! + "+" + tableName! + "+update+";
      url +=
          CoulmName! + "+%20+" + typeValue! + "+" + columnNameController.text;
      final Dio dio = Dio();
      print(url);
      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        setState(() {
          //  tables = Response.data;
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

  // Widget textField() {
  //   return TextField(
  //     decoration: const InputDecoration(
  //       label: Text("Table name "),
  //       hintText: "Name",
  //     ),
  //     keyboardType: TextInputType.text,
  //     controller: myController,
  //   );
  // }

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
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Form(
        child: Column(
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
                                        onPressed: () async {
                                          setState(() {
                                            tableName = e;
                                          });
                                          bool t = await GetDataTables();
                                          if (t) {
                                            setState(() {
                                              show = true;
                                            });
                                          }
                                        },
                                        child: Text(e.toString())),
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
                                builder: (context) => CreateTable(Dname!)));
                      });
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: columnNameController,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          return val!.isEmpty ? "No Data" : null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Name DataType',
                          prefixIcon: const Icon(Icons.edit),
                        ),
                      ),
                      // DropdownButtonFormField<String>(
                      //   hint: const Text(" Select Type"),
                      //   value: datavalue,
                      //   items: ["int", "text", "bool"].map((item) {
                      //     return DropdownMenuItem<String>(
                      //       child: Text(item),
                      //       value: item,
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? newval) {
                      //     setState(() {
                      //       datavalue = newval;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                )),
            SingleChildScrollView(
              child: Container(
                  // color: Colors.grey,
                  height: MediaQuery.of(context).size.height * 60 / 100,
                  child: !show
                      ? null
                      //color: Colors.grey,
                      : ListView.builder(
                          itemCount: CName!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.create_rounded),
                                onPressed: () {
                                  columnNameController.text = CName![index];
                                  typeValue = Type![index];
                                  CoulmName = CName![index];
                                  setState(() {
                                    enable = false;
                                  });
                                },
                              ),
                              leading: Checkbox(
                                value: IsCkecked![index],
                                onChanged: (bool? val) {
                                  setState(() {
                                    IsCkecked![index] = val!;
                                  });
                                },
                              ),
                              title: Text("Name: " + CName![index]),
                              subtitle: Text("Type: " + Type![index]),
                            );
                          },
                        )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  key: _keyForm,
                  child: IconButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Add Column"),
                                  content: Container(
                                    height: MediaQuery.of(context).size.height *
                                        30 /
                                        100,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: AddColumnController,
                                          keyboardType: TextInputType.text,
                                          validator: (val) {
                                            return val!.isEmpty
                                                ? "No Data"
                                                : null;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            labelText: 'Name DataType',
                                            prefixIcon: const Icon(Icons.edit),
                                          ),
                                        ),
                                        DropdownButtonFormField<String>(
                                          hint: const Text(" Select Type"),
                                          value: typeValue,
                                          items: ["int", "text", "bool"]
                                              .map((item) {
                                            return DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList(),
                                          onChanged: (String? newval) {
                                            setState(() {
                                              typeValue = newval;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                        columnNameController.clear();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (_keyForm.currentState!.validate()) {
                                          // await CreateDataBase();
                                          await InsertCoulm();
                                          Navigator.pop(context, 'Ok');
                                          AddColumnController.clear();
                                          //   typeValue = "";
                                        }
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.add)),
                ),
                IconButton(
                    onPressed: () async {}, icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: enable
                        ? null
                        : () async {
                            await EditCoulm();
                            columnNameController.clear();
                            GetDataTables();
                            setState(() {
                              enable = true;
                            });
                          },
                    icon: const Icon(Icons.create_rounded)),
                IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InsertData(Dname!)),
                      );
                    },
                    icon: const Icon(Icons.insert_chart_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
