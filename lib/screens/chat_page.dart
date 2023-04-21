// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_picker_timeline/extra/color.dart';
// import 'package:ez/screens/view/models/GetChatModel.dart';
//
// import 'package:ez/screens/view/models/User_Model.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_chat_app/pages/gallary_page.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../constant/global.dart';
//
// class ChatPage extends StatefulWidget {
//   // final SharedPreferences prefs;
//     String? bookingId;
//   // final String? title;
//   final User? user;
//   final providerName,providerId,providerImage;
//   ChatPage({this.user,this.providerId,this.providerImage,this.providerName,this.bookingId});
//   @override
//   ChatPageState createState() {
//     return new ChatPageState();
//   }
// }
//
// class ChatPageState extends State<ChatPage> {
//   StreamController<GetChatModel>? _postsController;
//
//   final db = FirebaseFirestore.instance;
//   CollectionReference? chatReference;
//    TextEditingController _textController = new TextEditingController();
//   bool _isWritting = false;
//
//   @override
//   void initState() {
//     _postsController = new StreamController();
//     loadMessage();
//     super.initState();
//
//
//     // chatReference =
//     //     db.collection("chats").doc(userID).collection('messages');
//   }
//
//   File? imageFiles;
// Future getMessage()async{
//   var headers = {
//     'Cookie': 'ci_session=132b223a903b145b8f1056a17a0c9ef325151d5f'
//   };
//   var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/get_chat'));
//   request.fields.addAll({
//     'booking_id': '${widget.bookingId}'
//   });
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   if (response.statusCode == 200) {
//     var finalResult = await response.stream.bytesToString();
//     // final jsonResponse = GetChatModel.fromJson(json.decode(finalResult));
//     // setState(() {
//     //   getChatModel = jsonResponse;
//     // });
//     //return json.decode(finalResult);
//     return GetChatModel.fromJson(json.decode(finalResult));
//   }
//   else {
//     print(response.reasonPhrase);
//   }
//
// }
//
// loadMessage()async{
// getMessage().then(( res)async{
//   _postsController!.add(res);
//   return res;
// });
// }
//
//   sendChatMessage(String type)async{
//     var headers = {
//       'Cookie': 'ci_session=cb5fe5415a2e7a3e28f499c842c30404bfbc8a99'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${baseUrl()}/send_message'));
//     request.fields.addAll({
//       'sender_id': '${userID}',
//       'sender_type': 'user',
//       'message': '${_textController.text}',
//       'message_type': '${type}',
//       'booking_id': '${widget.bookingId}',
//     });
//    imageFiles == null ? null : request.files.add(await http.MultipartFile.fromPath('chat', '${imageFiles!.path.toString()}'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   List<Widget> generateSenderLayout(DocumentSnapshot documentSnapshot) {
//     return <Widget>[
//       new Expanded(
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             new Text("Karan",
//                // documentSnapshot.data['sender_name'],
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
//             new Text("Karan",
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
//   generateMessages(AsyncSnapshot<GetChatModel> snapshot){
//     return snapshot.data!.data!
//         .map<Widget>((doc){
//           print("check docs here ${doc}");
//           return Container(
//             margin: const EdgeInsets.symmetric(vertical: 10.0),
//             child: new Row(
//                 children:[
//                   Expanded(
//                     child: new Column(
//                       crossAxisAlignment: doc.senderType == "user" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                       children: <Widget>[
//                         // doc['sender_id'] != "1"?
//                         // generateReceiverLayout(doc)
//                         // Text("receiver end ")
//                         //     :
//                         // widget.providerId == doc['id']
//                         //     ?
//                     doc.message == ""  || doc.message == null ? SizedBox.shrink() : doc.messageType == "image" ? Container(
//                       height: 90,
//                       width: 100,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(6),
//                           child: Image.network("${doc.message}",fit: BoxFit.fill,)),
//                     ) :  Container(
//                           padding:EdgeInsets.all(6),
//                           decoration:BoxDecoration(
//                             color: backgroundblack,
//                             borderRadius: BorderRadius.circular(6)
//                           ),
//                           child: Text("${doc.message}",
//                               // widget.user!.name.toString(),
//                                //documentSnapshot.data['sender_name'],
//                               style: new TextStyle(
//                                   fontSize: 14.0,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold)),
//                         )
//                       ],
//                     ),
//                   ),
//                 ]
//               //doc.data['sender_id']
//               //     "1" != "1"
//               // ? generateReceiverLayout(doc)
//               // : generateSenderLayout(doc),
//             ),
//           );
//     } )
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20)
//             )
//         ),
//         backgroundColor: backgroundblack,
//         elevation: 0,
//         title: Text(
//           '${widget.providerName}',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading:  Padding(
//           padding: const EdgeInsets.all(12),
//           child: RawMaterialButton(
//             shape: CircleBorder(),
//             padding: const EdgeInsets.all(0),
//             fillColor: Colors.white,
//             splashColor: Colors.grey[400],
//             child: Icon(
//               Icons.arrow_back,
//               size: 20,
//               color: appColorBlack,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         )
//
//       ),
//       body: Container(
//         padding: EdgeInsets.all(5),
//         child: new Column(
//           children: <Widget>[
//             StreamBuilder<GetChatModel>(
//               stream: _postsController!.stream,
//               builder: (BuildContext context,
//                   AsyncSnapshot<GetChatModel> snapshot) {
//                 if (!snapshot.hasData) return new Text("No Chat");
//                 return Expanded(
//                   child:
//
//                   ListView(
//                     reverse: false,
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
//       icon: new Icon(Icons.send,color: backgroundblack,),
//       onPressed: (){
//         setState(() {
//           sendChatMessage("text");
//           getMessage().then(( res)async{
//             _postsController!.add(res);
//             return res;
//           });
//           _textController.clear();
//         });
//       }
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
//                       color: backgroundblack,
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
//                       PickedFile? image = await ImagePicker.platform
//                           .pickImage(source: ImageSource.gallery);
//                       imageFiles = File(image!.path);
//                       print("image files here ${imageFiles!.path.toString()}");
//                       if(imageFiles != null){
//                         setState(() {
//                           sendChatMessage("image");
//                           getMessage().then(( res)async{
//                             _postsController!.add(res);
//                             return res;
//                           });
//                           _textController.clear();
//                         });
//                       }
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
//                   onSubmitted: _sendMsg,
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
//   // Future<Null> _sendText(String text) async {
//   //   _textController.clear();
//   //   chatReference!.add({
//   //     'text': text,
//   //     'receiver_id': "1",
//   //     "sender_id" : "1",
//   //     //widget.prefs.getString('uid'),
//   //     'receiver_name': "Karan",
//   //     //widget.prefs.getString('name'),
//   //     'profile_photo' : "",
//   //   //widget.prefs.getString('profile_photo'),
//   //     'image_url': '',
//   //     'time': FieldValue.serverTimestamp(),
//   //   }).then((documentReference) {
//   //     setState(() {
//   //       _isWritting = false;
//   //     });
//   //   }).catchError((e) {});
//   // }
//
//    _sendMsg(String text) async {
//     _textController.clear();
//     chatReference!.add({
//       'text': text,
//       'received' : true,
//       'id': "${widget.providerId}",
//       "sender_id" : "${userID}",
//       //widget.prefs.getString('uid'),
//       'name': "${widget.providerName}",
//       //widget.prefs.getString('name'),
//       'profile_photo' : "${widget.providerImage}",
//     //widget.prefs.getString('profile_photo'),
//       'image_url': '',
//       'time': FieldValue.serverTimestamp(),
//     }).then((documentReference) {
//       setState(() {
//         _isWritting = false;
//       });
//     }).catchError((e) {});
//   }
//   void _sendImage({ String? messageText, String? imageUrl}) {
//     chatReference!.add({
//       'text': messageText,
//
//       // 'sender_id': widget.prefs.getString('uid'),
//       // 'sender_name': widget.prefs.getString('name'),
//       // 'profile_photo': widget.prefs.getString('profile_photo'),
//       'image_url': imageUrl,
//       'time': FieldValue.serverTimestamp(),
//     });
//   }
// }