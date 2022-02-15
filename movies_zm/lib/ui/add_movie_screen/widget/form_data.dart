

class FormData {
  final String id;
  final String name;
  final String publicationYear;
  final String filePath;

  FormData({this.id, this.name, this.publicationYear, this.filePath});

  FormData copyWith({
    String id,
    String name,
    String publicationYear,
    String filePath,
  }) {
    return FormData(
      id: id ?? this.id,
        name: name ?? this.name,
        publicationYear: publicationYear ?? this.publicationYear,
        filePath: filePath ?? this.filePath);
  }
}
