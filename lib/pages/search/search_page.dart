import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hardware_app/pages/search/search_metadata.dart';
import 'package:hardware_app/utils/colors.dart';
import 'package:hardware_app/widgets/big_text.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import 'hits_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchTextController = TextEditingController();
  final _productsSearcher = HitsSearcher(
      applicationID: 'B6UFUZYDF3',
      apiKey: 'e29bcaf122d51ba612a05bd2f254bcb2',
      indexName: 'all_product_names');

  Stream<SearchMetadata> get _searchMetadata =>
      _productsSearcher.responses.map(SearchMetadata.fromResponse);

  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 0);

  Stream<HitsPage> get _searchPage =>
      _productsSearcher.responses.map(HitsPage.fromResponse);

  final GlobalKey<ScaffoldState> _mainScaffoldKey = GlobalKey();

  final _filterState = FilterState();

  late final _facetList = FacetList(
      searcher: _productsSearcher,
      filterState: _filterState,
      attribute: 'location');

  @override
  void initState() {
    super.initState();

    _searchTextController.addListener(
      () => _productsSearcher.applyState(
        (state) => state.copyWith(
          query: _searchTextController.text,
          page: 0,
        ),
      ),
    );

    _searchPage.listen((page) {
      if (page.pageKey == 0) {
        _pagingController.refresh();
      }
      _pagingController.appendPage(page.items, page.nextPageKey);
    }).onError((error) => _pagingController.error = error);
    _pagingController.addPageRequestListener((pageKey) =>
        _productsSearcher.applyState((state) => state.copyWith(page: pageKey)));
    _productsSearcher.connectFilterState(_filterState);
    _filterState.filters.listen((_) => _pagingController.refresh());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mainScaffoldKey,
      appBar: AppBar(
        title:  BigText(text: "Search and Find", color: AppColors.mainColor,),
        actions: [
          IconButton(
              onPressed: () => _mainScaffoldKey.currentState?.openEndDrawer(),
              icon:  Icon(Icons.filter_list_sharp))
        ],
      ),
      endDrawer: Drawer(
        child: _filters(context),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: 44,
                child: TextField(
                  controller: _searchTextController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a search term',
                    prefixIcon: Icon(Icons.search),
                  ),
                )),
            StreamBuilder<SearchMetadata>(
              stream: _searchMetadata,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${snapshot.data!.nbHits} hits'),
                );
              },
            ),
            Expanded(
              child: _hits2(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _hits(BuildContext context) => PagedListView<int, ProductModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<ProductModel>(
          noItemsFoundIndicatorBuilder: (_) => const Center(
                child: Text('No results found'),
              ),
          itemBuilder: (_, item, __) => Container(
                color: Colors.white,
                height: 80,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Image.network(item.img)),
                    const SizedBox(width: 20),
                    Expanded(child: Text(item.name))
                  ],
                ),
              )));

  Widget _hits2(BuildContext context) => PagedListView<int, ProductModel>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<ProductModel>(
          noItemsFoundIndicatorBuilder: (_) => const Center(
            child: Text('No results found'),
          ),
          itemBuilder: (_, item, __) => GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getToolsDetail( int.parse(item.id)-1));
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimensions.atomicWidth * 10,
                  right: Dimensions.atomicWidth * 10,
                  bottom: Dimensions.atomicHeight * 10),
              child: Row(
                children: [
                  Container(
                    width: Dimensions.atomicHeight * 120,
                    height: Dimensions.atomicHeight * 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            Dimensions.radius20),
                        color: Colors.white38,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                item.img!))),
                  ),
                  Expanded(
                    child: Container(
                      height: Dimensions.atomicHeight * 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight:
                            Radius.circular(Dimensions.radius20),
                            bottomRight:
                            Radius.circular(Dimensions.radius20)),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height15,
                            left: 15,
                            right: 15),
                        child: AppColumnSmall(
                            productList: [item],
                            index: 0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )));

  Widget _filters(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Filters'),
        ),
        body: StreamBuilder<List<SelectableFacet>>(
            stream: _facetList.facets,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              final selectableFacets = snapshot.data!;
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: selectableFacets.length,
                  itemBuilder: (_, index) {
                    final selectableFacet = selectableFacets[index];
                    return CheckboxListTile(
                      value: selectableFacet.isSelected,
                      title: Text(
                          "${selectableFacet.item.value} (${selectableFacet.item.count})"),
                      onChanged: (_) {
                        _facetList.toggle(selectableFacet.item.value);
                      },
                    );
                  });
            }),
      );

  @override
  void dispose() {
    _searchTextController.dispose();
    _productsSearcher.dispose();
    _filterState.dispose();
    _facetList.dispose();
    _pagingController.dispose();
    super.dispose();
  }
}
