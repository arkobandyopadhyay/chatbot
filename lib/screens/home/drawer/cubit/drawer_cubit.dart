import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/errors.dart';
import '../../../../model/complaint_model.dart';
import '../Drawer_repository.dart';






part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  final APIDrawerRepository _DrawerRepository;
  DrawerCubit(this._DrawerRepository) : super(DrawerInitial());
  Future<void> getDrawerList() async {
    try {
      emit(DrawerLoading());
      List<Item> DrawerList = await _DrawerRepository.getAllComplaints();
      print(DrawerList);
      emit(DrawerSuccess(DrawerList));
    } on NetworkException {
      emit(DrawerError("S.networkException"));
    } on ValidationException catch (e) {
      emit(DrawerError(e.description));
    } on UnknownException {
      emit(DrawerError("S.unknownException"));
    } catch (e) {
      print(e);
    }
  }
}
