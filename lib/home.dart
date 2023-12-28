
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/model/Post_Model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [] ;

  Future<List<PostModel>> getPostApi() async{
    final response= await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    //Now decode this into data
    var data=jsonDecode(response.body.toString());

    print("here is DATA ${data}");

    if(response.statusCode==200){
      postList.clear();
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
     return  postList;
    }else{
      return  postList;

    }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get APIs",style: TextStyle(),),
        centerTitle: true,
      ),
      body: Column(
        children: [
         Expanded(
           child: FutureBuilder(
               future:getPostApi(),
               builder: (context, snapshot){
                 if(!snapshot.hasData){
                   return CircularProgressIndicator();
                 }else{
                   return Container(
                     color: Colors.grey,
                     child: ListView.builder(
                         itemCount: postList.length,
                         itemBuilder: (context,index){
                       return  Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                  Text('Title',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Text(postList[index].title.toString()),
                               SizedBox(height: 10,),
                               Text('Description',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                               Text("Description \n"+postList[index].body.toString())


                             ],
                           ),
                                ),
                         ),
                       );
                     }),
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
