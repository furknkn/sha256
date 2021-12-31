import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatMessage = <Message>[].obs;

late PlatformFile file;


  String rsa256(String value) {
    var key = utf8.encode('p@ssw0rd');
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    return digest.toString();
  }


  Future<FilePickerResult?> getFile()async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    file=result.files.first;
    return result;
  } else {
    return null;
    // User canceled the picker
  }
}



  String spnPermutationEncode(String plainText)
  {
    // key 4231
    String newValue="";
    String temp;
    String temp2;
    String temp3;
    String temp4;
    int mod;
    mod=plainText.length%4;
    for(int i=0;i<plainText.length-mod;)
      {
        temp=plainText[i];
        temp2=plainText[i+1];
        temp3=plainText[i+2];
        temp4=plainText[i+3];
        newValue += temp4 + temp2 + temp3 + temp;

        i=i+4;
      }
    newValue+=plainText.substring(plainText.length-mod,plainText.length);
    return newValue;
  }


  String spnPermutationDecode(String plainText)
  {
    // key 4231
    String newValue="";
    String temp;
    String temp2;
    String temp3;
    String temp4;
    int mod;
    mod=plainText.length%4;
    for(int i=0;i<plainText.length-mod;)
    {
      temp=plainText[i];
      temp2=plainText[i+1];
      temp3=plainText[i+2];
      temp4=plainText[i+3];
      newValue += temp4 + temp2 + temp3 + temp;

      i=i+4;
    }
    newValue+=plainText.substring(plainText.length-mod,plainText.length);
    return newValue;
  }

}

class Message {
  String message;
  String sentByMe;
  String messageType;

  Message({required this.message, required this.sentByMe,required this.messageType});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(message: json["message"], sentByMe: json["sentByMe"],messageType: json["messageType"]);
  }
}
