import 'package:bloc/bloc.dart';
import 'package:genix/features/chat%20screen/data/repos/chat_repository.dart';
import 'package:genix/features/chat%20screen/models/chat_room.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final ChatRepository getChatRepo = ChatRepository();

  Future<void> getChatRooms() async {
    emit(ChatLoadingState());
    final result = await getChatRepo.getChatRooms();
    print("result: $result");
    print("result data: ${result.fold((l) => null, (r) => r)}");
    result.fold((l) => emit(ChatFailureState()), (r) {
      ChatRoomResponse chatRoomResponse = ChatRoomResponse.fromJson(r as Map<String, dynamic>);
      emit(ChatSuccessState(
        chatRooms: chatRoomResponse.data.chatRooms,
      ));
    });
  }
}
