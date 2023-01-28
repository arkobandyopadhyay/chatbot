part of 'admin_cubit.dart';




abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {
  const AdminInitial();
}

class AdminLoading extends AdminState {
  const AdminLoading();
}

class AdminSuccess extends AdminState {
  final List<Item> AdminList;

  const AdminSuccess(this.AdminList);

  @override
  List<Object> get props => [AdminList];
}

class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object> get props => [message];
}
