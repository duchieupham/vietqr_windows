import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/features/qr/views/qr_generator_view.dart';
import 'package:vietqr_windows/features/transaction/views/transaction_noti_view.dart';
import 'package:vietqr_windows/main.dart';
import 'package:vietqr_windows/models/qr_generator_dto.dart';
import 'package:vietqr_windows/models/transaction_receive_dto.dart';
import 'package:vietqr_windows/services/providers/notification_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';

class WebSocketManager {
  final WebSocketChannel channel;
  bool isConnected = false;

  WebSocketManager(String url, BuildContext context)
      : channel = WebSocketChannel.connect(Uri.parse(url)) {
    print('first connect wss, before on notification show');
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    // Lắng nghe sự kiện từ stream
    channel.stream.listen(
      (message) {
        // Xử lý message
        print('Message received: $message');
        var data = jsonDecode(message);
        if (data['notificationType'] != null) {
          if (data['notificationType'] == 'N05') {
            TransactionReceiveDTO transactionReceiveDTO =
                TransactionReceiveDTO.fromJson(data);
            notificationProvider.setTransaction(transactionReceiveDTO);
            notificationProvider.setNotificationType(2);
            notificationProvider.setStatus(2);
          } else if (data['notificationType'] == 'N04') {
            QRGeneratorDTO qrGeneratorDTO = QRGeneratorDTO.fromJson(data);
            notificationProvider.setQR(qrGeneratorDTO);
            notificationProvider.setNotificationType(1);
            notificationProvider.setStatus(1);
          }
        }
      },
      onDone: () {
        isConnected = false; // Đã ngắt kết nối
        print('WebSocket connection closed.');
      },
      onError: (error) {
        isConnected = false; // Đã có lỗi
        print('WebSocket error: $error');
      },
    );
    isConnected = true; // Kết nối thành công
    print('WebSocket connected.');
  }

  // void sendMessage(String message) {
  //   if (isConnected) {
  //     channel.sink.add(message);
  //     print('Message sent: $message');
  //   } else {
  //     print('Cannot send message. WebSocket is not connected.');
  //   }
  // }

  void disconnect() {
    channel.sink.close();
  }

  bool checkConnection() {
    return isConnected;
  }
}
