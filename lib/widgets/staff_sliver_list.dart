import 'package:acstaffstatus/providers/staff_data_provider.dart';
import 'package:acstaffstatus/providers/status_data_provider.dart';
import 'package:acstaffstatus/providers/user_data_provider.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffSliverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDataConnection = Provider.of<UserDataProvider>(context);
    final staff = Provider.of<StaffDataProvider>(context).staff;

    Widget _showStaffEditIcon(id) {
      if (userDataConnection.user.permissionCode == "1" || userDataConnection.user.permissionCode == "2") {
        return IconButton(
          icon: Icon(
            Icons.edit,
            color: kAppBlueColour,
          ),
          onPressed: () {
            Provider.of<StaffDataProvider>(context, listen: false).setStaffId(id);
            Provider.of<StatusDataProvider>(context, listen: false).getStatusBottomSheet(context, 'staff');
          },
        );
      } else {
        return Container();
      }
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0075),
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(12.0),
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  staff[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.015,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  staff[index].jobTitle,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.02,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  staff[index].status,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: kAppRedColour,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                            ),
                            _showStaffEditIcon(staff[index].id),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        childCount: staff.length,
      ),
    );
  }
}
