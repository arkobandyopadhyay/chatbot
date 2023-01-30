part of 'drawer_cubit.dart';




abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {
  const DrawerInitial();
}

class DrawerLoading extends DrawerState {
  const DrawerLoading();
}

class DrawerSuccess extends DrawerState {
  final List<Item> DrawerList;

  const DrawerSuccess(this.DrawerList);

  @override
  List<Object> get props => [DrawerList];
}

class DrawerError extends DrawerState {
  final String message;

  const DrawerError(this.message);

  @override
  List<Object> get props => [message];
}
