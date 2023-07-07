import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';

class GrantsSearchResult extends StatelessWidget {
  final String title;
  const GrantsSearchResult({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogModelNewsFinanceModel>?>(
        future: SearchAPI.getSearchedGrants(title),
        builder: (BuildContext context, AsyncSnapshot<List<BlogModelNewsFinanceModel>?> snapshot) {
          if (snapshot.hasData) {
            // If the future is complete and has data, display the product data
            final List<BlogModelNewsFinanceModel> products = snapshot.data!;

            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  final BlogModelNewsFinanceModel product = products[index];
                  return everyProductWidgetGrants(context, product);
                  // return Center(child: Text("No Newss found on title '$title'"));
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("No Grants found on title '$title'"));
            // If the future has an error, display the error message
          } else {
            // If the future is not complete yet, display a loading indicator
            // return Center(child: Text("No Grants found on title '$title'"));
            return const Center(child: Text(""));

          }
        });
  }
}
