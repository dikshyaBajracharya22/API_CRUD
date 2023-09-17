class DataResponse {
  bool status;
  List data;
  final String message;

  DataResponse(
      {required this.data, required this.message, required this.status});

  factory DataResponse.success(List items) {
    return DataResponse(data: items, message: "", status: true);
  }
  factory DataResponse.error(String message) {
    return DataResponse(data: [], message: message, status: false);
  }
}
