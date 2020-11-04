mixin Crud<T> {
  Future<T> createEntity(T t);

  Future<List<T>> readEntities();

  Future<T> updateEntity(T t);

  Future<T> deleteEntity(T t);
}
