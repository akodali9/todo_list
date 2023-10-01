import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/grid_provider.dart';

class SearchComp extends StatefulWidget {
  static const String routename = '/search-page';
  const SearchComp({super.key, required this.isGridViewActive});
  final bool isGridViewActive;

  @override
  State<SearchComp> createState() => _SearchCompState();
}

class _SearchCompState extends State<SearchComp> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      toolbarHeight: 70,
      titleSpacing: 0,
      scrolledUnderElevation: 1,
      snap: true,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController searchcontroller) {
            return SearchBar(
              hintText: "Search",
              onTap: () {
                searchcontroller.openView();
              },
              elevation: const MaterialStatePropertyAll(2),
              trailing: [
                if (widget.isGridViewActive == true)
                  IconButton(
                      tooltip: "Single-Column view",
                      onPressed: () {
                        Provider.of<GridSettings>(context, listen: false)
                            .setGridStatus(false);
                      },
                      icon: const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.view_column_outlined)))
                else
                  IconButton(
                      tooltip: "Grid view",
                      onPressed: () {
                        Provider.of<GridSettings>(context, listen: false)
                            .setGridStatus(true);
                      },
                      icon: const Icon(Icons.grid_view_outlined)),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    tooltip: "Search",
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ),
              ],
              controller: searchcontroller,
            );
          },
          suggestionsBuilder: (context, controller) {
            return List<ListTile>.generate(
              1,
              (int index) {
                const String item = 'Coming Soon';
                return ListTile(
                  title: const Text(item),
                  onTap: () {
                    setState(
                      () {
                        controller.closeView(item);
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
