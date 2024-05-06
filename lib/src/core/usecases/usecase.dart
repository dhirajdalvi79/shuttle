abstract class UseCaseWithParameter<Result, Parameter> {
  const UseCaseWithParameter();

  Result call({required Parameter parameter});
}

abstract class UseCaseWithoutParameter<Result> {
  const UseCaseWithoutParameter();

  Result call();
}
