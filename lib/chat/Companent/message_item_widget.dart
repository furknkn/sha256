import 'package:flutter/material.dart';

import '../chat_controller.dart';
class MessageItemWidget extends StatelessWidget {
   MessageItemWidget(
      { Key? key, required this.sentByMe, required this.message,required this.messageType,required this.convert})
      : super(key: key);
  final bool sentByMe;
  final String message;
  final String messageType;
  final bool convert;

 final ChatController chatController = ChatController();
  @override
  Widget build(BuildContext context) {
    Color purple = Color(0xffc5ce7);
    Color black = Color(0xff191919);
    Color white = Colors.white;
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
            color: sentByMe ? purple : white,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
             sentByMe?messageType=="spn"?chatController.spnPermutationDecode(message):message:messageType=="spn"?convert?chatController.spnPermutationEncode(message):message:message,
              style: TextStyle(
                color: sentByMe ? Colors.white : Colors.purple,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
