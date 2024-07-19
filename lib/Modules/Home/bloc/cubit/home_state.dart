part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool? isLoading;
  final UserModel? user;

  const HomeState({this.isLoading = false, this.user});
  @override
  List<Object?> get props => [isLoading, user];

  HomeState copyWith({bool? isLoading, UserModel? user}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
