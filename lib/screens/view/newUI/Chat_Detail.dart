// // import 'package:ez/constant/global.dart';
// // import 'package:flutter/material.dart';
// // import '../../../models/profile_model.dart';
// // import '../models/MessageModel.dart';
// // import '../models/User_Model.dart';
// //
// // class ChatDetailScreen extends StatefulWidget {
// //   UserMessageModel? user;
// //
// //   ChatDetailScreen({this.user});
// //
// //   @override
// //   _ChatDetailScreenState createState() => _ChatDetailScreenState();
// // }
// //
// // class _ChatDetailScreenState extends State<ChatDetailScreen> {
// //   _chatBubble(Message message, bool isMe, bool isSameUser) {
// //     if (isMe) {
// //       return Column(
// //         children: <Widget>[
// //           Container(
// //             alignment: Alignment.topRight,
// //             child: Container(
// //               constraints: BoxConstraints(
// //                 maxWidth: MediaQuery.of(context).size.width * 0.80,
// //               ),
// //               padding: EdgeInsets.all(10),
// //               margin: EdgeInsets.symmetric(vertical: 10),
// //               decoration: BoxDecoration(
// //                 color: backgroundblack,
// //                 borderRadius: BorderRadius.circular(15),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: backgroundblack,
// //                     spreadRadius: 1,
// //                     blurRadius: 1,
// //                   ),
// //                 ],
// //               ),
// //               child: Text(
// //                 message.text.toString(),
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           !isSameUser
// //               ? Row(
// //             mainAxisAlignment: MainAxisAlignment.end,
// //             children: <Widget>[
// //               Text(
// //                 message.time.toString(),
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: Colors.black45,
// //                 ),
// //               ),
// //               SizedBox(
// //                 width: 10,
// //               ),
// //               Container(
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.grey.withOpacity(0.2),
// //                       spreadRadius: 1,
// //                       blurRadius: 1,
// //                     ),
// //                   ],
// //                 ),
// //                 child: CircleAvatar(
// //                   radius: 15,
// //                   backgroundColor: backgroundgrey,
// //                   backgroundImage: AssetImage(message.sender!.imageUrl.toString()),
// //                 ),
// //               ),
// //             ],
// //           )
// //               : Container(
// //             child: null,
// //           ),
// //         ],
// //       );
// //     } else {
// //       return Column(
// //         children: <Widget>[
// //           Container(
// //             alignment: Alignment.topLeft,
// //             child: Container(
// //               constraints: BoxConstraints(
// //                 maxWidth: MediaQuery.of(context).size.width * 0.80,
// //               ),
// //               padding: EdgeInsets.all(10),
// //               margin: EdgeInsets.symmetric(vertical: 10),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(15),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.2),
// //                     spreadRadius: 1,
// //                     blurRadius: 1,
// //                   ),
// //                 ],
// //               ),
// //               child: Text(
// //                 message.text.toString(),
// //                 style: TextStyle(
// //                   color: Colors.black54,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           !isSameUser
// //               ? Row(
// //             children: <Widget>[
// //               Container(
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.grey.withOpacity(0.2),
// //                       spreadRadius: 1,
// //                       blurRadius: 1,
// //                     ),
// //                   ],
// //                 ),
// //                 child: CircleAvatar(
// //                   radius: 15,
// //                   backgroundImage: AssetImage(message.sender!.imageUrl.toString()),
// //                 ),
// //               ),
// //               SizedBox(
// //                 width: 10,
// //               ),
// //               Text(
// //                 message.time.toString(),
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: Colors.black45,
// //                 ),
// //               ),
// //             ],
// //           )
// //               : Container(
// //             child: null,
// //           ),
// //         ],
// //       );
// //     }
// //   }
// //
// //   _sendMessageArea() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 8),
// //       height: 70,
// //       color: Colors.white,
// //       child: Row(
// //         children: <Widget>[
// //           IconButton(
// //             icon: Icon(Icons.photo),
// //             iconSize: 25,
// //             color: backgroundgrey,
// //             onPressed: () {},
// //           ),
// //           Expanded(
// //             child: TextField(
// //               decoration: InputDecoration.collapsed(
// //                 hintText: 'Send a message..',
// //               ),
// //               textCapitalization: TextCapitalization.sentences,
// //             ),
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.send),
// //             iconSize: 25,
// //             color: backgroundgrey,
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     int? prevUserId;
// //     return Scaffold(
// //       backgroundColor: Color(0xFFF6F6F6),
// //       appBar: AppBar(
// //         backgroundColor: backgroundblack,
// //         centerTitle: true,
// //         title: RichText(
// //           textAlign: TextAlign.center,
// //           text: TextSpan(
// //             children: [
// //               TextSpan(
// //                   text: widget.user!.name.toString(),
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w400,
// //                   )),
// //               TextSpan(text: '\n'),
// //               widget.user!.isOnline == true ?
// //               TextSpan(
// //                 text: 'Online',
// //                 style: TextStyle(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.w400,
// //                 ),
// //               )
// //                   :
// //               TextSpan(
// //                 text: 'Offline',
// //                 style: TextStyle(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.w400,
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //         leading: IconButton(
// //             icon: Icon(Icons.arrow_back_ios),
// //             color: Colors.white,
// //             onPressed: () {
// //               Navigator.pop(context);
// //             }),
// //       ),
// //       body: Column(
// //         children: <Widget>[
// //           Expanded(
// //             child: ListView.builder(
// //               reverse: true,
// //               padding: EdgeInsets.all(20),
// //               itemCount: messages.length,
// //               itemBuilder: (BuildContext context, int index) {
// //                 final Message message = messages[index];
// //                 final bool isMe = message.sender!.id == currentUser.id;
// //                 final bool isSameUser = prevUserId == message.sender!.id;
// //                 prevUserId = message.sender!.id;
// //                 return _chatBubble(message, isMe, isSameUser);
// //               },
// //             ),
// //           ),
// //           _sendMessageArea(),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ez/screens/view/models/User_Model.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_chat_app/pages/gallary_page.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
//
//
// class ChatPage extends StatefulWidget {
//   //final SharedPreferences prefs;
//
//   final String chatId;
//   final String title;
//   ChatPage({ required this.chatId,required this.title});
//   @override
//   ChatPageState createState() {
//     return new ChatPageState();
//   }
// }
//
// class ChatPageState extends State<ChatPage> {
//   final db = FirebaseFirestore.instance;
//   CollectionReference? chatReference;
//   TextEditingController _textController = new TextEditingController();
//   bool _isWritting = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // DocumentReference docSnap = db.collection("chats").doc(widget.chatId).collection('messages').doc(widget.chatId);
//     chatReference =
//         db.collection("chats").doc(widget.chatId).collection('messages') ;
//   }
//
//   List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
//     return <Widget>[
//       new Expanded(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             new Text("",
//                 //documentSnapshot.data['text'].toString(),
//                 // widget.user!.name.toString(),
//                 //documentSnapshot.data['sender_name'],
//                 style: new TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold)),
//             // new Container(
//             //   margin: const EdgeInsets.only(top: 5.0),
//             //   child: documentSnapshot.data['image_url'] != ''
//             //       ? InkWell(
//             //     child: new Container(
//             //       child: Image.network(
//             //         documentSnapshot.data['image_url'],
//             //         fit: BoxFit.fitWidth,
//             //       ),
//             //       height: 150,
//             //       width: 150.0,
//             //       color: Color.fromRGBO(0, 0, 0, 0.2),
//             //       padding: EdgeInsets.all(5),
//             //     ),
//             //     onTap: () {
//             //       // Navigator.of(context).push(
//             //       //   MaterialPageRoute(
//             //       //     builder: (context) => GalleryPage(
//             //       //       imagePath: documentSnapshot.data['image_url'],
//             //       //     ),
//             //       //   ),
//             //       // );
//             //     },
//             //   )
//             //       : new Text(documentSnapshot.data['text']),
//             // ),
//           ],
//         ),
//       ),
//       new Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: <Widget>[
//           // new Container(
//           //     margin: const EdgeInsets.only(left: 8.0),
//           //     child: new CircleAvatar(
//           //       backgroundImage:
//           //       new NetworkImage(documentSnapshot.data['profile_photo']),
//           //     )),
//         ],
//       ),
//     ];
//   }
//
//   List<Widget> generateReceiverLayout(DocumentSnapshot documentSnapshot) {
//     return <Widget>[
//       new Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // new Container(
//           //     margin: const EdgeInsets.only(right: 8.0),
//           //     child: new CircleAvatar(
//           //       backgroundImage:
//           //       new NetworkImage(documentSnapshot.data['profile_photo']),
//           //     )),
//         ],
//       ),
//       new Expanded(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new Text("",
//                 //documentSnapshot.data['sender_name'],
//                 style: new TextStyle(
//                     fontSize: 14.0,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold)),
//             // new Container(
//             //   margin: const EdgeInsets.only(top: 5.0),
//             //   child: documentSnapshot.data['image_url'] != ''
//             //       ? InkWell(
//             //     child: new Container(
//             //       child: Image.network(
//             //         documentSnapshot.data['image_url'],
//             //         fit: BoxFit.fitWidth,
//             //       ),
//             //       height: 150,
//             //       width: 150.0,
//             //       color: Color.fromRGBO(0, 0, 0, 0.2),
//             //       padding: EdgeInsets.all(5),
//             //     ),
//             //     onTap: () {
//             //       // Navigator.of(context).push(
//             //       //   MaterialPageRoute(
//             //       //     builder: (context) => GalleryPage(
//             //       //       imagePath: documentSnapshot.data['image_url'],
//             //       //     ),
//             //       //   ),
//             //       // );
//             //     },
//             //   )
//             //       : new Text(documentSnapshot.data['text']),
//             // ),
//           ],
//         ),
//       ),
//     ];
//   }
//
//   generateMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
//     return snapshot.data!.docs
//         .map<Widget>((doc) => Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: new Row(
//           children: [
//             Expanded(
//               child: new Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   doc['sender_id'] != widget?
//                   // generateReceiverLayout(doc)
//                   Text("receiver end ")
//                       :  Text(doc['text'].toString(),
//                       // widget.user!.name.toString(),
//                       //documentSnapshot.data['sender_name'],
//                       style: new TextStyle(
//                           fontSize: 14.0,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold)),
//                   // Row(
//                   //   children: doc.data['sender_id'] != widget.prefs.getString('uid')
//                   //       ? generateReceiverLayout(doc)
//                   //       : Expanded(
//                   //     child: new Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.end,
//                   //       children: <Widget>[
//                   //         new Text("",
//                   //             //documentSnapshot.data['text'].toString(),
//                   //             // widget.user!.name.toString(),
//                   //             //documentSnapshot.data['sender_name'],
//                   //             style: new TextStyle(
//                   //                 fontSize: 14.0,
//                   //                 color: Colors.black,
//                   //                 fontWeight: FontWeight.bold)),
//                   //         // new Container(
//                   //         //   margin: const EdgeInsets.only(top: 5.0),
//                   //         //   child: documentSnapshot.data['image_url'] != ''
//                   //         //       ? InkWell(
//                   //         //     child: new Container(
//                   //         //       child: Image.network(
//                   //         //         documentSnapshot.data['image_url'],
//                   //         //         fit: BoxFit.fitWidth,
//                   //         //       ),
//                   //         //       height: 150,
//                   //         //       width: 150.0,
//                   //         //       color: Color.fromRGBO(0, 0, 0, 0.2),
//                   //         //       padding: EdgeInsets.all(5),
//                   //         //     ),
//                   //         //     onTap: () {
//                   //         //       // Navigator.of(context).push(
//                   //         //       //   MaterialPageRoute(
//                   //         //       //     builder: (context) => GalleryPage(
//                   //         //       //       imagePath: documentSnapshot.data['image_url'],
//                   //         //       //     ),
//                   //         //       //   ),
//                   //         //       // );
//                   //         //     },
//                   //         //   )
//                   //         //       : new Text(documentSnapshot.data['text']),
//                   //         // ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   //
//                   //   // Text(doc['text'].toString(),
//                   //   //     // widget.user!.name.toString(),
//                   //   //     //documentSnapshot.data['sender_name'],
//                   //   //     style: new TextStyle(
//                   //   //         fontSize: 14.0,
//                   //   //         color: Colors.black,
//                   //   //         fontWeight: FontWeight.bold)),
//                   //       // : generateSenderLayout(doc),
//                   // )
//
//                   // new Container(
//                   //   margin: const EdgeInsets.only(top: 5.0),
//                   //   child: documentSnapshot.data['image_url'] != ''
//                   //       ? InkWell(
//                   //     child: new Container(
//                   //       child: Image.network(
//                   //         documentSnapshot.data['image_url'],
//                   //         fit: BoxFit.fitWidth,
//                   //       ),
//                   //       height: 150,
//                   //       width: 150.0,
//                   //       color: Color.fromRGBO(0, 0, 0, 0.2),
//                   //       padding: EdgeInsets.all(5),
//                   //     ),
//                   //     onTap: () {
//                   //       // Navigator.of(context).push(
//                   //       //   MaterialPageRoute(
//                   //       //     builder: (context) => GalleryPage(
//                   //       //       imagePath: documentSnapshot.data['image_url'],
//                   //       //     ),
//                   //       //   ),
//                   //       // );
//                   //     },
//                   //   )
//                   //       : new Text(documentSnapshot.data['text']),
//                   // ),
//                 ],
//               ),
//             ),
//           ]
//         //doc.data['sender_id']
//         // "11" != widget.user!.id.toString()
//         //getString('uid')
//         //     ? generateReceiverLayout(doc)
//         //     :
//         // generateSenderLayout(doc),
//       ),
//     ))
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(5),
//         child: new Column(
//           children: <Widget>[
//             StreamBuilder<QuerySnapshot>(
//               stream:
//               //FirebaseFirestore.instance.collection("chats").doc(widget.chatId).collection('messages').snapshots(),
//               chatReference!.orderBy('time',descending: true).snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 // DocumentSnapshot message =
//                 // snapshot.data!.docs[0];
//                 if (!snapshot.hasData) return new Text("No Chat");
//                 return Expanded(
//                   child: new ListView(
//                     reverse: true,
//                     children: generateMessages(snapshot),
//                   ),
//                 );
//               },
//             ),
//             new Divider(height: 1.0),
//             new Container(
//               decoration: new BoxDecoration(color: Theme.of(context).cardColor),
//               child: _buildTextComposer(),
//             ),
//             new Builder(builder: (BuildContext context) {
//               return new Container(width: 0.0, height: 0.0);
//             })
//           ],
//         ),
//       ),
//     );
//   }
//
//   IconButton getDefaultSendButton() {
//     return new IconButton(
//       icon: new Icon(Icons.send),
//       onPressed: _isWritting
//           ? () => _sendText(_textController.text)
//           : null,
//     );
//   }
//
//   Widget _buildTextComposer() {
//     return new IconTheme(
//         data: new IconThemeData(
//           color: _isWritting
//               ? Theme.of(context).accentColor
//               : Theme.of(context).disabledColor,
//         ),
//         child: new Container(
//           margin: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: new Row(
//             children: <Widget>[
//               new Container(
//                 margin: new EdgeInsets.symmetric(horizontal: 4.0),
//                 child: new IconButton(
//                     icon: new Icon(
//                       Icons.photo_camera,
//                       color: Theme.of(context).accentColor,
//                     ),
//                     onPressed: () async {
//                       // var image = await ImagePicker.
//                       // pickImage(
//                       //     source: ImageSource.gallery);
//                       // int timestamp = new DateTime.now().millisecondsSinceEpoch;
//                       // StorageReference storageReference = FirebaseStorage
//                       //     .instance
//                       //     .ref()
//                       //     .child('chats/img_' + timestamp.toString() + '.jpg');
//                       // StorageUploadTask uploadTask =
//                       // storageReference.putFile(image);
//                       // await uploadTask.onComplete;
//                       // String fileUrl = await storageReference.getDownloadURL();
//                       // _sendImage(messageText: null, imageUrl: fileUrl);
//                     }),
//               ),
//               new Flexible(
//                 child: new TextField(
//                   controller: _textController,
//                   onChanged: (String messageText) {
//                     setState(() {
//                       _isWritting = messageText.length > 0;
//                     });
//                   },
//                   onSubmitted: _sendText,
//                   decoration:
//                   new InputDecoration.collapsed(hintText: "Send a message"),
//                 ),
//               ),
//               new Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: getDefaultSendButton(),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Future<Null> _sendText(String text) async {
//     _textController.clear();
//     chatReference!.add({
//       'text': text,
//       'sender_id': widget.user!.id.toString(),
//       //prefs.getString('uid'),
//       'sender_name': widget.user!.name.toString(),
//       // prefs.getString('name'),
//       'profile_photo': widget.user!.imageUrl.toString(),
//       // prefs.getString('profile_photo'),
//       'image_url': '',
//       'time': FieldValue.serverTimestamp(),
//     }).then((documentReference) {
//       setState(() {
//         _isWritting = false;
//       });
//     }).catchError((e) {});
//   }
//
//   void _sendImage({ String? messageText, String? imageUrl}) {
//     chatReference!.add({
//       'text': messageText,
//       'sender_id': widget.user!.id.toString(),
//       //  .getString('uid'),
//       'sender_name': widget.user!.name.toString(),
//       //.getString('name'),
//       'profile_photo': widget.user!.imageUrl.toString(),
//       //.getString('profile_photo'),
//       'image_url': imageUrl,
//       'time': FieldValue.serverTimestamp(),
//     });
//   }
// }