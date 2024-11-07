import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/features/chat%20screen/views/cubit/chat_cubit/chat_cubit.dart';
import 'package:genix/features/chat%20screen/views/widgets/chat_room_tile.dart';
import 'package:go_router/go_router.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(Rout.createNewChat);
        },
        backgroundColor: AppColors.kPrimaryColor,
        child: Icon(
          FontAwesomeIcons.add,
          color: Colors.white,
          size: 20.r,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.kPrimaryColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.error_outline, size: 22.r, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text("Spam",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        bloc: chatCubit,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ));
          } else if (state is ChatSuccessState) {
            return RefreshIndicator(
              onRefresh: () => chatCubit.getChatRooms(),
              color: AppColors.kPrimaryColor,
              child: ListView(
                children: [
                  SizedBox(height: 16.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type here the user name',
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: state.chatRooms.length,
                    itemBuilder: (context, index) {
                      return ChatRoomTile(item: state.chatRooms[index]);
                    },
                  ),
                ],
              ),
            );
          } else if (state is ChatFailureState) {
            return const Center(child: Text("Failed to load chat rooms"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
