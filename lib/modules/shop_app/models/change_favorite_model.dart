class ChangeFavoriteModel{
  bool ?status;
  String ?msg;

  ChangeFavoriteModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    msg =json['message'];
  }
}