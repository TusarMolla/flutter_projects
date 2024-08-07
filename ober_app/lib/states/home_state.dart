



class HomeState{
  int currentIndex ;
  HomeState({this.currentIndex=0});

  HomeState.init():
        currentIndex =0;

  update ({int? index}){

    return HomeState(currentIndex: index??currentIndex);
  }
}