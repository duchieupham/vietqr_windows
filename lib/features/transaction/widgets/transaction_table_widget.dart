import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vietqr_windows/commons/configs/theme.dart';
import 'package:vietqr_windows/models/transaction_receive_dto.dart';

class TransactionTableWidget extends StatelessWidget {
  final List<TransactionReceiveDTO> dtos;
  late TransactionReceiveDataSource transactionReceiveDataSource;

  TransactionTableWidget({
    super.key,
    required this.dtos,
  });

  @override
  Widget build(BuildContext context) {
    transactionReceiveDataSource =
        TransactionReceiveDataSource(transactionData: dtos);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SfDataGrid(
        source: transactionReceiveDataSource,
        columnWidthMode: ColumnWidthMode.auto,
        highlightRowOnHover: true,
        allowSorting: true,
        isScrollbarAlwaysShown: true,
        showColumnHeaderIconOnHover: true,
        headerRowHeight: 50,
        selectionMode: SelectionMode.singleDeselect,
        headerGridLinesVisibility: GridLinesVisibility.none,
        footerFrozenColumnsCount: 1,
        onCellSecondaryTap: (value) {
          // print('value: $value');
        },
        columns: <GridColumn>[
          GridColumn(
            columnName: 'no',
            width: 35,
            allowSorting: false,
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'STT',
              ),
            ),
          ),
          GridColumn(
            columnName: 'amount',
            allowSorting: false,
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Số tiền'),
            ),
          ),
          GridColumn(
            columnName: 'timePaid',
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Thời gian TT',
              ),
            ),
          ),
          GridColumn(
            columnName: 'ftCode',
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Mã GD'),
            ),
          ),
          GridColumn(
            columnName: 'orderId',
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Đơn hàng'),
            ),
          ),
          GridColumn(
            columnName: 'terminalCode',
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Điểm bán'),
            ),
          ),
          GridColumn(
            columnName: 'subCode',
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Điểm bán phụ'),
            ),
          ),
          GridColumn(
            columnName: 'bankAccount',
            allowSorting: false,
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('TK nhận'),
            ),
          ),
          GridColumn(
            columnName: 'timeCreated',
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Thời gian tạo'),
            ),
          ),
          GridColumn(
            columnName: 'content',
            maximumWidth: 500,
            minimumWidth: 300,
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Nội dung'),
            ),
          ),
          GridColumn(
            columnName: 'note',
            maximumWidth: 500,
            minimumWidth: 300,
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text('Ghi chú'),
            ),
          ),
          GridColumn(
            columnName: 'status',
            allowSorting: false,
            width: 75,
            label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Trạng thái',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionReceiveDataSource extends DataGridSource {
  List<DataGridRow> _transactionData = [];

  TransactionReceiveDataSource(
      {required List<TransactionReceiveDTO> transactionData}) {
    _transactionData = transactionData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              const DataGridCell<int>(columnName: 'no', value: 1),
              DataGridCell<TransactionReceiveDTO>(
                  columnName: 'amount', value: e),
              DataGridCell<int>(columnName: 'timePaid', value: e.timePaid),
              DataGridCell<String>(
                columnName: 'ftCode',
                value: _getValue(e.referenceNumber),
              ),
              DataGridCell<String>(
                columnName: 'orderId',
                value: _getValue(e.orderId),
              ),
              DataGridCell<String>(
                columnName: 'terminalCode',
                value: _getValue(e.terminalCode),
              ),
              DataGridCell<String>(
                columnName: 'subCode',
                value: _getValue(e.subCode),
              ),
              DataGridCell<String>(
                columnName: 'bankAccount',
                value: _getBankAccount(e.bankAccount, e.bankShortName),
              ),
              DataGridCell<int>(columnName: 'timeCreated', value: e.time),
              DataGridCell<String>(
                columnName: 'content',
                value: _getValue(e.content),
              ),
              DataGridCell<String>(
                columnName: 'note',
                value: _getValue(e.note),
              ),
              DataGridCell<TransactionReceiveDTO>(
                columnName: 'status',
                value: e,
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  List<DataGridRow> get rows => _transactionData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return (e.columnName == 'status')
          ? _getStatusWidget(e.value.status, e.value.type, e.value.transType)
          : Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(4),
              child: Text(
                (e.columnName == 'amount')
                    ? '${_getPrefixAmount(e.value.transType)} ${e.value.amount}'
                    : e.value.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: (e.columnName == 'amount')
                      ? _getColor(
                          e.value.transType, e.value.status, e.value.type)
                      : AppColor.BLACK,
                ),
              ),
            );
    }).toList());
  }

  String _getValue(String value) {
    String result = '-';
    if (value.trim().isNotEmpty) {
      result = value;
    }
    return result;
  }

  String _getBankAccount(String bankAccount, String bankShortName) {
    return '$bankAccount\n$bankShortName';
  }

  String _getStatus(int status) {
    String result = '';
    if (status == 0) {
      result = 'Chờ TT';
    } else if (status == 1) {
      result = 'Đã TT';
    } else if (status == 2) {
      result = 'Đã hủy';
    } else {
      result = '-';
    }
    return result;
  }

  Color _getColor(String transType, int status, int type) {
    Color result = AppColor.BLACK;
    if (transType == 'C' && status == 0) {
      result = AppColor.ORANGE;
    } else if (transType == 'C' &&
        status == 1 &&
        (type == 1 || type == 4 || type == 5)) {
      result = AppColor.GREEN;
    } else if (transType == 'C' &&
        status == 1 &&
        ((type != 1 && type != 4 && type != 5))) {
      result = AppColor.BLUE;
    } else if (transType == 'D') {
      result = AppColor.RED;
    }
    return result;
  }

  Widget _getStatusWidget(int status, int type, String transType) {
    return UnconstrainedBox(
      child: Container(
        width: 45,
        padding: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: _getColor(transType, status, type).withOpacity(0.2),
        ),
        child: Text(
          _getStatus(status),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: _getColor(transType, status, type),
          ),
        ),
      ),
    );
  }

  String _getPrefixAmount(String transType) {
    String result = '';
    if (transType == 'C') {
      result = '+';
    } else if (transType == 'D') {
      result = '-';
    }
    return result;
  }
}
