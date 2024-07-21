part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool? isLoading;
  final UserModel? user;
  final List<BeneficiaryModel>? beneficiaryList;

  const HomeState({this.isLoading = false, this.user, this.beneficiaryList});
  @override
  List<Object?> get props => [isLoading, user, beneficiaryList];

  HomeState copyWith(
      {bool? isLoading,
      UserModel? user,
      List<BeneficiaryModel>? beneficiaryList}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      beneficiaryList: beneficiaryList ?? this.beneficiaryList,
    );
  }
}
