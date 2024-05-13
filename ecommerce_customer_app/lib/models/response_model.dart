class ResponseModel<T>{
 late int statusCode;
 late T object ;
 ResponseModel(this.statusCode, this.object);
}