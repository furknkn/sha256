
import 'package:flutter_test/flutter_test.dart';
import 'package:sha256/chat/chat_controller.dart';

void main() {


  group('chatController test', (){

    var chatController=ChatController();


    test('SPN encode', (){
      var test="test text";
     var key= chatController.spnPermutationEncode(test);
      expect(key, "testxte t");
    });
    test('SPN decode', (){
      var test="testxte t";
      var key= chatController.spnPermutationDecode(test);
      expect(key, "test text");
    });
    test('SHA256 şifreleme', (){
      var test="test text";
      var key= chatController.rsa256(test);
      expect(key, "8fdabb0e00d1b45d6d957379acf9b5165ea0ba7406bfa97ab697a07d8e96a0f8");
    });
    test('mesaj türü spn mi', (){
      final message=Message(message: "test mesaj", sentByMe: "true", messageType: "spn");
      expect(message.messageType, "spn");
    });
    test('Get File', (){
      var file= chatController.getFile();
      expect(file,isNotNull);
    });
  });

}
