import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StompClient client;
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJpc3MiOiJDaGF0ZG9kb0NvbnZlcnNhdGlvblNlcnZpY2UiLCJpZCI6IlVTNTdiZmY4YWQ1MmQ5NDkwYWI4ZTA0NGJiMGEyZjY5NWYiLCJleHAiOjE2NzYxOTQ2OTgsImlhdCI6MTY3MzYwMjY5OH0.w_755Oz4W7yzJWd7sf9j_R5f1hVwUKjYUDQNsC5qI6Y";

  void _incrementCounter() {
    client.activate();
  }

  @override
  void dispose() {
    if (client != null) {
      client.deactivate();
    }
    super.dispose();
  }

  void onConnectCallback(StompFrame connectFrame) {
    print(connectFrame.body);
    client.subscribe(
      destination: '/users/newMessage',
      // headers: {"Authorization": "Bearer $token"},
      headers: {},
      callback: (frame) {
        // Received a frame for this subscription
        print(frame.body);
        print('it worked');
      },
    );
    print("i think i work");
  }

  @override
  void initState() {
    client = StompClient(
      config: StompConfig.SockJS(
        url: 'https://conversation.chatdodo.xyz/ws-registration?token=$token',
        onConnect: onConnectCallback,
        onWebSocketError: (dynamic error) => print(error.toString()),
        onStompError: (dynamic error) => print(error.toString()),
        onDisconnect: (f) => print('disconnected'),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                try {
                  client.send(
                    destination:
                        '/ws/v1/conversations/CN9556bcc9a7154218a5d97ac572a35671/sendMessage',
                    // headers: {"Authorization": "Bearer $token"},
                    headers: {},
                    body: '{"body" : "Salam"}',
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: const Text(
                'send',
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
