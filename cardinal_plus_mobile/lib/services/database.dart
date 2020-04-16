import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cardinal_plus/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userInfo =
      Firestore.instance.collection('userdata');
  final CollectionReference studentNumber =
      Firestore.instance.collection('studentnumbers');

//to update user data
  Future<void> updateUserData(
      String name, String studentNumber, String email) async {
    return await userInfo.document(uid).setData({
      'name': name,
      'studentNumber': studentNumber,
      'email': email,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        email: snapshot.data['email'],
        name: snapshot.data['name'],
        studentNumber: snapshot.data['studentnumber']);
  }

  Stream<UserData> get userData {
    return userInfo.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  StudentNumber _studentNumberFromSnapshot(DocumentSnapshot snapshot) {
    return StudentNumber(studentNumber: snapshot.data['studentnumber']);
  }

  Stream<StudentNumber> get studentNumberCheck {
    return userInfo.document(uid).snapshots().map(_studentNumberFromSnapshot);
  }
}
