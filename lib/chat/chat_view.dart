import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Companent/message_item_widget.dart';
import 'chat_controller.dart';

class ChatIo extends StatefulWidget {
  const ChatIo({Key? key}) : super(key: key);

  @override
  _ChatIoState createState() => _ChatIoState();
}

class _ChatIoState extends State<ChatIo> {
  bool pass=true;
  Color purple = Color(0xffc5ce7);
  Color black = Color(0xff191919);
  TextEditingController txtMsgInputController = TextEditingController();
  late IO.Socket socket;
  ChatController chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    var x = MediaQuery.of(context).size.width;
    var y = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: black,
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: Obx(
                  () => ListView.builder(
                    itemCount: chatController.chatMessage.length,
                    itemBuilder: (context, index) {
                      var currentItem = chatController.chatMessage[index];
                      return MessageItemWidget(
                        convert: pass,
                          sentByMe: currentItem.sentByMe == socket.id,
                          message: currentItem.message,
                          messageType: currentItem.messageType);
                    },
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: txtMsgInputController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple,
                        ),
                        child: Container(
                          width: x * 0.3,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: x * 0.1,
                                child: RaisedButton(
                                  onPressed: () {
                                    sendMessage(
                                        chatController
                                            .rsa256(txtMsgInputController.text),
                                        "sha");
                                    txtMsgInputController.text = "";
                                  },
                                  child: Text("SHA256"),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                width: x * 0.1,
                                child: RaisedButton(
                                  onPressed: () {
                                    sendMessage(
                                        chatController.spnPermutationEncode(
                                            txtMsgInputController.text),
                                        "spn");
                                    txtMsgInputController.text = "";
                                  },
                                  child: Text("SPN"),
                                ),
                              ),
                              IconButton(onPressed: () {
                                setState(() {
                                  pass=!pass;
                                });
                              }, icon:Icon(Icons.password))
                            ],
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    socket = IO.io(
        'http://localhost:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    setUpSocketListener();
    super.initState();
  }

  void sendMessage(String text, String mesType) {
    var messageJson = {
      "message": text,
      "sentByMe": socket.id,
      "messageType": mesType
    };
    socket.emit("message", messageJson);
    chatController.chatMessage.add(Message.fromJson(messageJson));
  }

  void setUpSocketListener() {
    socket.on('message-recaive', (data) {
      print(data);
      chatController.chatMessage.add(Message.fromJson(data));
    });
  }
}
