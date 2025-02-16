
abstract class HomeStates {}

class InitialHomeState extends HomeStates{}

class LoadingCategoriesState  extends HomeStates{}
class LoadedCategoriesState extends HomeStates{
  final List<Map<String, dynamic>> categoriesList;
  LoadedCategoriesState({required this.categoriesList});
}
class LoadingCategoriesFailedState extends HomeStates{
  final String errorMessage;
  LoadingCategoriesFailedState({required this.errorMessage});
}