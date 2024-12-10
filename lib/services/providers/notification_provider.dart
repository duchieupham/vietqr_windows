import 'package:flutter/material.dart';
import 'package:vietqr_windows/models/qr_generator_dto.dart';
import 'package:vietqr_windows/models/transaction_receive_dto.dart';

class NotificationProvider extends ChangeNotifier {
  //0: nothing
  //1: qr generator
  //2: bdsd
  int _notificationType = 0;

  //0: nothing
  //1: edge
  //2: modal bottom sheet
  // int _showingType = 0;

  //status = 0: Hide All
  //status = 1: Show QR Form
  //status = 2: Show Noti Form
  int _status = 0;

  //true: voice on
  //false: voice off
  bool _isVoiceOff = false;

  QRGeneratorDTO _qrGeneratorDTO = const QRGeneratorDTO(
    qr: '',
    amount: '',
    content: '',
    bankAccount: '',
    userBankName: '',
    imgId: '',
    transType: '',
    status: 0,
    type: 0,
  );

  TransactionReceiveDTO _transactionReceiveDTO = const TransactionReceiveDTO(
    transactionId: '',
    amount: '',
    bankAccount: '',
    content: '',
    time: 0,
    timePaid: 0,
    status: 0,
    type: 0,
    transType: '',
    terminalCode: '',
    rawTerminalCode: '',
    note: '',
    referenceNumber: '',
    orderId: '',
    bankCode: '',
    bankShortName: '',
    subCode: '',
  );

  get notificationType => _notificationType;
  get status => _status;
  get qrGeneratorDTO => _qrGeneratorDTO;
  get transactionReceiveDTO => _transactionReceiveDTO;
  get isVoiceOff => _isVoiceOff;

  void reset() {
    _notificationType = 0;
    _status = 0;
    _qrGeneratorDTO = const QRGeneratorDTO(
      qr: '',
      amount: '',
      content: '',
      bankAccount: '',
      userBankName: '',
      imgId: '',
      transType: '',
      status: 0,
      type: 0,
    );
    _transactionReceiveDTO = const TransactionReceiveDTO(
      transactionId: '',
      amount: '',
      bankAccount: '',
      content: '',
      time: 0,
      timePaid: 0,
      status: 0,
      type: 0,
      transType: '',
      terminalCode: '',
      rawTerminalCode: '',
      note: '',
      referenceNumber: '',
      orderId: '',
      bankCode: '',
      bankShortName: '',
      subCode: '',
    );
    notifyListeners();
  }

  void setVoiceOff(bool value) {
    _isVoiceOff = value;
    notifyListeners();
  }

  void setNotificationType(int value) {
    _notificationType = value;
    notifyListeners();
  }

  void setStatus(int value) {
    _status = value;
    notifyListeners();
  }

  void setQR(QRGeneratorDTO dto) {
    _qrGeneratorDTO = dto;
    notifyListeners();
  }

  void setTransaction(TransactionReceiveDTO dto) {
    _transactionReceiveDTO = dto;
    notifyListeners();
  }
}
