// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:dashboard_flutter/screens/allocations/add_allocation.dart';


class UserProfileData extends StatelessWidget {
  final bool isShow;
  final String name;
  final String points;
  final String cId;
  final String phone;
  final String alternateNumber;
  final String address;
  const UserProfileData({
    Key? key,
    required this.isShow,
    required this.name,
    required this.points,
    required this.cId,
    required this.phone,
    required this.alternateNumber,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isShow
            ? UserInfoItem(label: 'Total Available Points', value: '$points')
            : SizedBox(),
        UserInfoItem(label: 'Your ID', value: '${cId == null ? "NA" : cId}'),
        UserInfoItem(
            label: 'Your Name', value: '${name == null ? "NA" : name}'),
        UserInfoItem(
            label: 'Your Number', value: '${phone == null ? "NA" : phone}'),
        UserInfoItem(
            label: 'Alternative Number',
            value: '${alternateNumber == null ? "NA" : alternateNumber}'),
        UserInfoItem(
            label: 'Full Address',
            value: '${address == null ? "NA" : address}'),
      ],
    );
  }
}
