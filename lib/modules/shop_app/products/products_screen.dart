import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/modules/shop_app/models/home_model.dart';
import 'package:shopapp/providers/provider.dart';
import 'package:shopapp/styles/colors.dart';
import '../models/caregory_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (BuildContext context, value, Widget? child) =>
          value.homeModel != null
              ? productBuilder(value.homeModel, value.categoryModel, context)
              : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget productBuilder(
          HomeModel? model, CategoryModel? categoryModel, context) =>
      ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CarouselSlider(
            items: model!.data!.banners
                .map((e) => Container(
                      padding: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '${e.img}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: defaultClr,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'Categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    categoryModel != null
                        ? SizedBox(
                            height: 112,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    buildCategoryItem(
                                        categoryModel.data!.data[index]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 10,
                                    ),
                                itemCount: categoryModel.data!.data.length),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: defaultClr,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'New Products',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 2.1,
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    buildGridProducts(model.data!.products[index], context),
              ),
            ),
          ),
        ],
      );

  Widget buildGridProducts(ProductModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            model.discount != 0?
            Padding(
              padding: const EdgeInsets.only(right: 10,top:10 ,left: 10),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: CircleAvatar(
                  backgroundColor: defaultClr.withOpacity(.5),
                  radius: 20,
                  child: const Text('offer',style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
            ):Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: '${model.img}',
                    width: double.infinity,
                    height: 180,
                  ),
                ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: defaultClr,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Provider.of<MyProvider>(context, listen: false)
                              .changeFavorite(model.id!);
                        },
                        icon: Icon(
                          Provider.of<MyProvider>(context).favorite[model.id] ==
                                  true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: defaultClr,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCategoryItem(DataModel model) {
  return Column(
    children: [
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: defaultClr, borderRadius: BorderRadius.circular(60)),
        child: CachedNetworkImage(
          imageUrl: '${model.img}',
          height: 95,
          width: 95,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
      ),
      Expanded(
        child: Container(
          width: 100,
          decoration: BoxDecoration(
              color: defaultClr.withOpacity(.8),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            "${model.name}",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}
