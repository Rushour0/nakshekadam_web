import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference userDocumentCollection({required String collection}) {
  print(getCurrentUserId());
  return firestore
      .collection('users')
      .doc(getCurrentUserId())
      .collection(collection);
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
