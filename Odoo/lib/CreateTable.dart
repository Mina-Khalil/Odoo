import 'package:flutter/material.dart';

class CreateTable extends StatefulWidget {
  const CreateTable({Key? key}) : super(key: key);

  @override
  State<CreateTable> createState() => _CreateTableState();
}

TextEditingController columnLength = TextEditingController();
bool show = false;
int length = 0;

class _CreateTableState extends State<CreateTable> {
  @override
  Widget build(BuildContext context) {
    var textFormNameTableController;
    String? datavalue;
    return Scaffold(
      //backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Create Table"),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: textFormNameTableController,
                validator: (val) {
                  return val!.isEmpty ? "No Data" : null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name Table",
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.black87),
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
                  setState(() {
                    length++;
                  });
                },
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 50 / 100,
                child: ListView.builder(
                    controller: null,
                    physics: const BouncingScrollPhysics(),
                    itemCount: length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          children: [
                            TextFormField(
                              controller: columnLength,
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
                              items:
                              ["int", "string", "bool", "Date"].map((item) {
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
                      );
                    })),
            SizedBox(
                height: MediaQuery.of(context).size.height * 10 / 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () async {
                            setState(() {});
                          },
                          icon: const Icon(Icons.add)),
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.create_rounded)),
                    ]))
          ],
        ),
      ),
    );
  }
}