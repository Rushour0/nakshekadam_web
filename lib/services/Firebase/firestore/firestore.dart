import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference userDocumentCollection({required String collection}) {
  print(getCurrentUserId());
  return firestore
      .collection('users')
      .doc(getCurrentUserId())
      .collection(collection);
}

DocumentReference exploreDataRoleSpecificDocument({required Role role}) {
  print('called');
  return firestore
      .collection('explore_data')
      .doc(role.toString().split('.').last);
}

CollectionReference usersCollectionReference() {
  return firestore.collection('users');
}

DocumentReference<Map<String, dynamic>> userDocumentReference() {
  return firestore.collection('users').doc(getCurrentUserId());
}

Future<void> deleteDocumentByReference(DocumentReference reference) async {
  await firestore.runTransaction(
      (Transaction transaction) async => transaction.delete(reference));
}

setPublicData({
  required Map<String, dynamic> data,
  required Role role,
}) {
  exploreDataRoleSpecificDocument(role: role)
      .set(data, SetOptions(merge: true));
}
