import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:genix/features/chat%20screen/views/cubit/chat_cubit/chat_cubit.dart';
import 'package:genix/features/chat%20screen/views/widgets/chat_room_tile.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/all_app_strings.dart';

class ChatListingScreen extends StatefulWidget {
  const ChatListingScreen({super.key});

  @override
  State<ChatListingScreen> createState() => _ChatListingScreenState();
}

class _ChatListingScreenState extends State<ChatListingScreen> {
  final ChatCubit chatCubit = ChatCubit();

  @override
  void initState() {
    chatCubit.getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title:   Text('${AppStrings.chat.getString(context)}', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.error_outline, size: 22, color: Colors.white),
                  SizedBox(width: 8),
                  Text('${AppStrings.spam.getString(context)}', style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        bloc: chatCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return Container(child: const Center(child: CircularProgressIndicator()));
          } else if (state is ChatSuccessState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '${AppStrings.typeheretheusername.getString(context)}',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: state.chatRooms.length,
                    itemBuilder: (context, index) {
                      return ChatRoomTile(item: state.chatRooms[index]);
                    },
                  ),
                ],
              ),
            );
          } else if (state is ChatFailureState) {
            return  Center(child: Text('${AppStrings.failedtoloadthechatrroms.getString(context)}'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
