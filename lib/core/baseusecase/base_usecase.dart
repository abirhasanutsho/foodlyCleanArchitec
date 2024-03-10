abstract class BaseUseCase<Type> {
  Future<Type> call();
}
