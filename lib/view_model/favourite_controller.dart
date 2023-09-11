import 'package:flutter/cupertino.dart';
import '../model/popular_items_model.dart';
import '../service/api_client.dart';
import '../utils/shared_preferences.dart';
import '../utils/utils.dart';

class FavouriteController extends ChangeNotifier {

  List<String> favouriteItemTds = [];
  int isFavChange = 0;
  bool isLoading = true;
  PopularItemsModel? favItemList;

  _changeLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isFavourite(String id) {
    bool isFav = favouriteItemTds.contains(id);
    return isFav;
  }

  addFavouriteItems(String id) {
    favouriteItemTds.add(id);
    // for changing icon ui, because selector will rebuild only if isFavourite change
    isFavChange = favouriteItemTds.length;
    SharedPref().saveList("favourites", favouriteItemTds);
    notifyListeners();
  }

  removeFavouriteItems(String id) {
    favouriteItemTds.removeWhere((element) => element == id);
    // for changing icon ui, because selector will rebuild only if isFavourite change
    isFavChange = favouriteItemTds.length;
    if (favItemList != null) {
      favItemList!.data.removeWhere((element) {
        return element.slug == id;
      });
    }

    SharedPref().saveList("favourites", favouriteItemTds);
    notifyListeners();
  }

  Future<void> getFavouriteItems() async {
    favouriteItemTds = await SharedPref().getList("favourites") ?? [];
    notifyListeners();
  }

  Future<void> getFavItemsById(BuildContext context) async {
    var queryParameters = {
      "slugs": favouriteItemTds,
    };

    String queryString = queryParameters.entries
        .map((e) => '${e.key}[]=${e.value.join('&${e.key}[]=')}')
        .join('&');

    var response = await ApiClient()
        .get(
      'cart?$queryString',
      header: Utils().apiHeader,
    )
        .catchError((e) {
      Utils.showSnackBar(e.message, context);
    });

    if (response == null) return;

    favItemList = popularItemsModelFromJson(response);
    _changeLoadingState(false);
    return;
  }

}
