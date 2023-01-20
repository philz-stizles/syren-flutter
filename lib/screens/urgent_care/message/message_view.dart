import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syren/models/models.dart';
import 'package:syren/utils/constants.dart';
import 'package:syren/utils/palette.dart';
import 'package:syren/widgets/widgets.dart';

import 'message_controller.dart';

class MessageView extends GetView<MessageController> {
  MessageView({super.key});
  static const String routeName = "/message";
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
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Palette.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
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

            return ListView.builder(
                reverse: true,
                itemCount: docs.length,
                itemBuilder: (ctx, index) => _buildChatBubble(context,
                    chat: ChatModel.fromDocumentSnapshot(docs[index])));
          }),
    );
  }

  Widget _buildChatBubble(BuildContext context, {required ChatModel chat}) {
    var currentUser = controller.userCtrl.user;
    var isCurrentUsersChat = currentUser!.id == chat.createdBy;

    return Row(
      mainAxisAlignment:
          isCurrentUsersChat ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width * 0.7,
          child: Column(
            crossAxisAlignment: isCurrentUsersChat
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                  decoration: BoxDecoration(
                    color: isCurrentUsersChat
                        ? Palette.primary
                        : Colors.transparent,
                    border: isCurrentUsersChat
                        ? null
                        : Border.all(width: 2.0, color: Palette.primary),
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft:
                            Radius.circular(isCurrentUsersChat ? 10 : 0),
                        bottomRight:
                            Radius.circular(isCurrentUsersChat ? 0 : 10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Text(chat.message,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: isCurrentUsersChat
                                ? Palette.white
                                : Palette.grey)),
                  )),
              const SizedBox(
                height: 8,
              ),
              Text(DateFormat('HH:mm a').format(chat.createdAt.toDate()),
                  style: const TextStyle(
                      color: Palette.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
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
