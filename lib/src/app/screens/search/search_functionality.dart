import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

import 'bloc/search_bloc.dart';
import 'search_widget.dart';

class SearchFunctionality extends StatelessWidget {
  const SearchFunctionality({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          child: Column(children: [
        // --------------------------------------------------------------------- Search Widget
        searchFilterWidget(context, scaffoldKey),
        const SizedBox(height: 10),

        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchStartState) {
              return const SearchWidget();
            }

            return const Text("dasdasdasd");
          },
        ),

        const SizedBox(height: 20)
      ])),
    );
  }
}
