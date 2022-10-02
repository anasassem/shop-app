import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/modules/shop_app/models/favorite_model.dart';
import 'package:shopapp/providers/provider.dart';

import '../../../styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
        builder: (BuildContext context, value, Widget? child) =>
        value.favoriteModel!=null?
            ListView.separated(
              itemCount: value.favoriteModel!.data!.data!.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildFavoritItem(
                      value.favoriteModel!.data!.data![index].product!, context),
              separatorBuilder: (BuildContext context, int index) =>
                  myDivider(),
            ):const Center(child: CircularProgressIndicator()));
  }


}
Padding buildFavoritItem(model, context, {bool isSearch=true}) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      height: 180,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: defaultClr.withOpacity(.1)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:BoxDecoration(
                  color: defaultClr,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: CachedNetworkImage(
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                imageUrl: '${model.image}',
                placeholder: (context, url) => const CircularProgressIndicator(),
              ),
            ),
            if (model.discount != 0)
              const SizedBox(
                width: 20,
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  model.discount != 0&& isSearch?
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: CircleAvatar(
                      backgroundColor: defaultClr.withOpacity(.5),
                      radius: 20,
                      child: const Text('offer',style: TextStyle(fontSize: 15,color: Colors.white),),
                    ),
                  ):Container(),
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3,color: defaultClr),
                  ),
                  const Spacer(),
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
                      if (model.discount != 0&& isSearch)
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
                          Provider.of<MyProvider>(context)
                              .favorite[model.id] ==
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
    ),
  );
}