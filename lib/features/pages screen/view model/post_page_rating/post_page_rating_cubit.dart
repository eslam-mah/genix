import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_page_rating_state.dart';

class PostPageRatingCubit extends Cubit<PostPageRatingState> {
  PostPageRatingCubit() : super(PostPageRatingInitial());
}
