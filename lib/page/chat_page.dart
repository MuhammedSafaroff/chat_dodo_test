import 'dart:convert';

import 'package:chat_dodo/data/message_service.dart';
import 'package:chat_dodo/widgets/title_item.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../core/assets.dart';
import '../data/message_res_model.dart';
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
  bool isLoading = true;
  bool isError = false;
  MessageResModel? data;
  ValueNotifier<bool> messageButton = ValueNotifier<bool>(false);

  void onConnectCallback(StompFrame connectFrame) {
    client.subscribe(
      destination: '/users/newMessage',
      headers: {},
      callback: (frame) {
        final value = Content.fromJson(json.decode(frame.body!));
        data!.content!.add(value);
        setState(() {});
      },
    );
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
    MessageService().getMessage(widget.token).then((value) {
      if (value != null) {
        data = value;
        isError = false;
      } else {
        isError = true;
      }
      isLoading = false;
      setState(() {});
    });
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
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: const Color(0xff694BFF),
                        ),
                      )
                    : isError
                        ? Center(
                            child: Text(
                              "Error",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  TitleItem(
                                    name: data!.content![index]!
                                            .isSentByCurrentUser!
                                        ? "You"
                                        : data!.content![index]!.author!
                                            .metadata!.displayName!,
                                  ),
                                  ChatItem(
                                    message: data!.content![index]!.body!,
                                  ),
                                ],
                              );
                            },
                            itemCount: data!.content!.length,
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
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          messageButton.value = true;
                        } else {
                          messageButton.value = false;
                        }
                      },
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
                        const Spacer(),
                        ValueListenableBuilder<bool>(
                            valueListenable: messageButton,
                            builder: (context, val, _) {
                              return InkWell(
                                onTap: () {
                                  if (!isError) {
                                    client.send(
                                      destination:
                                          '/ws/v1/conversations/CN9556bcc9a7154218a5d97ac572a35671/sendMessage',
                                      headers: {},
                                      body:
                                          '{"body" : "${txtController.text}"}',
                                    );
                                  }
                                },
                                child: Image.asset(
                                  val ? Assets.activeSend : Assets.send,
                                  height: 24,
                                ),
                              );
                            }),
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
