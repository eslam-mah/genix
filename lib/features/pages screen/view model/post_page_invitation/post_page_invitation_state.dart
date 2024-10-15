part of 'post_page_invitation_cubit.dart';

sealed class PostPageInvitationState extends Equatable {
  const PostPageInvitationState();

  @override
  List<Object> get props => [];
}

final class PostPageInvitationInitial extends PostPageInvitationState {}

final class PostPageInvitationLoading extends PostPageInvitationState {}

final class PostPageInvitationSuccess extends PostPageInvitationState {
  final String message;

  const PostPageInvitationSuccess({required this.message});
}

final class PostPageInvitationError extends PostPageInvitationState {}
