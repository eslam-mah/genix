part of 'share_post_cubit.dart';

sealed class SharePostState extends Equatable {
  const SharePostState();

  @override
  List<Object> get props => [];
}

final class SharePostInitial extends SharePostState {}

final class SharePostLoading extends SharePostState {}

final class SharePostSuccess extends SharePostState {
  final ShareForm share;
  const SharePostSuccess({required this.share});
}

final class SharePostError extends SharePostState {}
