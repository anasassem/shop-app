import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/provider.dart';

import '../../../components/components.dart';
import '../favorites/favorites_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, value,child) => Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Search must not be empty';
                  }
                  return null;
                },
                onFieldSubmitted: (String text) {
                  Provider.of<MyProvider>(context, listen: false).search(text);
                },
                controller: searchController,
                decoration: const InputDecoration(
                  label: Text('Search'),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Provider.of<MyProvider>(context).isLoding == true
                  ? const LinearProgressIndicator()
                  : Container(),
              if (value.searchModel?.status == true)
                Expanded(
                  child: ListView.separated(
                    itemCount: value.searchModel!.data!.data!.length,
                    itemBuilder: (context,index) => buildFavoritItem(
                        value.searchModel!.data!.data![index], context,isSearch: false),
                    separatorBuilder: ( context, index) =>
                        myDivider(),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
