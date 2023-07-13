import '../../../../core/errors/failure.dart';

class GetPokemonsErros extends Failure {
  GetPokemonsErros({required super.message, required super.stackTrace});
}

class RequestError extends GetPokemonsErros {
  RequestError({required super.message, required super.stackTrace});
}

class FormatError extends GetPokemonsErros {
  FormatError({required super.message, required super.stackTrace});
}
