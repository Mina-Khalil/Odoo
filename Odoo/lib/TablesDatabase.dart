import 'package:flutter/material.dart';
import 'package:odoo/HomePage.dart';
import 'api/TestAPI.dart';
import 'package:http/http.dart' as http;
class Tables extends StatefulWidget {
  const Tables({Key? key}) : super(key: key);
  @override
  State<Tables> createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  _TablesState() {
    fetchalbum();
  }
  var myController = TextEditingController();
  List<GetAlbum>? tables = [];

  Future fetchalbum() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        tables = getAlbumFromJson(res.body);
      });
    } else {
      throw Exception("error");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tables Screen"),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    final AlertDialog alert = AlertDialog(
                      title: const Text("Add table"),
                      content: SizedBox(
                        height: 250,
                        child: Column(
                          children: [
                            const Divider(
                              color: Colors.black,
                            ),
                            textField(),
                            const SizedBox(
                              height: 7,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      // tables.add(Table(
                                      //     name: myController
                                      //         .text)); //هنا الزرار الي بيحولني لصفحه تانيه
                                      // myController.text = "";
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ADD")),
                            ),
                          ],
                        ),
                      ),
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        });
                  },
                  icon: const Icon(Icons.add_circle),
                  color: Colors.white,
                )
              ],
            ),
          ),
          const Text("Tables base content"),
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