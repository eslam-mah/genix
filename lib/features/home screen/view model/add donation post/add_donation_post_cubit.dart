import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_donation_post_state.dart';

class AddDonationPostCubit extends Cubit<AddDonationPostState> {
  AddDonationPostCubit() : super(AddDonationPostInitial());
  final PostsRepository addDonationRepo = PostsRepository();
  Future<void> addDonationPost(
      {required Map<String, dynamic> data,
      required PostsModel postId,
      required String giftId}) async {
    emit(AddDonationPostLoading());
    final result = await addDonationRepo.addDonationOnPost(
        data: data, postId: postId.collection!.first.id, giftId: giftId);
    result.fold((l) {
      emit(AddDonationPostError());
    }, (r) {
      emit(
          const AddDonationPostSuccess(message: 'Donation added successfully'));
    });
  }
}
