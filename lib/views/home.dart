import 'package:blogging/services/crud.dart';
import 'package:blogging/views/auth_service.dart';
import 'package:blogging/views/create_blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethod cm =  CrudMethod();
  late Stream blogst;
  Widget Bloglist(){
return Container(
  // ignore: unnecessary_null_comparison
  child: blogst != null ? Column(
    children: <Widget>[
     StreamBuilder(stream: blogst, builder: (context, snapshot)=> ListView.builder(
        padding: EdgeInsets.symmetric(horizontal:8),
        itemCount: snapshot.data.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return  BlogsTile(
            authorName: snapshot.data.docs[index].data('authorName'),
           ttile: snapshot.data.docs[index].data('ttile'),
            blog:snapshot.data.docs[index].data('blog'),
            imagUrl: snapshot.data.docs[index].data('imageUrl'),
          );
        } ))
    ],
  ) : Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ) ,
);

  }

  @override
  void initState() {
    super.initState();

       cm.getData().then((result){
     blogst=result;
       });
         
     
  }


   Future<void> _signOut(BuildContext context) async {
    try {
      await AuthService.signOut(); 
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); 
    } catch (e) {
     
      print('Sign-out failed: $e');
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: (  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
          const Text("Flut",
          style: TextStyle(
            fontWeight: FontWeight.bold,
              fontSize: 50,
            
          ),),
        const Text("Bo",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Color.fromARGB(255, 46, 49, 46)
        ),),
          ElevatedButton(
              onPressed: () {
                _signOut(context);
              },
              child: const Text('Sign Out'),
            )
            ],
          
        )) ,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Bloglist(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
          FloatingActionButton(onPressed: (){
            Navigator.push( context, MaterialPageRoute(builder: ((context) => CreateBlog() )));
          },
          child: Icon(Icons.add),
          )
          ],
        ),
      ),
    );
  }
}


class BlogsTile extends StatelessWidget {

     final String imagUrl, ttile, blog, authorName;


    const  BlogsTile({
    Key? key,
    required this.authorName,
    required this.blog,
    required this.imagUrl,
    required this.ttile,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 16),

      child: Stack(
        
        children: <Widget>[
         ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: imagUrl,
          width:MediaQuery.of(context).size.width,
          fit:BoxFit.cover,)),
         Container(
          height: 170,
          decoration: BoxDecoration(
            color: Colors.black45.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6),
          ),
         ),
         Container(
           width:MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(ttile, style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
              const SizedBox(height: 4,),
              Text(blog, style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
               const SizedBox(height: 4,),
              Text(authorName),
               const SizedBox(height: 4,),
            ],
          ),
         )
        ],
      ),
    );
  }
}