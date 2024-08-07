



class DemoState{
  int count ;

  DemoState({this.count=0});

  DemoState.init():
        count =0;

  update ({int? count}){
    print(count);
    return DemoState(count: count??this.count);
  }
}