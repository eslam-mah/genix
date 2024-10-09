import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_page_invitation_state.dart';

class PostPageInvitationCubit extends Cubit<PostPageInvitationState> {
  PostPageInvitationCubit() : super(PostPageInvitationInitial());
}
