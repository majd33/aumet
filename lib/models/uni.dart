class University {

  University();

  List<dynamic>? domains;
  String? alphaTwoCode;
  String? country;
  List<dynamic>? webPages;
  String? name;

  University.fromJson(Map<String,dynamic> json){
    domains=json['domains'];
    alphaTwoCode=json['alpha_two_code'];
    country=json['country'];
    webPages=json["web_pages"];
    name=json["name"]??"";
  }
}