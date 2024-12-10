class QRGeneratorDTO {
  final String qr;
  final String amount;
  final String content;
  final String bankAccount;
  final String userBankName;
  final String imgId;
  final String transType;
  final int type;
  final int status;

  const QRGeneratorDTO({
    required this.qr,
    required this.amount,
    required this.content,
    required this.bankAccount,
    required this.userBankName,
    required this.imgId,
    required this.transType,
    required this.status,
    required this.type,
  });

  factory QRGeneratorDTO.fromJson(Map<String, dynamic> json) {
    return QRGeneratorDTO(
      qr: json['qr'] ?? json['qrCode'] ?? '',
      amount: json['amount'] ?? '',
      content: json['content'] ?? '',
      bankAccount: json['bankAccount'] ?? '',
      userBankName: json['userBankName'] ?? '',
      imgId: json['imgId'] ?? '',
      transType: json['transType'] ?? 'C',
      status: (json['status'] is int)
          ? json['status'] as int
          : int.tryParse(json['status']?.toString() ?? '') ?? 0,
      type: json['type'] ?? 0,
    );
  }
}
