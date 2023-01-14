import 'package:chat_dodo/widgets/title_item.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../core/assets.dart';
import '../widgets/chat_item.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late StompClient client;
  TextEditingController txtController = TextEditingController();
  FocusNode txtNode = FocusNode();

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat page"),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < 20; i++)
                      Column(
                        children: [
                          TitleItem(),
                          ChatItem(),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 2,
                  top: 12,
                  left: 8,
                  right: 8,
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      focusNode: txtNode,
                      controller: txtController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Send message to Phillip Collins',
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          Assets.smile,
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          Assets.save,
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          Assets.attach,
                          height: 24,
                        ),
                        Spacer(),
                        Image.asset(
                          Assets.send,
                          height: 24,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
