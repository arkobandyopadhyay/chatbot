import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/utils/errors.dart';
import '../../../model/complaint_model.dart';
import '../admin_repository.dart';




part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final APIComplaintRepository _AdminRepository;
  AdminCubit(this._AdminRepository) : super(AdminInitial());
  Future<void> getAdminList() async {
    try {
      emit(AdminLoading());
      List<Item> AdminList = await _AdminRepository.getAllComplaints();
      print(AdminList);
      emit(AdminSuccess(AdminList));
    } on NetworkException {
      emit(AdminError("S.networkException"));
    } on ValidationException catch (e) {
      emit(AdminError(e.description));
    } on UnknownException {
      emit(AdminError("S.unknownException"));
    } catch (e) {
      print(e);
    }
  }
}
