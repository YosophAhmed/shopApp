import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screens/search/search_cubit/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  Future<void> search({
    required String text,
  }) async {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: searchProduct,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value!.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(
        errorMessage: error.toString(),
      ));
    });
  }
}
