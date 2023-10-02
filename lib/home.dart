
import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/PostModel.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostModel> postlist=[];

  //use future function
  Future<List<PostModel>> getPostApi() async{

    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      postlist.clear();
      for(Map i in data){
        postlist.add(PostModel.fromJson(i));

      }
      return postlist;

    }else{
      return postlist;

    }


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest APIs Integration",style: TextStyle(),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder:(context, snapshot){
                  if(!snapshot.hasData){
                    return Text("Loading...");

                  }else{
                    return ListView.builder(itemBuilder: (context,index){
                      return Column(children: [
                        Text("Title"),
                        Text(postlist[index].title.toString()),
                        SizedBox(height: 10,),
                        Text("Description"),
                        Text(postlist[index].description.toString()),
    
                      ],

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
