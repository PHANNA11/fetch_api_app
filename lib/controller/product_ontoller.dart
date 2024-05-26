import 'dart:developer';

import 'package:fetch_api_app/model/product_model.dart';
import 'package:fetch_api_app/repo/repo.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductController extends GetxController
    with StateMixin<List<ProductModel>> {
  final repo = APIRepo();

  void onInit() {
    change(value ?? [], status: RxStatus.success());
    super.onInit();
    getAllProduct();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future getAllProduct() async {
    if (status.isLoadingMore) return;
    if (!status.isLoadingMore && value!.isNotEmpty) {
      change(value, status: RxStatus.loadingMore());
    } else {
      change([], status: RxStatus.loading());
    }
    final responseData = await repo.getAllProducts();

    if (responseData!['data'] != null) {
      if (responseData['data'] != []) {
        value!.assignAll(productModelFromJson(responseData['data']));
        return change(value, status: RxStatus.success());
      }
    } else {
      return change([], status: RxStatus.empty());
    }
    return change([], status: RxStatus.empty());
  }
}
