part of 'get_live_channel_cubit.dart';

sealed class GetLiveChannelState extends Equatable {
  const GetLiveChannelState();

  @override
  List<Object> get props => [];
}

final class GetLiveChannelInitial extends GetLiveChannelState {}

final class GetLiveChannelLoading extends GetLiveChannelState {}

final class GetLiveChannelSuccess extends GetLiveChannelState {
  final LiveChannelModel liveChannel;
  const GetLiveChannelSuccess({required this.liveChannel});
}

final class GetLiveChannelError extends GetLiveChannelState {}
