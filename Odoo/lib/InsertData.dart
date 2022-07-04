import 'package:flutter/material.dart';
import 'package:odoo/CreateTable.dart';
import 'package:odoo/TablesDatabase.dart';
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

// class InsertData extends StatelessWidget {
//   InsertData(String db) {
//     Dname != db;
//   }
//   String? Dname;
//   @override
//   Widget build(BuildContext context) {
//     return InsertDataf(!Dname);
//   }
// }

class InsertData extends StatefulWidget {
  String? DataBaseName;

  InsertData(String data) {
    DataBaseName = data;
  }

  @override
  State<InsertData> createState() => _InsertDataState(DataBaseName!);
}

class _InsertDataState extends State<InsertData> {
  TextEditingController AddDataController = TextEditingController();

  String? Dname;

  _InsertDataState(String DataBaseName) {
    Dname = DataBaseName;
  }

  TextEditingController InsertDataController = TextEditingController();
  List<dynamic>? tables = [];
  List<String>? CName;
  List<String>? Type;
  String? tableName;
  int length = 0;
  String name = "name";
  String type = "Type";
  Future<bool> GetTables() async {
    try {
      String url = "http://20.89.56.192:8080/api/selectall/";
      // String url = "http://192.168.1.4:8080/api/selectall/";
      List<String>? data;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";

      url += "therooteddata+tables+name+schema_id+" + Dname! + "+true";
      final Dio dio = Dio();
      print(url);
      final Response = await dio.get(url);

      if (Response.statusCode == 200 && Response.data != "\n") {
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
      // String url = "http://192.168.1.4:8080/api/getnametype/";

      List<String>? Data;
      String? res;

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
        setState(() {
          Data = res!.split('*');
          CName = Data![0].split(',');
          Type = Data![1].split(',');
        });

        name = CName![length];
        type = Type![length];
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
        title: const Text("Insert Data"),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Tables(Dname!)),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 35,
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
                                        await GetDataTables();
                                      },
                                      child: Text(e.toString())),
                                ))
                            .toList()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70,
            width: 10,
          ),
          // ListTile(
          //   trailing: IconButton(
          //     icon: const Icon(Icons.add),
          //     onPressed: () {
          //       if (InsertDataController.text != null) {
          //         coulmnName.add(InsertDataController.text);
          //         InsertDataController.text = "";
          //         setState(() {
          //           length++;
          //         });
          //       }
          //     },
          //   ),
          // ),
          Container(
              child: ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      type,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                  width: 10,
                ),
                TextFormField(
                  controller: AddDataController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Data",
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black87),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Column(
                  children: const [
                    Divider(
                      indent: 0,
                      endIndent: 5,
                      thickness: 5,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ],
            ),
          )

              //  final ID = country![index].id;
              ),
          // IconButton(
          //   alignment: Alignment.bottomCenter,
          //   icon: const Icon(Icons.add),
          //   onPressed: () {
          //     if (InsertDataController.text != null) {
          //       coulmnName.add(InsertDataController.text);
          //       InsertDataController.text = "";
          //       setState(() {
          //         length++;
          //       });
          //     }
          //   },
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            if (length != CName!.length) length++;
            print(length);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
