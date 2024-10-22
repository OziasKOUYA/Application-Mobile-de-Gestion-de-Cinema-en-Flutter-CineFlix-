class DataResponse<T> {
  final String status;
  final String message;
  final dynamic data;

  DataResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return DataResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  bool isList() {
    return data is List;
  }

  List<T> getData(T Function(dynamic) fromJsonT) {
    if (data is List) {
      var list = data as List;
      return list.map((e) => fromJsonT(e)).toList();
    } else {
      // Si data est une seule donnée
      return [fromJsonT(data)];
    }
  }

  T getSingleData(T Function(dynamic) fromJsonT) {
    return fromJsonT(data);
  }
}
