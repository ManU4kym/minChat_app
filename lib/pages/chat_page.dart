import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minchat_app/components/text_field.dart';
import 'package:minchat_app/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiveUserId;
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiveUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    //only send message if there is something to send

    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiveUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: const Color(0xFF4F4A45),
        title: Center(child: Text(widget.receiverUserEmail)),
      ),
      body: Column(children: [
        //messages
        Expanded(
          child: _buildMessageList(),
        ),

        //user input
        _buildMessageInput()
      ]),
    );
  }

  //build the message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
          widget.receiveUserId,
          _firebaseAuth.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItems(document))
                .toList(),
          );
        });
  }

  // build the message items
  Widget _buildMessageItems(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    // align message on the right if its current user otherwise leftt

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmal']),
            Text(data['message']),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        //txtfield
        Expanded(
          child: MyTextField(
              controller: _messageController,
              hintText: "Enter Message",
              obscureText: false),
        ),
//send button
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
