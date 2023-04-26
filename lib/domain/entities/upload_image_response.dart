class UploadImageResponse {
  UploadImageResponse({
      List<Files>? files,}){
    _files = files;
}

  UploadImageResponse.fromJson(dynamic json) {
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
  }
  List<Files>? _files;
UploadImageResponse copyWith({  List<Files>? files,
}) => UploadImageResponse(  files: files ?? _files,
);
  List<Files>? get files => _files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Files {
  Files({
      String? formDataFieldName, 
      String? accountId, 
      String? filePath, 
      String? fileUrl,}){
    _formDataFieldName = formDataFieldName;
    _accountId = accountId;
    _filePath = filePath;
    _fileUrl = fileUrl;
}

  Files.fromJson(dynamic json) {
    _formDataFieldName = json['formDataFieldName'];
    _accountId = json['accountId'];
    _filePath = json['filePath'];
    _fileUrl = json['fileUrl'];
  }
  String? _formDataFieldName;
  String? _accountId;
  String? _filePath;
  String? _fileUrl;
Files copyWith({  String? formDataFieldName,
  String? accountId,
  String? filePath,
  String? fileUrl,
}) => Files(  formDataFieldName: formDataFieldName ?? _formDataFieldName,
  accountId: accountId ?? _accountId,
  filePath: filePath ?? _filePath,
  fileUrl: fileUrl ?? _fileUrl,
);
  String? get formDataFieldName => _formDataFieldName;
  String? get accountId => _accountId;
  String? get filePath => _filePath;
  String? get fileUrl => _fileUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['formDataFieldName'] = _formDataFieldName;
    map['accountId'] = _accountId;
    map['filePath'] = _filePath;
    map['fileUrl'] = _fileUrl;
    return map;
  }

}