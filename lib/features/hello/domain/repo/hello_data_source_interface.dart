abstract interface class HelloDataSourceInterface {
  bool hasVisitedHello();
  Future<void> markHelloAsVisited();
}
