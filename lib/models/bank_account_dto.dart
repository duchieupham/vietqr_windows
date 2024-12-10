class BankAccountDTO {
  final String id;
  final String bankAccount;
  final String userBankName;
  final String bankShortName;
  final String bankCode;
  final String bankName;
  final String imgId;
  final int type;
  final String bankTypeId;
  final String nationalId;
  final String phoneAuthenticated;
  final String userId;
  final bool isOwner;
  final int bankTypeStatus;
  final String qrCode;
  final String caiValue;
  final String ewalletToken;
  final int unlinkedType;
  final bool isValidService;
  final int validFeeFrom;
  final int validFeeTo;
  final int transCount;
  final bool mmsActive;
  final int pushNotification;
  final bool enableVoice;
  final String keyActive;
  final int timeActiveKey;
  final bool emailVerified;
  final bool activeKey;
  final bool authenticated;

  const BankAccountDTO(
      {required this.id,
      required this.bankAccount,
      required this.userBankName,
      required this.bankShortName,
      required this.bankCode,
      required this.bankName,
      required this.imgId,
      required this.type,
      required this.bankTypeId,
      required this.nationalId,
      required this.phoneAuthenticated,
      required this.userId,
      required this.isOwner,
      required this.bankTypeStatus,
      required this.qrCode,
      required this.caiValue,
      required this.ewalletToken,
      required this.unlinkedType,
      required this.isValidService,
      required this.validFeeFrom,
      required this.validFeeTo,
      required this.transCount,
      required this.mmsActive,
      required this.pushNotification,
      required this.enableVoice,
      required this.keyActive,
      required this.timeActiveKey,
      required this.emailVerified,
      required this.activeKey,
      required this.authenticated});

  factory BankAccountDTO.fromJson(Map<String, dynamic> json) {
    return BankAccountDTO(
      id: json['id'] ?? '',
      bankAccount: json['bankAccount'] ?? '',
      userBankName: json['userBankName'] ?? '',
      bankShortName: json['bankShortName'] ?? '',
      bankCode: json['bankCode'] ?? '',
      bankName: json['bankName'] ?? '',
      imgId: json['imgId'] ?? '',
      type: json['type'] ?? 0,
      bankTypeId: json['bankTypeId'] ?? '',
      nationalId: json['nationalId'] ?? '',
      phoneAuthenticated: json['phoneAuthenticated'] ?? '',
      userId: json['userId'] ?? '',
      isOwner: json['isOwner'] ?? false,
      bankTypeStatus: json['bankTypeStatus'] ?? 0,
      qrCode: json['qrCode'] ?? '',
      caiValue: json['caiValue'] ?? '',
      ewalletToken: json['ewalletToken'] ?? '',
      unlinkedType: json['unlinkedType'] ?? 0,
      isValidService: json['isValidService'] ?? false,
      validFeeFrom: json['validFeeFrom'] ?? 0,
      validFeeTo: json['validFeeTo'] ?? 0,
      transCount: json['transCount'] ?? 0,
      mmsActive: json['mmsActive'] ?? false,
      pushNotification: json['pushNotification'] ?? 0,
      enableVoice: json['enableVoice'] ?? false,
      keyActive: json['keyActive'] ?? '',
      timeActiveKey: json['timeActiveKey'] ?? 0,
      emailVerified: json['emailVerified'] ?? false,
      activeKey: json['activeKey'] ?? false,
      authenticated: json['authenticated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['bankAccount'] = bankAccount;
    data['userBankName'] = userBankName;
    data['bankShortName'] = bankShortName;
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
    data['imgId'] = imgId;
    data['type'] = type;
    data['bankTypeId'] = bankTypeId;
    data['nationalId'] = nationalId;
    data['phoneAuthenticated'] = phoneAuthenticated;
    data['userId'] = userId;
    data['isOwner'] = isOwner;
    data['bankTypeStatus'] = bankTypeStatus;
    data['qrCode'] = qrCode;
    data['caiValue'] = caiValue;
    data['ewalletToken'] = ewalletToken;
    data['unlinkedType'] = unlinkedType;
    data['isValidService'] = isValidService;
    data['validFeeFrom'] = validFeeFrom;
    data['validFeeTo'] = validFeeTo;
    data['transCount'] = transCount;
    data['mmsActive'] = mmsActive;
    data['pushNotification'] = pushNotification;
    data['enableVoice'] = enableVoice;
    data['keyActive'] = keyActive;
    data['timeActiveKey'] = timeActiveKey;
    data['emailVerified'] = emailVerified;
    data['activeKey'] = activeKey;
    data['authenticated'] = authenticated;
    return data;
  }
}
