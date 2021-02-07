class StoredFile {
  String filePath;
  String textID;
  String fileType;

  StoredFile({this.filePath, this.textID, this.fileType});

  StoredFile.fromMap(Map<String, dynamic> map) {
    filePath = map['filePath'];
    textID = map['textID'];
    fileType = map['fileType'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'filePath': filePath,
        'textID': textID.toLowerCase(),
        'fileType': fileType
      };
}
