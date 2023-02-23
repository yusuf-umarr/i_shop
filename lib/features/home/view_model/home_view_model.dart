import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_shop_riverpod/core/utils/enums.dart';
import 'package:i_shop_riverpod/features/home/services/home_repository.dart';
import 'package:i_shop_riverpod/features/home/view_model/home_state.dart';

class DealOfDayViewModel extends StateNotifier<DealofDayState> {
  DealOfDayViewModel(this._homeRepository) : super(DealofDayState.initial());

  final HomeRepository _homeRepository;

  void fetchDealOfDay() async {
    try {
      final response = await _homeRepository.fetchDealOfDay();
      if (response.success) {
        state = state.copyWith(
          dealOfDayProduct: response.data,
          loadState: NetworkState.success,
        );
        return;
      }
      state = state.copyWith(
        loadState: NetworkState.error,
        message: response.message,
      );
    } catch (e) {
      state = state.copyWith(
        loadState: NetworkState.error,
        message: e.toString(),
      );
    }
  }
}

final dealOfDayViewModel =
    StateNotifierProvider<DealOfDayViewModel, DealofDayState>(
        (ref) => DealOfDayViewModel(
          ref.read(homeRepository)
        ));
