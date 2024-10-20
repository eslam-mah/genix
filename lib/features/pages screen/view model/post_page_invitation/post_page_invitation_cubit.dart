import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'post_page_invitation_state.dart';

class PostPageInvitationCubit extends Cubit<PostPageInvitationState> {
  PostPageInvitationCubit() : super(PostPageInvitationInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> postPageInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    emit(PostPageInvitationLoading());
    final result = await pagesRepository.postPageInvitation(data: data, id: id);
    result.fold(
      (l) => emit(PostPageInvitationError()),
      (r) {
        emit(const PostPageInvitationSuccess(
            message: 'Group joined successfully'));
      },
    );
  }
}
