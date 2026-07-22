import 'package:uuid/uuid.dart';

/// Genera identificativi locali per entita' create dai casi d'uso.
abstract interface class IdGenerator {
  String nextId();
}

/// Implementazione basata su UUID v4.
final class UuidIdGenerator implements IdGenerator {
  UuidIdGenerator({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final Uuid _uuid;

  @override
  String nextId() => _uuid.v4();
}
