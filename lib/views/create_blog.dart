

import 'dart:io';

import 'package:blogging/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';


class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {

  late String authorname, ttitle , blog;

late File selectedImage;
bool _isLoading=false;
var dowurl;
CrudMethod crudMethod=  CrudMethod();

Future<void> getImage() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (image != null) {
    setState(() {
      selectedImage = image as File;
    });
  }
}

uploadBlog() async {
// ignore: unnecessary_null_comparison
if(selectedImage != null){
setState(() {
  _isLoading=true;
});

try {
final storageRef = FirebaseStorage.instance.ref();
final mountainsRef = storageRef.child("blogsImage").child("${randomAlphaNumeric(9)}.jpg");

  await mountainsRef.putFile(selectedImage);
       dowurl =   await mountainsRef.getDownloadURL();
       print("this is url $dowurl");
}
catch(e){print(e);}
  
/*{
// ignore: unnecessary_null_comparison
if(selectedImage != null){
//uploading image to firestore
//CollectionReference users= FirebaseFirestore.instance.collection("user");
try {
  //Reference refe = FirebaseStorage.instance.ref().child("blogsImage").child(randomAlphaNumeric(9));
  final Reference ref= FirebaseStorage.instance.ref().child("blogsImage").child("$randomAlphaNumeric(9)");
 final UploadTask task= ref.putFile(selectedImage);
 //  var downurl= await(await task.onComplete).ref.getDownloadURL();
 
  var downurl = await (await task.onComplete).ref.getDownloadURL();
}*/

     Map<String,String> blogmap={
      
              "imageUrl": dowurl,
              "authorName": authorname,
              "title": ttitle,
              "blog": blog,
     };

          crudMethod.addData(blogmap).then((result){
               Navigator.pop(context); 
          });
           // StorageReference  ref  =FirebaseStorage.instance.ref().child("blogsImage").child("${randomAlphaNumeric(9)}");
    }
    else{

    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: ( const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
          Text("Flut",
          style: TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 22
          ),),
        Text("Bo",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.green
        ),)
          ],
          
        )) ,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              uploadBlog();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading ? Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      )  : Container(
        
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
              getImage();
              },
                // ignore: unnecessary_null_comparison
                child: selectedImage != null ? Container(
                   margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 170,
                   width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(selectedImage,fit: BoxFit.cover,))
                ):
            
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
                
                ),
            
              width: MediaQuery.of(context).size.width,
              child: const Icon(Icons.add_a_photo,
              color: Colors.green ,),
              
              ),),
              const SizedBox(height: 15,),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                children: <Widget>[
                   const SizedBox(height: 10,),
                  TextField(
                decoration: const InputDecoration(
                  hintText: "Author"
                ),
                onChanged: (val){
                  authorname = val;
                },
              )
              ,
               const SizedBox(height: 10,),
                  TextField(
                decoration: const InputDecoration(
                  hintText: "Title"
                ),
                onChanged: (val){
                  ttitle = val;
                },
              ),
               const SizedBox(height: 10,),
              
                  TextField(
                decoration: const InputDecoration(
                  hintText: "Blog Description"
                ),
                onChanged: (val){
                  blog = val;
                },
              )

                ],
              ),)
              
          ],
        ),
      ),
    );
  }
}