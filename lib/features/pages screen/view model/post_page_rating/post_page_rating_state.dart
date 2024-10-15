part of 'post_page_rating_cubit.dart';

sealed class PostPageRatingState extends Equatable {
  const PostPageRatingState();

  @override
  List<Object> get props => [];
}

final class PostPageRatingInitial extends PostPageRatingState {}

final class PostPageRatingLoading extends PostPageRatingState {}

final class PostPageRatingSuccess extends PostPageRatingState {
  final PagesModel page;

  const PostPageRatingSuccess({required this.page});
}

final class PostPageRatingError extends PostPageRatingState {}
