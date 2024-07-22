part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final bool? isLoading;
  final double? selectedAmount;
  final bool? isTransactionSuccess;
  const TransactionState({
    this.isLoading = false,
    this.selectedAmount = 0,
    this.isTransactionSuccess = false,
  });

  @override
  List<Object?> get props => [
        isLoading,
        selectedAmount,
        isTransactionSuccess,
      ];

  TransactionState copyWith({
    bool? isLoading,
    double? selectedAmount,
    bool? isTransactionSuccess,
  }) {
    return TransactionState(
      isLoading: isLoading ?? this.isLoading,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      isTransactionSuccess: isTransactionSuccess ?? this.isTransactionSuccess,
    );
  }
}
