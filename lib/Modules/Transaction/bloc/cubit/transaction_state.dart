part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final bool? isLoading;
  final double? selectedAmount;
  final bool? isTransactionSuccess;
  final String? error;
  const TransactionState({
    this.isLoading = false,
    this.selectedAmount = 0,
    this.isTransactionSuccess = false,
    this.error,
  });

  @override
  List<Object?> get props => [
        isLoading,
        selectedAmount,
        isTransactionSuccess,
        error,
      ];

  TransactionState copyWith({
    bool? isLoading,
    double? selectedAmount,
    bool? isTransactionSuccess,
    String? error,
  }) {
    return TransactionState(
      isLoading: isLoading ?? this.isLoading,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      isTransactionSuccess: isTransactionSuccess ?? this.isTransactionSuccess,
      error: error ?? this.error,
    );
  }
}
