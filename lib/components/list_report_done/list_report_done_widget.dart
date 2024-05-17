import 'package:flutter/material.dart';
import '../../suco.dart';
import 'package:intl/intl.dart';

class ListReportDoneWidget extends StatelessWidget {
  final SuCo suCo;

  ListReportDoneWidget({required this.suCo});

  @override
  Widget build(BuildContext context) {
    String formatDateTime(int timestamp) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      var formattedDate = DateFormat('HH:mm MM/dd/yyyy').format(date);
      return formattedDate;
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Sự cố: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(suCo.loaiSuCo),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                "Vị Trí: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(suCo.vitriP),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                "Tình Trạng: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(suCo.trangThai),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                "Ngày tạo: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(formatDateTime(suCo.ngayBatDau)),
            ],
          ),
        ],
      ),
    );
  }
}
