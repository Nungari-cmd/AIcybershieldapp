import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/threat.dart';

class FirestoreService {
  final CollectionReference threatCollection =
      FirebaseFirestore.instance.collection(
    'threats',
  );

  Future<void> addThreat(
      Threat threat) async {
    await threatCollection.add(
      threat.toMap(),
    );
  }

  Stream<QuerySnapshot> getThreats() {
    return threatCollection.snapshots();
  }

  Future<void> updateThreat(
    String id,
    Threat threat,
  ) async {
    await threatCollection
        .doc(id)
        .update(threat.toMap());
  }

  Future<void> deleteThreat(
      String id) async {
    await threatCollection
        .doc(id)
        .delete();
  }
}