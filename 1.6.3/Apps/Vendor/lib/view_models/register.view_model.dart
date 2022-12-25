import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/requests/vendor_type.request.dart';
import 'package:fuodz/services/alert.service.dart';
import 'package:fuodz/traits/qrcode_scanner.trait.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'base.view_model.dart';

class RegisterViewModel extends MyBaseViewModel with QrcodeScannerTrait {
  //the textediting controllers
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController bEmailTEC = new TextEditingController();
  TextEditingController bPhoneTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  List<VendorType> vendorTypes = [];
  List<File> selectedDocuments = [];
  bool hidePassword = true;

  //
  AuthRequest _authRequest = AuthRequest();
  VendorTypeRequest _vendorTypeRequest = VendorTypeRequest();

  RegisterViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() {
    fetchVendorTypes();
  }

  fetchVendorTypes() async {
    setBusyForObject(vendorTypes, true);
    try {
      vendorTypes = await _vendorTypeRequest.index();
      vendorTypes = vendorTypes
          .where(
            (e) => !e.slug.toLowerCase().contains("taxi"),
          )
          .toList();
    } catch (error) {
      toastError("$error");
    }
    setBusyForObject(vendorTypes, false);
  }

  void onDocumentsSelected(List<File> documents) {
    selectedDocuments = documents;
    notifyListeners();
  }

  void processLogin() async {
    // Validate returns true if the form is valid, otherwise false.
    if (formBuilderKey.currentState.saveAndValidate()) {
      //

      setBusy(true);

      try {
        final apiResponse = await _authRequest.registerRequest(
          vals: formBuilderKey.currentState.value,
          docs: selectedDocuments,
        );

        if (apiResponse.allGood) {
          await AlertService.success(
            title: "Become a partner".tr(),
            text: "${apiResponse.message}",
          );
          //
        } else {
          toastError("${apiResponse.message}");
        }
      } catch (error) {
        toastError("$error");
      }

      setBusy(false);
    }
  }
}
