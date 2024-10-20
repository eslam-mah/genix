import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/live_channel_model.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_live_channel_state.dart';

class GetLiveChannelCubit extends Cubit<GetLiveChannelState> {
  GetLiveChannelCubit() : super(GetLiveChannelInitial());
  final PostsRepository getLiveChannelRepo = PostsRepository();

  Future<void> getLiveChannel({required LiveChannelModel id}) async {
    emit(GetLiveChannelLoading());
    final result = await getLiveChannelRepo.getLiveChannel(id: id.id);
    result.fold((l) => emit(GetLiveChannelError()), (r) {
      final liveChannel = LiveChannelModel.fromJson(r as Map<String, dynamic>);
      emit(GetLiveChannelSuccess(liveChannel: liveChannel));
    });
  }
}
