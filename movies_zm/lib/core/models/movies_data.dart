
class MoviesData {
  final String id;
  final String title;
  final String publicationYear;
  final String url;
   

  MoviesData({
     this.id,
     this.title,
     this.publicationYear,
     this.url,
   

  });

  static MoviesData fromMap(Map<String, Object> data) {
    final attributes=data['attributes'] as Map<String, Object>;
     final poster =attributes['poster']as Map<String, Object>;
      final dataImage =poster['data']as Map<String, Object>;
       final atributtesImage =dataImage['attributes']as Map<String, Object>;
    return MoviesData(
      id: data['id'].toString(),
      title: attributes["name"].toString() ,
      publicationYear: attributes["publicationYear"].toString(),
      url: atributtesImage['url']!=null?  atributtesImage['url'].toString():'',
    );
  }


}
