import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:nakshekadam_web/globals.dart';

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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth / 20),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: COLOR_THEME['drawerBackground'],
        title: Text(
          widget.room.name ?? 'Chat',
          style: TextStyle(
            fontFamily: 'DM Sans',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.01,
          ),
        ),
      ),
      body: StreamBuilder<types.Room>(
        initialData: widget.room,
        stream: FirebaseChatCore.instance.room(widget.room.id),
        builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
          initialData: const [],
          stream: FirebaseChatCore.instance.messages(snapshot.data!),
          builder: (context, snapshot) => Chat(
            theme: DefaultChatTheme(
              primaryColor: COLOR_THEME['primary']!,
              backgroundColor: COLOR_THEME['backgroundComponents2']!,
              inputTextColor: Colors.black,
              inputBackgroundColor: COLOR_THEME['studentType2']!,
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
    );
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }
}
