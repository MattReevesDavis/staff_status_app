import 'package:acstaffstatus/providers/core_data_provider.dart';
import 'package:acstaffstatus/providers/user_data_provider.dart';
import 'package:acstaffstatus/screens/login_screen.dart';
import 'package:acstaffstatus/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;

  ///Text Input Controllers
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
    });
  }

  ///Form validation
  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Invalid Email Address';
    } else {
      return null;
    }
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

  String _validateConfirmPassword(String value) {
    if (value == '') {
      return 'Please Enter Password';
    } else if (value != _passwordController.text) {
      return 'Passwords Do Not Match';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    //dispose focus nodes
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    //dispose controllers
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coreData = Provider.of<CoreDataProvider>(context, listen: false);
    final userData = Provider.of<UserDataProvider>(context, listen: false);

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

    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/ac_logo_light.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
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
                  Icons.email,
                ),
              ),
              style: TextStyle(
                fontSize: _getFontSize(),
                fontFamily: 'Montserrat',
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: _validateEmail,
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
              focusNode: _passwordFocusNode,
              obscureText: _isHiddenPassword,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
              },
              validator: _validatePassword,
            ),
            SizedBox(height: size.height * 0.015),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
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
                  icon: _isHiddenConfirmPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
              ),
              style: TextStyle(
                fontSize: _getFontSize(),
                fontFamily: 'Montserrat',
              ),
              focusNode: _confirmPasswordFocusNode,
              obscureText: _isHiddenConfirmPassword,
              validator: _validateConfirmPassword,
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
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    ///register user
                    var registration = await userData.registerUser(_emailController.text, _passwordController.text, coreData.deviceNumber);

                    if (registration.toString() == 'fail') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Registration Error',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                            content: Text(
                              'An error occurred during registration. Please try again.',
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
                    } else if (registration.toString() == 'success') {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Registration Successful',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                            content: Text(
                              'Registration complete. Please login.',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(size.height * 0.01),
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                    ),
                                  ),
                                ),
                                color: kAppGreenColour,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Device Added',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.03,
                              ),
                            ),
                            content: Text(
                              'Account exists. Device added.',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: size.height * 0.02,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(size.height * 0.01),
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                    ),
                                  ),
                                ),
                                color: kAppBlueColour,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
