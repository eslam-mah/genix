import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_block_state.dart';

class DeleteBlockCubit extends Cubit<DeleteBlockState> {
  DeleteBlockCubit() : super(DeleteBlockInitial());
}
