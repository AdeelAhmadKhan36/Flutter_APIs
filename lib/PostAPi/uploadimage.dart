import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image ;
  final _picker=ImagePicker();
  bool showSpinner=false;

  //Writing Function for pick image
  Future  getimage()async{
     final pickfile=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
   if(pickfile!=null){
     image=File(pickfile.path);
  setState(() {
    
  });

   }else{
     print('No file has been selected');
   }

  }

  Future Upload()async{

    setState(() {
      showSpinner=true;
    });
   var stream=new http.ByteStream(image!.openRead());
   stream.cast();
   var length=await image!.length();
   var uri=Uri.parse('https://fakestoreapi.com/products');
  var request=new http.MultipartRequest('Post', uri);
   request.fields['title']="Static Title";
   var multiport= new http.MultipartFile(
       'image',
       stream,
       length);
   request.files.add(multiport);
   var response=await request.send();
   if(response.statusCode==200){
     setState(() {
       showSpinner=false;
     });
     print('File Uploaded Sucessfully');
   }else{
     setState(() {
       showSpinner=false;
     });
     print('File Upload Failed ');
   }

  }



  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Post Image API'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getimage();
              },
              child: Container(
                child: image==null? Center(child: Text('Pick Image'))
                    :Container(
                  child: Image.file(
                      File(image!.path).absolute,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,

                  ),

                )

              ),
            ),
            SizedBox(height: 100,),

            ElevatedButton(onPressed: (){
              Upload();
            },
              child: Text('Upload Image'),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 50),
                  backgroundColor: Colors.indigo// Set the width and height
              ),
            )


          ],
                )
      ),
    );
  }
}
