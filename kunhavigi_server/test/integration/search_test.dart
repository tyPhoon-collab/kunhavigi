// Import the generated test helper file, it contains everything you need.
import 'dart:async';

import 'package:kunhavigi_shared/kunhavigi_shared.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  // This is an example test that uses the `withServerpod` test helper.
  // `withServerpod` enables you to call your endpoints directly from the test like regular functions.
  // Note that after adding or modifying an endpoint, you will need to run
  // `serverpod generate` to update the test tools code.
  // Refer to the docs for more information on how to use the test helper.
  withServerpod('searchEntries', (sessionBuilder, endpoints) async {
    test('searchEntries returns expected results', () async {
      final takes = StreamController<int>();
      final stream = endpoints.browse.searchEntries(
          sessionBuilder, const SearchQuery(query: '.'), takes.stream);

      takes.add(5);

      await for (final response in stream) {
        print('Received response: $response');
        expect(response.entries, isNotEmpty);
        expect(response.hasMore, isTrue);
        await takes.close();
      }
    });
  });
}
