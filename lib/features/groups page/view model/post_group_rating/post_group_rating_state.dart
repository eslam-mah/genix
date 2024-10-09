part of 'post_group_rating_cubit.dart';

sealed class PostGroupRatingState extends Equatable {
  const PostGroupRatingState();

  @override
  List<Object> get props => [];
}

final class PostGroupRatingInitial extends PostGroupRatingState {}

final class PostGroupRatingLoading extends PostGroupRatingState {}

final class PostGroupRatingSuccess extends PostGroupRatingState {
  final GroupsModel rating;

  const PostGroupRatingSuccess({required this.rating});
}

final class PostGroupRatingError extends PostGroupRatingState {}
