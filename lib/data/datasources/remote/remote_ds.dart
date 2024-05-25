class RemoteDataSource {
  Future<void> _delay() async =>
      await Future.delayed(const Duration(seconds: 3));

  Stream<String> process() async* {
    yield 'Mengupload data';
    await _delay();
    yield 'Memproses data';
    await _delay();
    yield 'Menerima hasil';
    await _delay();
  }
}
