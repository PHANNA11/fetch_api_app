import 'package:cached_network_image/cached_network_image.dart';
import 'package:fetch_api_app/controller/product_ontoller.dart';
import 'package:fetch_api_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("APIs"),
        ),
        body: buildBody(productController: controller));
  }

  Widget buildBody({required ProductController productController}) =>
      productController.obx(
          (state) => ListView.builder(
              itemCount: state!.length,
              itemBuilder: (context, index) =>
                  buildProductCard(pro: state[index])),
          onEmpty: const Center(
            child: Image(
                image: NetworkImage(
                    'https://imgs.search.brave.com/fOVwPHOObBI89tJS-1YaGnS8U-L79iBZE6tCg1FD8Ec/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZmF2cG5nLmNvbS8x/NC8xNC80L2dyYXNz/LWxlYWYtYW5nbGUt/c3ltYm9sLXBuZy1m/YXZwbmctVU40OVBi/MDVFdk55ekE5Y1VC/WHQ2WmFDYl90Lmpw/Zw')),
          ),
          onLoading: buildShrimmer());

  Widget buildProductCard({required ProductModel pro}) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(pro.title.toString()),
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                height: 120,
                width: 100,
                imageUrl: pro.image.toString(),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(child: Text(pro.description.toString()))
          ],
        ),
        Row(
          children: [
            Text(
              '\$${pro.price}',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Widget buildShrimmer() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          period: const Duration(milliseconds: 2500),
          baseColor: Colors.grey,
          highlightColor: Colors.blueGrey,
          child: Container(
            margin: const EdgeInsets.all(0),
            width: 300,
            height: 200,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ),
    );
  }
}
