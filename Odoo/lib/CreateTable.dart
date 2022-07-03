import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:odoo/provider/my_provider.dart';
import 'package:provider/provider.dart';

class CreateTable extends StatelessWidget {
  String? DataBaseName;
  CreateTable(String Dname) {
    DataBaseName = Dname;
  }

  @override
  Widget build(BuildContext context) {
    return CreateTablef(DataBaseName!);
  }
}

class CreateTablef extends StatefulWidget {
  String? DataBaseName;
  CreateTablef(String Dname) {
    DataBaseName = Dname;
  }

  @override
  State<CreateTablef> createState() => _CreateTableState(DataBaseName!);
}

TextEditingController columnNameController = TextEditingController();
TextEditingController TableName = TextEditingController();
bool show = false;
int length = 0;
List<String> coulmnName = [];
List<String> typeName = [];
String? datavalue;

class _CreateTableState extends State<CreateTablef> {
  String? DName;
  _CreateTableState(String Dname) {
    DName = Dname;
  }
  Future<bool> CreateTableFun() async {
    try {
      String url = "http://20.89.56.192:8080/api/createtable/";
      List<String>? data;
      String? res;
      url += Provider.of<MyProvider>(context, listen: false).id +
          "+" +
          Provider.of<MyProvider>(context, listen: false).token +
          "+";
      url += DName! + "+";
      url += TableName.text + "+";
      print(datavalue);
      print(columnNameController.text);
      coulmnName.add(columnNameController.text);
      typeName.add(datavalue!);
      url += (coulmnName.join(',')) + "+";
      url += (typeName.join(','));

      final Dio dio = Dio();

      print(url);

      final Response = await dio.get(url);

      if (Response.statusCode == 200) {
        setState(() {
          res = Response.data;
        });
        data = res!.split("\n");
        //print(data);
        Provider.of<MyProvider>(context, listen: false)
            .setData(data[1], data[0]);

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
      //backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Create Table"),
      ),
      body: Form(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: TableName,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name Table",
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black87),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (length != 0) length--;
                  });
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (columnNameController.text != null && datavalue != null) {
                    coulmnName.add(columnNameController.text);
                    typeName.add(datavalue!);
                    columnNameController.text = "";
                    datavalue = null;
                    setState(() {
                      length++;
                    });
                  }
                },
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 50 / 100,
                child: ListTile(
                  title: Column(
                    children: [
                      TextFormField(
                        controller: columnNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Name DataType",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black87),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        hint: const Text(" Select Type"),
                        value: datavalue,
                        items: ["int", "text", "bool"].map((item) {
                          return DropdownMenuItem<String>(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (String? newval) {
                          setState(() {
                            datavalue = newval;
                          });
                        },
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                  onPressed: () async {
                    await CreateTableFun();
                    setState(() {
                      datavalue = null;
                      TableName.clear();
                      columnNameController.clear();
                    });
                  },
                  icon: const Icon(Icons.add)),
              IconButton(
                  onPressed: () async {}, icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () async {},
                  icon: const Icon(Icons.create_rounded)),
            ])
          ],
        ),
      ),
    );
  }
}
