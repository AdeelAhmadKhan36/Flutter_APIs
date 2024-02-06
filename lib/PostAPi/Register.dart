import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class PostAPi extends StatefulWidget {
  const PostAPi({super.key});

  @override
  State<PostAPi> createState() => _PostAPiState();
}

class _PostAPiState extends State<PostAPi> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  login(String email, password)async{

    try{
      //Here implement your logic
     Response response=await post(
       Uri.parse('https://reqres.in/api/register'),
       body: {
         'email': email,
         'password': password,

       }

     );
     if(response.statusCode==200){
       var data=jsonDecode(response.body.toString());
       print(data);
       print('Account Created Sucessfully');
     }else{
       print('Failed');
     }

    }
    catch(e){

      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post APis'),
        centerTitle: true,
        backgroundColor: Colors.indigo,

      ),

      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){

              },
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  label: Text('Email',style: TextStyle(fontWeight: FontWeight.bold),),
                  hintText: 'Enter your email'
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
              },
              child: TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    label: Text('Password',style: TextStyle(fontWeight: FontWeight.bold),),
                    hintText: 'Enter your Password'
                ),
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              login(emailcontroller.text.toString(),passwordcontroller.text.toString());
            },
                child: Text('Sign Up'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(400, 50),
              backgroundColor: Colors.indigo// Set the width and height
            ),
            )


          ],

        ),
      ),
    );
  }
}
