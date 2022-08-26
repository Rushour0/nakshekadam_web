import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nakshekadam_web/services/Firebase/fireauth/fireauth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

final FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference userDocumentCollection({required String collection}) {
  // print(getCurrentUserId());
  return firestore
      .collection('users')
      .doc(getCurrentUserId())
      .collection(collection);
}

DocumentReference exploreDataRoleSpecificDocument({required Role role}) {
  // print('called');
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

Future<void> setRequestStatus({
  bool accept = true,
  required String userId,
}) async {
  await firestore
      .collection('all_requests')
      .doc(getCurrentUserId())
      .collection('requests')
      .doc(userId)
      .update({
    'requestStatus': accept ? 'accepted' : 'rejected',
  });

  await usersCollectionReference()
      .doc(userId)
      .collection('requests')
      .doc(getCurrentUserId())
      .update({
    'requestStatus': accept ? 'accepted' : 'rejected',
  });

  if (!accept) return;
  // Current User
  final doc = await userDocumentReference().get();

  final data = doc.data()!;
  // print(data);

  data['createdAt'] = data['createdAt']?.millisecondsSinceEpoch;
  data['id'] = doc.id;
  data['lastSeen'] = data['lastSeen']?.millisecondsSinceEpoch;
  data['role'] = data['role'];
  data['updatedAt'] = data['updatedAt']?.millisecondsSinceEpoch;

  types.User currentUser = types.User.fromJson(data);

  // Other User
  final otherDoc = await usersCollectionReference().doc(userId).get();

  final Map<String, dynamic> otherData =
      otherDoc.data()! as Map<String, dynamic>;
  // print(data);

  otherData['createdAt'] = otherData['createdAt']?.millisecondsSinceEpoch;
  otherData['id'] = userId;
  otherData['lastSeen'] = otherData['lastSeen']?.millisecondsSinceEpoch;
  otherData['role'] = otherData['role'];
  otherData['updatedAt'] = otherData['updatedAt']?.millisecondsSinceEpoch;

  types.User otherUser = types.User.fromJson(otherData);

  // print(jsify(otherUser));

  await FirebaseChatCore.instance.createRoom(currentUser, otherUser);
}
