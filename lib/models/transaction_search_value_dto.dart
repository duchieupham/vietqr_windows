class TransactionSearchValueDTO {
  final String bankId;
  final int type;
  final int offset;
  final String value;
  final String fromDate;
  final String toDate;

  const TransactionSearchValueDTO({
    required this.bankId,
    required this.type,
    required this.offset,
    required this.value,
    required this.fromDate,
    required this.toDate,
  });
}
