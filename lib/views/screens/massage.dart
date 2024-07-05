
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/services/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RoomMessageScreen extends StatefulWidget {
  final String email;
  const RoomMessageScreen({
    super.key,
    required this.email,
  });

  @override
  State<RoomMessageScreen> createState() => _RoomMessageScreenState();
}

class _RoomMessageScreenState extends State<RoomMessageScreen> {
  final authController = AuthController();
  final chatController = ChatController();
  final smsTextEditingController = TextEditingController();
  final chatFirebaseServices = ChatFirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chat with tester version",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ChatFirebaseServices().getMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty ||
              snapshot.hasError) {
            return Center(
              child: Text("Message mavjud emas ${snapshot.error}"),
            );
          }
          final messages = snapshot.data!.docs;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Message message = Message.fromJson(messages[index]);
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Text(
                            message.text,
                            // messages[index]["name"],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 10),
                child: TextFormField(
                  controller: smsTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        chatFirebaseServices.sendMessage(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          widget.email,
                          smsTextEditingController.text,
                        );
                        smsTextEditingController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}