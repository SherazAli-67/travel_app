import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/src/bloc_cubit/home_page_cubit/home_states.dart';
import 'package:travel_app/src/services/api_service.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  void fetchCategoryDetail({required String category})async{
    try{
      emit(LoadingCategoriesState());
      final categoriesList = await ApiService.getLocationsByCategory(category);
      emit(LoadedCategoriesState(categoriesList: categoriesList));
    }catch(e){
      String errorMessage = e.toString();
      if(e is PlatformException){
        errorMessage = e.message!;
      }

      emit(LoadingCategoriesFailedState(errorMessage: errorMessage));
    }
  }

}