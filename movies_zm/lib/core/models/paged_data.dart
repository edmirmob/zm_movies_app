class PagedData<T> {
  final List<T> items;
  final int totalCount;
  final int page;

  PagedData(this.items, this.totalCount, this.page);
}
