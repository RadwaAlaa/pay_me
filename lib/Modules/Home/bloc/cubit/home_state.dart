part of 'home_cubit.dart';

enum ToggleView { recharge, history }

class HomeState extends Equatable {
  final bool? isLoading;
  final UserModel? user;
  final List<BeneficiaryModel>? beneficiaryList;
  final ToggleView selectedView;
  final bool? isLoadingHistory;
  final bool? isLoadingBeneficiaries;

  const HomeState(
      {this.isLoading = false,
      this.user,
      this.beneficiaryList,
      this.selectedView = ToggleView.recharge,
      this.isLoadingHistory = false,
      this.isLoadingBeneficiaries = false});
  @override
  List<Object?> get props => [
        isLoading,
        user,
        beneficiaryList,
        selectedView,
        isLoadingHistory,
        isLoadingBeneficiaries
      ];

  HomeState copyWith({
    bool? isLoading,
    UserModel? user,
    List<BeneficiaryModel>? beneficiaryList,
    ToggleView selectedView = ToggleView.recharge,
    bool? isLoadingHistory,
    bool? isLoadingBeneficiaries,
  }) {
    return HomeState(
        isLoading: isLoading ?? this.isLoading,
        user: user ?? this.user,
        beneficiaryList: beneficiaryList ?? this.beneficiaryList,
        selectedView: selectedView,
        isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
        isLoadingBeneficiaries:
            isLoadingBeneficiaries ?? this.isLoadingBeneficiaries);
  }
}
