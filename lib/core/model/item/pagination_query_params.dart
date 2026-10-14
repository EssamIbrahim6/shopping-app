class PaginationQueryParams {
  final int skip;
  final int limit;

  const PaginationQueryParams({required this.skip, required this.limit});

  Map<String, dynamic> toJson() {
    return {'skip': skip, 'limit': limit};
  }
}
