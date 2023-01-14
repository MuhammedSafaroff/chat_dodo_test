import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late StompClient client;

  void onConnectCallback(StompFrame connectFrame) {
    client.subscribe(
      destination: '/users/newMessage',
      headers: {},
      callback: (frame) {
        print(frame.body);
        print('it worked');
      },
    );
    print("i think i work");
  }

  @override
  void dispose() {
    if (client != null) {
      client.deactivate();
    }
    super.dispose();
  }

  @override
  void initState() {
    client = StompClient(
      config: StompConfig.SockJS(
        url:
            'https://conversation.chatdodo.xyz/ws-registration?token=${widget.token}',
        onConnect: onConnectCallback,
        onWebSocketError: (dynamic error) => print(error.toString()),
        onStompError: (dynamic error) => print(error.toString()),
        onDisconnect: (f) => print('disconnected'),
      ),
    );
    client.activate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
