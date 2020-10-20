mixin Crud<T> {
  T create(T t);

  List<T> read();

  T update(T t);

  T delete(T t);
}
