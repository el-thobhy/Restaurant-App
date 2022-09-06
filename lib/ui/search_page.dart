import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/ui/bloc/search/search_bloc.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/widget/empty_state.dart';
import 'package:restaurant_app/widget/item_list_search.dart';
import 'package:restaurant_app/widget/error_state.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search-page';
  final String query;

  const SearchPage({Key? key, this.query = ""}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController cari = TextEditingController();

  @override
  void initState() {
    super.initState();
    cari.text = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Search'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black54,
          ),
          SafeArea(
            child: Container(
              color: Colors.black,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(fontSize: 20.0, color: Colors.white),
                    onSubmitted: (query) {
                      context.read<SearchBloc>().add(
                            OnQueryChange(query: query),
                          );
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                      hintText: 'Search title',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                  const SizedBox(height: 16),
                  _buildSearchResult(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchResult() {
    return BlocBuilder<SearchBloc, SearchState>(
      key: const Key('search'),
      builder: (context, state) {
        if (state is SearchLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        } else if (state is SearchLoaded) {
          final list = state.result;
          return Column(
            children: list
                .map(
                  (e) => ItemListSearch(
                    e,
                    list,
                    onTap: () {
                      Navigator.pushNamed(context, PageDetail.routeName,
                          arguments: e.id);
                    },
                  ),
                )
                .toList(),
          );
        } else if (state is SearchError) {
          return ErrorState(message: state.message);
        } else if (state is SearchEmpty) {
          return const EmptyState();
        }
        return const EmptyState();
      },
    );
  }
}
