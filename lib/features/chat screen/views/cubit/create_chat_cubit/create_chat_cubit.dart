import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/chat%20screen/data/repos/chat_repository.dart';
import 'package:genix/features/chat%20screen/models/chat_room.dart';

import '../../../../users/data/models/user_model.dart';

part 'create_chat_state.dart';

class CreateConversationCubit extends Cubit<CreateChatState> {
  CreateConversationCubit() : super(CreateChatInitial());
  final ChatRepository chatRepo = ChatRepository();

  void createConversation({required String type, required List<UserModel> userModel, String? groupName}) async {
    emit(CreateChatLoading());
    final result = await chatRepo.createChatRoom(type: type, users: userModel, groupName: groupName);
    result.fold((r) => emit(CreateChatError()), (r) {
      CreateChatRoomResponse createChatRoomResponse = CreateChatRoomResponse.fromJson(r as Map<String, dynamic>);
      emit(CreateChatSuccess(createChatRoomResponse: createChatRoomResponse));
    });
  }
}
