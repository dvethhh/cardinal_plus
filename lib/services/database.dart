import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cardinal_plus/announcements.dart';
import 'package:cardinal_plus/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference annoucementData =
      Firestore.instance.collection('announcements');
  final CollectionReference userInfo =
      Firestore.instance.collection('userdata');
  final CollectionReference studentNumberData =
      Firestore.instance.collection('studentnumbers');

  //announcements
  List<Announcements> _announcementsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Announcements(
          author: doc.data['author'] ?? '',
          message: doc.data['message'] ?? '',
          date: doc.data['date'] ?? '');
    }).toList();
  }
//to create announcements

//to update user data
  Future<void> updateUserData(
      String name, String studentNumber, String courseYear) async {
    return await userInfo.document(uid).setData({
      'name': name,
      'studentNumber': studentNumber,
      'courseYear': courseYear,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        name: snapshot.data['name'],
        studentNumber: snapshot.data['studentNumber'],
        courseYear: snapshot.data['courseYear']);
  }

//check
  String checkStudentNumber(int studentNumber) {
    DocumentSnapshot snapshot;
    if (snapshot.exists) {
      String email = snapshot.data.toString() + '@email.com';
      return email;
    } else
      return snapshot.data.toString();
  }

  Stream<UserData> get userData {
    return userInfo.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
