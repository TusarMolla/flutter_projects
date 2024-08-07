

class MainState{
  int currentIndex ;
  MainState({this.currentIndex=0});

  MainState.init():
        currentIndex =0;

  update ({int? index}){

    return MainState(currentIndex: index??currentIndex);
  }
}