import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/threat.dart';
import '../models/device_activity.dart';


class FirestoreService {
  final CollectionReference threatCollection = FirebaseFirestore.instance
      .collection('threats');

  Future<void> addThreat(Threat threat) async {
    await threatCollection.add(threat.toMap());
  }

  Stream<QuerySnapshot> getThreats() {
    return threatCollection.snapshots();
  }

  Future<int> getThreatCount() async {
    final snapshot = await threatCollection.get();
    return snapshot.docs.length;
  }

  Future<int> getHighThreatCount() async {
    final snapshot = await threatCollection
        .where('severity', isEqualTo: 'High')
        .get();

    return snapshot.docs.length;
  }

  Future<void> updateThreat(String id, Threat threat) async {
    await threatCollection.doc(id).update(threat.toMap());
  }

  Future<void> deleteThreat(String id) async {
    await threatCollection.doc(id).delete();
  }

  Future<void> addDeviceActivity(DeviceActivity activity) async {
    await FirebaseFirestore.instance
        .collection('device_activity')
        .add(activity.toMap());
  }
}
