import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/widgets/widgets.dart';

import 'message_controller.dart';

class MessageView extends GetView<MessageController> {
  MessageView({super.key});
  static String routeName = "/message";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true, title: const Text('Messages')),
        body: Padding(
            padding: defaultScreenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildChatMessages(context),
                PrimaryButton(
                  title: 'Request Ambulance Service',
                  press: () {},
                  expanded: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildChatInput(context)
              ],
            )));
  }

  Widget _buildChatMessages(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: controller.chatSrv.stream(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = chatSnapshot.data!.docs;

            print(docs.length);

            return ListView.builder(
                reverse: true,
                itemCount: docs.length,
                itemBuilder: (ctx, index) =>
                    _buildChatBubble(context, message: docs[index]['message']));
          }),
    );
  }

  Widget _buildChatBubble(BuildContext context, {required String message}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          width: 140,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Text(message,
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color)),
        ),
      ],
    );
  }

  Widget _buildChatInput(BuildContext context) {
    return Obx(() => Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                decoration:
                    const InputDecoration(labelText: 'Send a message...'),
                onChanged: (value) {
                  controller.chatMessage.value = value;
                },
              )),
              IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: (controller.chatMessage.value.trim().isEmpty)
                      ? null
                      : () async {
                          await controller.sendMessage();
                        })
            ],
          ),
        ));
  }
}
