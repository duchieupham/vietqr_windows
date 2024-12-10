class TransactionReceiveDTO {
  final String transactionId;
  final String amount;
  final String bankAccount;
  final String content;
  final int time;
  final int timePaid;
  final int status;
  final int type;
  final String transType;
  final String terminalCode;
  //for using transaction notification
  final String rawTerminalCode;
  //
  final String note;
  final String referenceNumber;
  final String orderId;
  final String bankCode;
  final String bankShortName;
  final String subCode;

  const TransactionReceiveDTO({
    required this.transactionId,
    required this.amount,
    required this.bankAccount,
    required this.content,
    required this.time,
    required this.timePaid,
    required this.status,
    required this.type,
    required this.transType,
    required this.terminalCode,
    required this.rawTerminalCode,
    required this.note,
    required this.referenceNumber,
    required this.orderId,
    required this.bankCode,
    required this.bankShortName,
    required this.subCode,
  });

  factory TransactionReceiveDTO.fromJson(Map<String, dynamic> json) {
    return TransactionReceiveDTO(
      transactionId: json['transactionId'] ?? '',
      amount: json['amount'] ?? '',
      bankAccount: json['bankAccount'] ?? '',
      content: json['content'] ?? '',
      time: (json['time'] is int)
          ? json['time'] as int
          : int.tryParse(json['time']?.toString() ?? '') ?? 0,
      timePaid: (json['timePaid'] is int)
          ? json['timePaid'] as int
          : int.tryParse(json['timePaid']?.toString() ?? '') ?? 0,
      status: (json['status'] is int)
          ? json['status'] as int
          : int.tryParse(json['status']?.toString() ?? '') ?? 0,
      type: (json['type'] is int)
          ? json['type'] as int
          : int.tryParse(json['type']?.toString() ?? '') ?? 0,
      transType: json['transType'] ?? '',
      terminalCode: json['terminalCode'] ?? '',
      rawTerminalCode: json['rawTerminalCode'] ?? '',
      note: json['note'] ?? '',
      referenceNumber: json['referenceNumber'] ?? '',
      orderId: json['orderId'] ?? '',
      bankCode: json['bankCode'] ?? '',
      bankShortName: json['bankShortName'] ?? '',
      subCode: json['subCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['transactionId'] = transactionId;
    data['amount'] = amount;
    data['bankAccount'] = bankAccount;
    data['content'] = content;
    data['time'] = time;
    data['timePaid'] = timePaid;
    data['status'] = status;
    data['type'] = type;
    data['transType'] = transType;
    data['terminalCode'] = terminalCode;
    data['rawTerminalCode'] = rawTerminalCode;
    data['note'] = note;
    data['referenceNumber'] = referenceNumber;
    data['orderId'] = orderId;
    data['bankCode'] = bankCode;
    data['bankShortName'] = bankShortName;
    data['subCode'] = subCode;
    return data;
  }
}
