import 'package:vietqr_windows/models/bank_account_dto.dart';
import 'package:vietqr_windows/models/transaction_receive_dto.dart';

class HomeDataDTO {
  final List<BankAccountDTO> banks;
  final List<TransactionReceiveDTO> transactions;

  const HomeDataDTO({
    required this.banks,
    required this.transactions,
  });
}
