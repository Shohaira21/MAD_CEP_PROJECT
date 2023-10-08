
import 'package:cloud_firestore/cloud_firestore.dart';


class CrudMethod{

  Future <void> addData(blogData) async
  {
     FirebaseFirestore.instance.collection("blogs").add(blogData).catchError((e){
      String b=e;
      // ignore: invalid_return_type_for_catch_error
      return b;
     
     });
  }
  getData() async {
    return FirebaseFirestore.instance.collection("blogs").doc();
     //  Stream<QuerySnapshot<Map<String, dynamic>>>  users= FirebaseFirestore.instance.collection("blogs").snapshots();
      }
}
