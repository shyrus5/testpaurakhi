// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/choosedunit.dart';
import 'package:paurakhi/src/core/API/SellScreenAPI/sell_product_api.dart';
import 'package:paurakhi/src/core/dialogs/auth/alldialogs.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/addmultipleimage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'addtag.dart';
import 'domain/dropdown.dart';
import 'domain/tag.dart';
import 'model/product_model.dart';

void addProduct(BuildContext context) {
  GlobalKey<FormState> formKeyAddProduct = GlobalKey<FormState>();
  final productDescriptionFocus = FocusNode();
  final productDescriptionFocus1 = FocusNode();
  final productDescriptionFocus2 = FocusNode();
  final productDescriptionFocus3 = FocusNode();

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productMinQtyController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  List<File> images;
// modal bottom sheet go up with the keyboard appears
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    backgroundColor: const Color(0xFFF4FBF3),
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          UserDialogs.productExit(context);
          return false;
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
                child: Form(
                  key: formKeyAddProduct,
                  child: Container(
                      color: const Color(0xFFF4FBF3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .sell_product,
                                        style: AppStyles.text20PxBold),
                                    Flexible(
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.close)))
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    FutureBuilder<
                                        List<DropdownMenuItem<String>>>(
                                      future: DropdownList
                                          .returnDropdownforAdding(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<DropdownMenuItem<String>>?
                                              menuItems = snapshot.data;
                                          return DropdownList.dropdownButton(
                                              context, menuItems ?? []);
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                        height: 55,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: IconButton(
                                            icon:
                                                const Icon(Icons.image_rounded),
                                            onPressed: () async {
                                              try {
                                                int length = 0;
                                                images =
                                                    (await MultipleImageChooser
                                                        .pickImages(length));
                                              } catch (e) {
                                                debugPrint("$e");
                                              }
                                            },
                                            color: const Color(0xFF34A853)))
                                  ],
                                ),
                                const SizedBox(height: 5),
                                projectTitle(context, productTitleController,
                                    productDescriptionFocus1),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    productPrice(
                                        context,
                                        productPriceController,
                                        productDescriptionFocus2),
                                    const SizedBox(width: 5),
                                    minQty(context, productMinQtyController,
                                        productDescriptionFocus3),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                addProductDescripttion(
                                    context,
                                    productDescriptionController,
                                    productDescriptionFocus),
                                const SizedBox(height: 10),
                                ListTile(
                                  leading: Container(
                                      height: 40,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Center(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .product,
                                              style:
                                                  AppStyles.text12PxMedium))),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  title: Text(
                                      AppLocalizations.of(context)!
                                          .type_to_add_more_tags,
                                      style: AppStyles.text14PxBold),
                                  trailing: const Icon(
                                      Icons.keyboard_arrow_right_outlined,
                                      size: 30),
                                  onTap: () async {
                                    final tags =
                                        await TagGenerator.showTagDialog(
                                            context);
                                  },
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width -
                                          50,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            if (formKeyAddProduct.currentState!
                                                .validate()) {
                                              SellProductModel model =
                                                  SellProductModel(
                                                      productTitleController
                                                          .text,
                                                      "sell",
                                                      productDescriptionController
                                                          .text,
                                                      Tag.realTag,
                                                      DropdownList
                                                          .dropDownIndex,
                                                      MultipleImageChooser
                                                          .images,
                                                      int.parse(
                                                          productMinQtyController
                                                              .text),
                                                      int.parse(
                                                          productPriceController
                                                              .text));
                                              SellProductAPI.sellProduct(
                                                  model, context);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF34A853),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)))),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .sell_product,
                                              style: AppStyles.text16Px))),
                                ),
                                const SizedBox(height: 30),
                              ]),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Padding projectTitle(BuildContext context, controller, focusNode) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        validator: (val) {
          if (!ExtString.validateFirstName(val!)) {
            return AppLocalizations.of(context)!.enter_a_valid_product_title;
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: AppLocalizations.of(context)!.product_title,
        ),
      ),
    ),
  );
}

Padding addProductDescripttion(BuildContext context, controller, focusNode) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        validator: (val) {
          if (!ExtString.validateFirstName(val!)) {
            return AppLocalizations.of(context)!.add_some_product_description;
          }
          return null;
        },
        maxLines: 5,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: AppLocalizations.of(context)!.add_product_description,
        ),
      ),
    ),
  );
}

Padding productPrice(BuildContext context, controller, focusNode) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: TextFormField(
        keyboardType: TextInputType.number,
        focusNode: focusNode,
        controller: controller,
        validator: (val) {
          if (!ExtString.validateProductPrice(val!)) {
            return AppLocalizations.of(context)!.enter_a_valid_price;
          }
          return null;
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: AppLocalizations.of(context)!.product_price),
      ),
    ),
  );
}

Padding minQty(
    BuildContext context, TextEditingController controllers, focusNode) {
  final choosedUnitController =
      Get.put(ChoosedUnitController()); // Initialize the controller and bind it

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: GetBuilder<ChoosedUnitController>(
        init: choosedUnitController, // Initialize the controller
        builder: (controller) {
          String notificationCount = controller.dropdownIndex.value;
          return TextFormField(
            keyboardType: TextInputType.number,
            controller: controllers,
            focusNode: focusNode,
            validator: (val) {
              if (!ExtString.validateMinQty(val!)) {
                return AppLocalizations.of(context)!.enter_a_vaid_quantity;
              }

              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintText: notificationCount.toString(),
            ),
          );
        },
      ),
    ),
  );
}
