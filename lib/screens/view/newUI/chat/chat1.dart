import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

   Map<String,dynamic>? userMap;
   String? chatRoomId;

  ChatPage({this.chatRoomId,this.userMap});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {



  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat user list"),
      ),
      body: Container(),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height/10,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height/12,
          width: MediaQuery.of(context).size.width/1.1,
          child: Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/12,
                width: MediaQuery.of(context).size.width/1.5,
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.send))
            ],
          ),
        ),
      ),
    );
  }
}
