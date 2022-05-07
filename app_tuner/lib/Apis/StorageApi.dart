// import 'package:app_tuner/Apis/SettingsApi.dart';
// import 'package:app_tuner/models/Settings.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseSettingsStorageApi extends SettingsApi {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   final _collectionName = "tunerSettings";

//   @override
//   Future<void> deleteSettings(String id) async {
//     try {
//       // await _firebaseFirestore.collection("todos").doc(id).delete();
//       // _firebaseFirestore.collection("todos").doc();
//     } catch (e) {
//       // print("FirebaseException on delete: $e");
//     }
//   }

//   @override
//   Stream<TunerSettings> getSettings() {
//     // return _firebaseFirestore.collection(_collectionName).snapshots().asyncMap(
//     //     (event) => event.docs.map((e) => Todo.fromJson(e.data())).toList());
//     return const Stream.empty();
//   }

//   @override
//   Future<void> saveSettings(TunerSettings tunerSettings) async {
//     try {
//       // await _firebaseFirestore
//       //     .collection(_collectionName)
//       //     .doc(todo.id)
//       //     .set(todo.toJson());
//     } catch (e) {
//       // print("FirebaseException on add: $e");
//     }
//   }
// }
