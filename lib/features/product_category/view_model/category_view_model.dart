import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/product_category/service/category_repository.dart';
import 'package:i_shop_riverpod/features/product_category/view_model/category_state.dart';

class CategoryViewModel extends StateNotifier<ProductCategoryState> {
  CategoryViewModel(this._categoryRepository)
      : super(ProductCategoryState.initial());

  final CategoryRepository _categoryRepository;

  void fetchProductCategory(String category) async {
    try {
      final response =
          await _categoryRepository.fetchProductByCategory(category);

      if (response.success) {
        state = state.copyWith(
          productCategory: response.data as List<dynamic>,
          loadState: NetworkState.success,
        );
        return;
      }
      print("error here");
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
         print("error here second");
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }
}

final categoryViewModel =
    StateNotifierProvider.autoDispose<CategoryViewModel, ProductCategoryState>(
  (ref) => CategoryViewModel(
    ref.read(categoryRepository),
  ),
);
