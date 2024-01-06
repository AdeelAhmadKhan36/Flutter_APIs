import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled2/model/UserModel.dart';
import 'package:http/http.dart' as http;

class ComplexJson_APi extends StatefulWidget {
  const ComplexJson_APi({super.key});

  @override
  State<ComplexJson_APi> createState() => _ComplexJson_APiState();
}

class _ComplexJson_APiState extends State<ComplexJson_APi> {
  List<UserModel> userlist = [];

  Future<List<UserModel>> getModel() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    //lets Decode the Json
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }
  //Now you Api has been hitted successfully

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Json API Calling'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getModel(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ReuseAbleRow(
                                      title: 'Name:',
                                      value: snapshot.data![index].name
                                          .toString()),
                                  ReuseAbleRow(
                                      title: 'User-Name:',
                                      value: snapshot.data![index].username
                                          .toString()),
                                  ReuseAbleRow(
                                      title: 'Email:',
                                      value: snapshot.data![index].email
                                          .toString()),
                                  ReuseAbleRow(
                                      title: 'Address:',
                                      value: snapshot
                                          .data![index].address!.zipcode
                                          .toString()),
                                  ReuseAbleRow(
                                      title: 'Geo:',
                                      value: snapshot
                                          .data![index].address!.geo!.lat
                                          .toString()),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

class ReuseAbleRow extends StatelessWidget {
  String title, value;
  ReuseAbleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
