import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/models/pages_model.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'post_page_rating_state.dart';

class PostPageRatingCubit extends Cubit<PostPageRatingState> {
  PostPageRatingCubit() : super(PostPageRatingInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> postPageRating(
      {required PagesModel data, required int id}) async {
    emit(PostPageRatingLoading());
    final result =
        await pagesRepository.postPageRating(data: data.toJson(), id: id);
    result.fold(
      (l) => emit(PostPageRatingError()),
      (r) {
        final rating = PagesModel.fromJson(data.toJson());
        emit(PostPageRatingSuccess(page: rating));
      },
    );
  }
}
