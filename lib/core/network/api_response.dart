class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool isSuccess;
  final int? statusCode;

  ApiResponse._( {
    this.data,
    this.error,
    required this.isSuccess,
    this.statusCode,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse._(
      data: data,
      isSuccess: true,
    );
  }

  factory ApiResponse.error(String error) {
    return ApiResponse._(error: error, isSuccess: false);
  }
}
