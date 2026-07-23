import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/presentation/widgets/error_message.dart';

void main() {
  test('usa il messaggio applicativo senza dettagli tecnici', () {
    expect(
      describeError(const ValidationException('Input non valido.')),
      'Input non valido.',
    );
  });

  test('sanitizza ArgumentError senza mostrare valore e nome del campo', () {
    final error = ArgumentError.value(
      'valore-riservato',
      'fieldName',
      'Non puo essere vuoto.',
    );

    final message = describeError(error);

    expect(message, 'Non puo essere vuoto.');
    expect(message, isNot(contains('valore-riservato')));
    expect(message, isNot(contains('fieldName')));
  });

  test('nasconde i dettagli delle eccezioni inattese', () {
    final message = describeError(StateError('dettaglio tecnico interno'));

    expect(message, 'Si e\' verificato un errore inatteso.');
    expect(message, isNot(contains('dettaglio tecnico interno')));
  });
}
