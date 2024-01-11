import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:salespro_saas_admin/Provider/seller_info_provider.dart';
import 'package:salespro_saas_admin/Screen/Widgets/Pop%20Up/Shop%20Management/view_shop.dart';
import 'package:salespro_saas_admin/model/seller_info_model.dart';

import '../Widgets/Constant Data/constant.dart';
import '../Widgets/Constant Data/export_button.dart';
import '../Widgets/Pop Up/Shop Management/edit_shop.dart';
import '../Widgets/Sidebar/sidebar_widget.dart';
import '../Widgets/Topbar/topbar.dart';
import 'dart:html';

import 'dart:ui' as ui;

class ShopManagement extends StatefulWidget {
  const ShopManagement({Key? key}) : super(key: key);

  static const String route = '/shopManagement';

  @override
  State<ShopManagement> createState() => _ShopManagementState();
}

class _ShopManagementState extends State<ShopManagement> {
  //View Shop PopUp
  void showViewShopPopUp(SellerInfoModel info) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ViewShop(
            infoModel: info,
          ),
        );
      },
    );
  }

  //Edit Shop PopUp
  void showEditShopPopUp(SellerInfoModel shopInfo) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: EditShop(shopInformation: shopInfo),
        );
      },
    );
  }

  Future<void> deleteUser(
      {required WidgetRef updateRef, required String email}) async {
    // void showdeleteShopPopUp(email) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      "Delete User",
                      style: kTextStyle.copyWith(
                          color: kTitleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel))
                  ],
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    "Are you Sure want to delete user",
                    style: kTextStyle.copyWith(color: kTitleColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "No",
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          EasyLoading.show(status: 'Deleting..');
                          String key = '';
                          await FirebaseDatabase.instance
                              .ref()
                              .child('Admin Panel')
                              .child('Seller List')
                              .orderByKey()
                              .get()
                              .then((value) async {
                            for (var element in value.children) {
                              var data = jsonDecode(jsonEncode(element.value));
                              if (data['email'].toString() == email) {
                                key = element.key.toString();
                              }
                            }
                          });
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref("Admin Panel/Seller List/$key");
                          await ref.remove();
                          updateRef.refresh(sellerInfoProvider);
                          EasyLoading.showSuccess('Done');

                          Navigator.pop(context);
                        },
                        child: Text(
                          "Yes",
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      body: Consumer(
        builder: (_, ref, watch) {
          final sellerInfo = ref.watch(sellerInfoProvider);
          return sellerInfo.when(data: (sellerInfo) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 240,
                  child: SideBarWidget(
                    index: 1,
                    isTab: false,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kWhiteTextColor,
                          ),
                          child: const TopBar(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: kWhiteTextColor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'SHOP LIST',
                                      style: kTextStyle.copyWith(
                                          color: kTitleColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const ExportButton().visible(false)
                                  ],
                                ),
                                // const SizedBox(height: 10.0),
                                // SizedBox(
                                //   height: 40,
                                //   width: MediaQuery.of(context).size.width * .25,
                                //   child: TextField(
                                //     showCursor: true,
                                //     cursorColor: kTitleColor,
                                //     decoration: kInputDecoration.copyWith(
                                //       hintText: 'Search Anything...',
                                //       suffixIcon: Padding(
                                //         padding: const EdgeInsets.all(4.0),
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             borderRadius: BorderRadius.circular(8.0),
                                //             color: kBlueTextColor,
                                //           ),
                                //           child: const Icon(FeatherIcons.search, color: kWhiteTextColor),
                                //         ),
                                //       ),
                                //       hintStyle: kTextStyle.copyWith(color: kLitGreyColor),
                                //       contentPadding: const EdgeInsets.all(4.0),
                                //       enabledBorder: const OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(
                                //           Radius.circular(8.0),
                                //         ),
                                //         borderSide: BorderSide(color: kBorderColorTextField, width: 1),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(height: 10.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: DataTable(
                                    border: TableBorder.all(
                                      color: kBorderColorTextField,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    dividerThickness: 1.0,
                                    headingRowColor:
                                        MaterialStateProperty.all(kDarkWhite),
                                    showBottomBorder: true,
                                    headingTextStyle: kTextStyle.copyWith(
                                        color: kTitleColor, fontSize: 14.0),
                                    dataTextStyle: kTextStyle.copyWith(
                                        color: kGreyTextColor, fontSize: 12.0),
                                    horizontalMargin: 20.0,
                                    columnSpacing: 20.0,
                                    columns: const [
                                      DataColumn(
                                        label: Text('S.L'),
                                      ),
                                      DataColumn(
                                        label: Text('LOGO'),
                                      ),
                                      DataColumn(
                                        label: Text('SHOP NAME'),
                                      ),
                                      DataColumn(
                                        label: Text('CATEGORY'),
                                      ),
                                      DataColumn(
                                        label: Text('PHONE'),
                                      ),
                                      DataColumn(
                                        label: Text('EMAIL'),
                                      ),
                                      DataColumn(
                                        label: Text('PACKAGE'),
                                      ),
                                      DataColumn(
                                        label: Text('METHOD'),
                                      ),
                                      DataColumn(
                                        label: Text('ACTION'),
                                      ),
                                    ],
                                    rows: List.generate(
                                      sellerInfo.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text((index + 1).toString()),
                                          ),
                                          DataCell(ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CircleAvatar(
                                              child: MyImage(
                                                  imageUrls: sellerInfo[index]
                                                          .pictureUrl ??
                                                      ''),
                                            ),
                                          )),
                                          DataCell(
                                            Text(
                                                sellerInfo[index].companyName ??
                                                    ''),
                                          ),
                                          DataCell(
                                            Text(sellerInfo[index]
                                                    .businessCategory ??
                                                ''),
                                          ),
                                          DataCell(
                                            Text(
                                                sellerInfo[index].phoneNumber ??
                                                    ''),
                                          ),
                                          DataCell(
                                            Text(sellerInfo[index].email ?? ''),
                                          ),
                                          DataCell(
                                            Text(sellerInfo[index]
                                                    .subscriptionName ??
                                                ''),
                                          ),
                                          DataCell(
                                            Text(sellerInfo[index]
                                                    .subscriptionMethod ??
                                                ''),
                                          ),
                                          DataCell(
                                            PopupMenuButton(
                                              icon: const Icon(
                                                  FeatherIcons.moreVertical,
                                                  size: 18.0),
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (BuildContext bc) =>
                                                  [
                                                PopupMenuItem(
                                                  child: GestureDetector(
                                                    onTap: (() =>
                                                        showViewShopPopUp(
                                                            sellerInfo[index])),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            FeatherIcons.eye,
                                                            size: 18.0,
                                                            color: kTitleColor),
                                                        const SizedBox(
                                                            width: 4.0),
                                                        Text(
                                                          'View',
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  color:
                                                                      kTitleColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      EasyLoading.show(
                                                          status: 'Loading...',
                                                          dismissOnTap: false);
                                                      try {
                                                        var sellerkey = "";
                                                        await FirebaseDatabase
                                                            .instance
                                                            .ref('Admin Panel')
                                                            .child(
                                                                'Seller List')
                                                            .orderByKey()
                                                            .get()
                                                            .then((value) {
                                                          for (var element
                                                              in value
                                                                  .children) {
                                                            var data = SellerInfoModel
                                                                .fromJson(jsonDecode(
                                                                    jsonEncode(
                                                                        element
                                                                            .value)));
                                                            if (data.email ==
                                                                sellerInfo[
                                                                        index]
                                                                    .email!) {
                                                              sellerkey =
                                                                  element.key!;
                                                            }
                                                          }
                                                        });
                                                        // SellerInfoModel
                                                        //     sellerinfomodel =
                                                        //     SellerInfoModel(
                                                        //   activeStatus: sellerInfo[
                                                        //                   index]
                                                        //               .activeStatus ==
                                                        //           0
                                                        //       ? 1
                                                        //       : 0,
                                                        // );
                                                        // ignore: no_leading_underscores_for_local_identifiers
                                                        final DatabaseReference
                                                            shopCategoryRef =
                                                            FirebaseDatabase
                                                                .instance
                                                                .ref(
                                                                    'Admin Panel')
                                                                .child(
                                                                    'Seller List')
                                                                .child(sellerkey
                                                                    .toString());
                                                        // .child('Admin Panel')
                                                        // .child('Category');
                                                        await shopCategoryRef
                                                            .update({
                                                          "activeStatus":
                                                              sellerInfo[index]
                                                                          .activeStatus ==
                                                                      0
                                                                  ? 1
                                                                  : 0,
                                                        });
                                                        // await shopCategoryRef.push().set(shopCategoryModel.toJson());
                                                        EasyLoading.showSuccess(
                                                            'Update Successfully!');
                                                        ref.refresh(
                                                            sellerInfoProvider);
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      } catch (e) {
                                                        // EasyLoading.dismiss();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(e
                                                                    .toString())));
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            sellerInfo[index]
                                                                        .activeStatus ==
                                                                    0
                                                                ? Icons
                                                                    .person_off_rounded
                                                                : Icons.person,
                                                            size: 18.0,
                                                            color: kTitleColor),
                                                        SizedBox(width: 4.0),
                                                        Text(
                                                          sellerInfo[index]
                                                                      .activeStatus ==
                                                                  0
                                                              ? 'Deactive'
                                                              : "Active",
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  color:
                                                                      kTitleColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await deleteUser(
                                                          email:
                                                              sellerInfo[index]
                                                                  .email!,
                                                          updateRef: ref);
                                                    },
                                                    // categoryList.length <= 1
                                                    //     ? () {
                                                    //         EasyLoading
                                                    //             .showError(
                                                    //                 'You have to keep one category');
                                                    //       }
                                                    //     : () async {
                                                    //         await deleteCategory(
                                                    //             name: categoryList[index]
                                                    //                     .categoryName ??
                                                    //                 '',
                                                    //             updateRef:
                                                    //                 ref);
                                                    //       },
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.delete,
                                                            size: 18.0,
                                                            color: kTitleColor),
                                                        const SizedBox(
                                                            width: 4.0),
                                                        Text(
                                                          'Delete',
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  color:
                                                                      kTitleColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // PopupMenuItem(
                                                //   child: GestureDetector(
                                                //     onTap: (() => showEditShopPopUp(sellerInfo[index])),
                                                //     child: Row(
                                                //       children: [
                                                //         const Icon(FeatherIcons.edit3, size: 18.0, color: kTitleColor),
                                                //         const SizedBox(width: 4.0),
                                                //         Text(
                                                //           'Edit',
                                                //           style: kTextStyle.copyWith(color: kTitleColor),
                                                //         ),
                                                //       ],
                                                //     ).visible(false),
                                                //   ),
                                                // ),
                                              ],
                                              onSelected: (value) {
                                                Navigator.pushNamed(
                                                    context, '$value');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }, error: (e, stack) {
            return Center(
              child: Text(e.toString()),
            );
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
        },
      ),
    );
  }
}

class MyImage extends StatelessWidget {
  final imageUrls;

  const MyImage({super.key, required this.imageUrls});
  @override
  Widget build(BuildContext context) {
    String imageUrl = imageUrls;
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => ImageElement()..src = imageUrl,
    );
    return HtmlElementView(
      viewType: imageUrl,
    );
  }
}
