import 'dart:async';

import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../Bloc/login/login_bloc.dart';
import '../../Bloc/login/login_event.dart';
import '../../Bloc/login/login_state.dart';
import '../../Config/font.dart';
import '../../Constant/theme_colors.dart';
import '../../Model/district_model.dart';
import '../../Model/state_model.dart';
import '../../NetworkFunction/fetchDistrict.dart';
import '../../NetworkFunction/fetchState.dart';
import '../../Widget/app_button.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final String? dropValue;
  const RegistrationScreen({Key? key, required this.dropValue})
      : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _createPasswordController =
      TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdownValueModule = 'Machine Maintenance';
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  String _value = "1";
  LoginBloc? _userLoginBloc;
  bool isconnectedToInternet = false;
  String dropValue = 'Citizens';
  String? selectedValue;
  List<StateModel> addStateNameList = [];
  List<DistrictModel> addDistrictNameList = [];
  StateModel? selectStateName;
  DistrictModel? selectDistrictName;
  final List<String> items = [
    'Citizens',
    'Students',
    'Corporates',
    'Institutions',
    'Sponsors',
    'Government Officers'
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userLoginBloc = BlocProvider.of<LoginBloc>(context);
    // loading;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.clear();
    _emailIdController.clear();
    _phoneNumberController.clear();
    _createPasswordController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff062C56),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.10,
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Image.asset('assets/images/profile-icon.png')),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Create Password',
                              style: ksubjectHeadingStyle,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              'You have to enter email and phone',
                              softWrap: true,
                              style: registersubheadingStyle,
                            ),
                            Text(
                              ' number to register.',
                              softWrap: true,
                              style: registersubheadingStyle,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width:
                              MediaQuery.of(context).size.width * 0.9,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(8.0)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text('Select Item'),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 200,
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(color: Colors.black26),
                                      color: Colors.white,
                                    ),
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    ),
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _fullNameController,

                                keyboardType: TextInputType.text,
                                //maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Full Name',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _emailIdController,
                                keyboardType: TextInputType.text,
                                // maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Email id',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: '+91 **********',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _createPasswordController,
                                keyboardType: TextInputType.text,
                                // maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Create Password',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _reEnterPasswordController,
                                keyboardType: TextInputType.text,
                                //  maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter confirm password';
                                  } else if (_createPasswordController.text !=
                                      value) {
                                    return 'Confirm password did not match with create password';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            // For State Name Selected
                            Padding(
                                padding: EdgeInsets.only(top:0,bottom: 10,right: 35,left: 35),
                                //to hide underline
                                child: FutureBuilder<List<StateModel>>(
                                    future:fetchState(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<StateModel>> snapshot) {
                                      if (!snapshot.hasData) return Container();

                                      return DropdownButtonHideUnderline(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              // color: Theme.of(context).dividerColor,
                                                color: Color(0xffF5F5F5),
                                                borderRadius: BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: ThemeColors.textFieldBgColor)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                                              child:
                                              //updated on 15/06/2021 to change background colour of dropdownbutton
                                               Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(canvasColor: Colors.white),
                                                  child: DropdownButton(
                                                      items: snapshot.data!
                                                          .map((statename) =>
                                                          DropdownMenuItem<StateModel>(
                                                            value: statename,
                                                            child: Text(
                                                              statename.stateName.toString(),
                                                              style: TextStyle(
                                                                  color: Colors.black),
                                                            ),
                                                          ))
                                                          .toList(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                      isExpanded: true,
                                                      hint: Text('Select State Name',
                                                          style: TextStyle(
                                                              color: Color(0xFF3F4141))),
                                                      value: selectStateName == null
                                                          ? selectStateName
                                                          : snapshot.data!
                                                          .where((i) =>
                                                      i.stateName ==
                                                          selectStateName!.stateName)
                                                          .first,
                                                      onChanged: (StateModel? stateName) {
                                                        setState(() {
                                                          selectStateName = stateName;
                                                        });
                                                      })),
                                            ),
                                          ));
                                    })),
                            // For District Name Selected
                            Padding(
                                padding: EdgeInsets.only(top:0,bottom: 10,right: 35,left: 35),
                                //to hide underline
                                child: FutureBuilder<List<DistrictModel>>(
                                    future:fetchDistrict(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<DistrictModel>> snapshot) {
                                      if (!snapshot.hasData) return Container();

                                      return DropdownButtonHideUnderline(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              // color: Theme.of(context).dividerColor,
                                                color: Color(0xffF5F5F5),
                                                borderRadius: BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: ThemeColors.textFieldBgColor)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                                              child:
                                              //updated on 15/06/2021 to change background colour of dropdownbutton
                                              Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(canvasColor: Colors.white),
                                                  child: DropdownButton(
                                                      items: snapshot.data!
                                                          .map((distname) =>
                                                          DropdownMenuItem<DistrictModel>(
                                                            value: distname,
                                                            child: Text(
                                                              distname.districtName.toString(),
                                                              style: TextStyle(
                                                                  color: Colors.black),
                                                            ),
                                                          ))
                                                          .toList(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),
                                                      isExpanded: true,
                                                      hint: Text('Select District Name',
                                                          style: TextStyle(
                                                              color: Color(0xFF3F4141))),
                                                      value: selectDistrictName == null
                                                          ? selectDistrictName
                                                          : snapshot.data!
                                                          .where((i) =>
                                                      i.districtName ==
                                                          selectDistrictName!.districtName)
                                                          .first,
                                                      onChanged: (DistrictModel? districtname) {
                                                        setState(() {
                                                          selectDistrictName = districtname;
                                                        });
                                                      })),
                                            ),
                                          ));
                                    })),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _remarkController,
                                keyboardType: TextInputType.text,
                                // maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Remark',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ),
                            // Padding(
                            //     padding: const EdgeInsets.all(10.0),
                            //     child: AppButton(
                            //       loading: loading,
                            //       onPressed: () async {
                            //
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => LoginScreen(
                            //                   dropValue:
                            //                   dropdownValueModule,
                            //                 )));
                            //
                            //         // if (dropdownValueModule ==
                            //         //     "Machine Maintenance") {
                            //         //   _value = '1';
                            //         // } else if (dropdownValueModule ==
                            //         //     "Job Work Enquiry") {
                            //         //   _value = '2';
                            //         // } else if (dropdownValueModule ==
                            //         //     "Transportation") {
                            //         //   _value = '3';
                            //         // }
                            //         // isconnectedToInternet =
                            //         //     await ConnectivityCheck
                            //         //         .checkInternetConnectivity();
                            //         // if (isconnectedToInternet == true) {
                            //         //   if (_fullNameController == null) {
                            //         //     Fluttertoast.showToast(
                            //         //         msg: "Please enter full name");
                            //         //   } else if (_phoneNumberController
                            //         //           .text ==
                            //         //       "") {
                            //         //     Fluttertoast.showToast(
                            //         //         msg:
                            //         //             "Please enter mobile number");
                            //         //   } else if ( _fullNameController.text ==
                            //         //       "" || !RegExp(r'^[a-z A-Z]+$').hasMatch(_fullNameController.text)) {
                            //         //     Fluttertoast.showToast(
                            //         //         msg: "Please enter Correct Name");
                            //         //   } else if (_userNameController.text ==
                            //         //       "") {
                            //         //     Fluttertoast.showToast(
                            //         //         msg: "Please enter Username");
                            //         //   }else if (_createPasswordController.text ==
                            //         //       "") {
                            //         //     Fluttertoast.showToast(
                            //         //         msg: "Please create password");
                            //         //   }
                            //         //   else if (_reEnterPasswordController.text ==
                            //         //       "") {
                            //         //     Fluttertoast.showToast(
                            //         //         msg: "Please re-enter password");
                            //         //   }
                            //         //   else if (_emailIdController.text ==
                            //         //       "") {
                            //         //     Fluttertoast.showToast(
                            //         //         msg: "Please enter email");
                            //         //   } else if (_formKey.currentState!
                            //         //       .validate()) {
                            //         //     _userLoginBloc!.add(OnRegistration(
                            //         //       fullname:
                            //         //           _fullNameController.text,
                            //         //       username:
                            //         //           _userNameController.text,
                            //         //       createPassword:
                            //         //           _createPasswordController
                            //         //               .text,
                            //         //       reCreatePassword:
                            //         //           _reEnterPasswordController
                            //         //               .text,
                            //         //       // role: dropdownValueModule,
                            //         //       role: _value,
                            //         //       // role: 'Job Work Enquiry',
                            //         //       email: _emailIdController.text,
                            //         //       mobileNo:
                            //         //           _phoneNumberController.text,
                            //         //     ));
                            //         //   }
                            //         // } else {
                            //         //   CustomDialogs.showDialogCustom(
                            //         //       "Internet",
                            //         //       "Please check your Internet Connection!",
                            //         //       context);
                            //         // }
                            //       },
                            //       text: 'Register',
                            //       color: ThemeColors.buttonColor,
                            //     ))
                            BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, signup) {
                                  return BlocListener<LoginBloc, LoginState>(
                                    listener: (context, state) {
                                      if (state is CustomerRegistrationSuccess) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LoginScreen(
                                                  dropValue:
                                                  dropdownValueModule,
                                                )));
                                        Fluttertoast.showToast(msg: state.msg);
                                        loading = false;
                                      }

                                      if (state is CustomerRegistrationFail) {
                                        Fluttertoast.showToast(msg: state.msg);
                                      }
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: AppButton(
                                          loading: loading,
                                          onPressed: () async {
                                            if (_fullNameController.text == "") {
                                                Fluttertoast.showToast(
                                                    msg: "Please enter full name");
                                              } else if (_phoneNumberController
                                                  .text ==
                                                  "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    "Please enter mobile number");
                                              }  else if (_createPasswordController.text ==
                                                  "") {
                                                Fluttertoast.showToast(
                                                    msg: "Please create password");
                                              }

                                              else if (_emailIdController.text ==
                                                  "") {
                                                Fluttertoast.showToast(
                                                    msg: "Please enter email");
                                              } else if (_formKey.currentState!
                                                  .validate()) {
                                                _userLoginBloc!.add(OnRegistration(
                                                  fullname:
                                                  _fullNameController.text,
                                                  remark:
                                                  _remarkController.text,
                                                  createPassword:
                                                  _createPasswordController
                                                      .text,

                                                  // role: dropdownValueModule,
                                                  role: _value,
                                                  // role: 'Job Work Enquiry',
                                                  email: _emailIdController.text,
                                                  mobileNo:
                                                  _phoneNumberController.text,
                                                ));
                                              }
                                            },
                                          text: 'Register',
                                          color: ThemeColors.buttonColor,
                                        )),
                                  );
                                }),
                          ],
                        ),
                        // SizedBox(height: 7),
                        // TextButton(
                        //     child: const Text(
                        //       'Forget Password?',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           letterSpacing: 1,
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: 14),
                        //     ),
                        //     onPressed: () {
                        //       // Navigator.push(
                        //       //         context,
                        //       //         MaterialPageRoute(
                        //       //             builder: (context) =>
                        //       //             RegistrationScreen()
                        //       //                 // WebViewContainer(
                        //       //                 // "https://rccedu.org/register.php")
                        //       //         ))
                        //       //     .whenComplete(() => Navigator.pop(context));
                        //       // print('Pressed');
                        //     }),
                        //
                        // TextButton(
                        //     child: const Text(
                        //       'Do not have any account? Create Account',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           letterSpacing: 1,
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: 14),
                        //     ),
                        //     onPressed: () {
                        //
                        //     })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
