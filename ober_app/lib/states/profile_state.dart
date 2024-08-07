



class UserDataState{
  String userName,name,email;

  UserDataState({required this.name,required this.email,required this.userName});

  UserDataState.init():
      name="",
  userName = "",
  email='';


  UserDataState  update(UserDataState state){
    UserDataState newState =  state;
     return newState;

  }

}