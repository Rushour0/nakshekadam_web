import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nakshekadam_web/globals.dart';
import 'package:nakshekadam_web/services/Firebase/firestore/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
  });

  final types.Room room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;
  bool isNegative = false;
  String personUid = "";

  @override
  void initState() {
    super.initState();
    personUid = (widget.room.users
        .where((element) =>
            element.role == types.Role.student ||
            element.role == types.Role.parent)
        .toList()[0]
        .id);
    checkForNegativeSentiments();
  }

  Future<bool> checkForNegativeSentiments() async {
    String userId = (widget.room.users
        .where((element) =>
            element.role == types.Role.student ||
            element.role == types.Role.parent)
        .toList()[0]
        .id);
    Map<String, dynamic> data =
        (await firestore.collection('users').doc(userId).get()).data()
            as Map<String, dynamic>;
    print("A LOT OF DATA WAS HERERERERERER : ${data['firstName']}");
    isNegative = data['negative_sentiments'] ?? false;
    // print(data);
    setState(() {});
    return isNegative;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              String url = await FirebaseStorage.instance
                  .ref('reports/$personUid.pdf')
                  .getDownloadURL();
              launchUrl(Uri.parse(url));
            },
            icon: Icon(Icons.download),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenHeight / 20),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: COLOR_THEME['drawerBackground'],
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.025),
          child: FutureBuilder(
            initialData: Colors.white,
            future: checkForNegativeSentiments(),
            builder: (builder, snapshot) => Text(
              (widget.room.name ?? 'Chat') +
                  (!isNegative ? "" : " - Experiencing negative sentiments"),
              style: TextStyle(
                fontFamily: 'DM Sans',
                color: isNegative ? Colors.red : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.01,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenHeight / 20),
          color: Colors.white,
        ),
        child: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) => Chat(
              showUserAvatars: true,
              theme: DefaultChatTheme(
                primaryColor: COLOR_THEME['primary']!,
                backgroundColor: COLOR_THEME['backgroundComponents2']!,
                inputTextColor: Colors.black,
                inputBackgroundColor: Colors.grey.shade200,
              ),
              isAttachmentUploading: _isAttachmentUploading,
              messages: snapshot.data ?? [],
              onSendPressed: _handleSendPressed,
              user: types.User(
                id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }
}
