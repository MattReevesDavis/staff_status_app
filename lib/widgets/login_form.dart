import 'package:acstaffstatus/providers/core_data_provider.dart';
import 'package:acstaffstatus/providers/staff_data_provider.dart';
import 'package:acstaffstatus/providers/user_data_provider.dart';
import 'package:acstaffstatus/providers/virus_data_provider.dart';
import 'package:acstaffstatus/screens/dashboard_screen.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

///get user data using the device number so that you can show the name as a welcome message

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isHiddenPassword = true;
  Future<UserData> userData;
  Future<List<StaffData>> staffData;
  Future<List<VirusData>> virusDataSouthAfrica;
  Future<VirusDataGlobal> virusDataGlobal;

  ///Text Input Controllers
  TextEditingController _passwordController = new TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  String _validatePassword(String value) {
    if (value == '') {
      return 'Please Enter Password';
    } else if (value.length < 5) {
      return 'Password Must Be 5 Characters Or More';
    } else {
      return null;
    }
  }

  Future<UserData> _getUserData(String deviceNumber) async {
    return await Provider.of<UserDataProvider>(context).getUserData(deviceNumber);
  }

  String _getDeviceNumber() {
    return Provider.of<CoreDataProvider>(context).deviceNumber;
  }

  @override
  void didChangeDependencies() {
    userData = _getUserData(_getDeviceNumber());
    staffData = Provider.of<StaffDataProvider>(context).getStaffData();
    virusDataSouthAfrica = Provider.of<VirusDataProvider>(context).getVirusDataSouthAfrica();
    virusDataGlobal = Provider.of<VirusDataProvider>(context).getVirusDataGlobal();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //dispose controllers
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userDataConnection = Provider.of<UserDataProvider>(context, listen: false);
    var coreDataConnection = Provider.of<CoreDataProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;

    double _getFontSize() {
      double fontSize;

      if (size.width > 600) {
        //tablet
        fontSize = size.width * 0.035;
      } else if (size.width < 600 && size.width > 400) {
        //large phone
        fontSize = size.width * 0.04;
      } else {
        //small phone
        fontSize = size.width * 0.05;
      }

      return fontSize;
    }

    return FutureBuilder<UserData>(
      future: userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    coreDataConnection.themeIndicator == 'L' ? 'assets/images/ac_logo_light.png' : 'assets/images/ac_logo_dark.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    width: size.width * 0.5,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Welcome, ' + userDataConnection.userFirstName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: _getFontSize(),
                        fontWeight: FontWeight.w500,
                        color: kAppGreenColour,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: kAppGreenColour,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: kAppGreenColour,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: kAppRedColour,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: kAppRedColour,
                          width: 2,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: _isHiddenPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: _getFontSize(),
                      fontFamily: 'Montserrat',
                    ),
                    textInputAction: TextInputAction.next,
                    obscureText: _isHiddenPassword,
                    validator: _validatePassword,
                  ),
                  SizedBox(height: size.height * 0.015),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    width: double.infinity,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: kAppGreenColour,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.035,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          ///TODO: - write the login method in the user data provider class
                          ///authenticate user
                          var authenticate = await userDataConnection.authenticateUser(coreDataConnection.deviceNumber, _passwordController.text);

                          if (authenticate == 'fail') {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Authentication Error',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.height * 0.03,
                                    ),
                                  ),
                                  content: Text(
                                    'An error occurred during authentication. Please try again.',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.height * 0.02,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(size.height * 0.01),
                                        child: Text(
                                          'Dismiss',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: size.height * 0.02,
                                          ),
                                        ),
                                      ),
                                      color: kAppRedColour,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print("HELLO");
          return Center(
            child: Text(
              "${snapshot.error}",
            ),
          );
        }
        return Container(
          height: size.height,
          color: coreDataConnection.themeIndicator == 'L' ? Colors.white : kAppDarkColour,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: kAppGreenColour,
              valueColor: coreDataConnection.themeIndicator == 'L'
                  ? AlwaysStoppedAnimation<Color>(Colors.white)
                  : AlwaysStoppedAnimation<Color>(kAppDarkColour),
            ),
          ),
        );
      },
    );
  }
}
