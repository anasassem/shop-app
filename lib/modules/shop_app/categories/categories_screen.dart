import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/modules/shop_app/models/caregory_model.dart';
import 'package:shopapp/providers/provider.dart';
import 'package:shopapp/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (_, value, child) => value.categoryModel != null
          ? SizedBox(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      buildCategoryItem(value.categoryModel!.data!.data[index]),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: value.categoryModel!.data!.data.length),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildCategoryItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
            color: defaultClr.withOpacity(.8),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: CachedNetworkImage(
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                imageUrl: '${model.img}',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'See all',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
