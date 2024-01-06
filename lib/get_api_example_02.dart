import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Photoes_Api extends StatefulWidget {
  const Photoes_Api({super.key});

  @override
  State<Photoes_Api> createState() => _Photoes_ApiState();
}

class _Photoes_ApiState extends State<Photoes_Api> {
  List<Photos_Model> photoList=[];


  Future<List<Photos_Model>> get_Model()async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map i in data){
        Photos_Model photos=Photos_Model(title: i['title'], url:i['url'], id:i['id'],);
        photoList.add(photos);

      }
      return photoList;
    }else{
      return photoList;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get API Part 2"),
      ),

      body: Column(
        children: [
                 Expanded(
                   child: FutureBuilder(

                       future:get_Model(),
                       builder:(context, AsyncSnapshot<List<Photos_Model>>   snapshot){

                         return ListView.builder(
                           itemCount: photoList.length,
                             itemBuilder: (context ,index){

                               return ListTile(
                                 leading: CircleAvatar(
                                   backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                                 ),

                                 title: Text("Notes_Id"+snapshot.data![index].id.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                 subtitle: Text(snapshot.data![index].title.toString()),
                               );
                             });


                       }
                       ),
                 )
        ],
      ),

    );
  }
}



class Photos_Model{
  String title,url;
  int id;

  Photos_Model({required this.title,required this.url,required this.id});

}