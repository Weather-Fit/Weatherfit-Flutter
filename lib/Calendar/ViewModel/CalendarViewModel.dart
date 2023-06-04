import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarViewModel {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<DocumentSnapshot<Object?>>> getDataByDate(
      String uid, DateTime selectedDate) async {
    try {
      QuerySnapshot<Object?> snapshot = await firestore
          .collection('calendar')
          .where('uid', isEqualTo: uid)
          .where('selectedDate', isEqualTo: selectedDate)
          .get();

      List<DocumentSnapshot<Object?>> documents = snapshot.docs;
      return documents;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
