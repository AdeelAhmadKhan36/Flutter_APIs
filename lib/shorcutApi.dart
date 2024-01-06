import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  var data;
  Future<void> getApi()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200){

      data=jsonDecode(response.body.toString());
    }else{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example API Calling'),
        centerTitle: true,
      ),
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder(future: getApi(),
                builder: (context,snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                        itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ReuseAbleRow(title: 'Name', value: data[index]['name'].toString(),),
                            ReuseAbleRow(title: 'User_Name', value: data[index]['username'].toString(),),
                            ReuseAbleRow(title: 'lat', value: data[index]['address']['geo']['lat'].toString(),)

                          ],
                        ),
                      );
                    }
                    );
                  }
                }
                ),
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