import 'dart:math' as math;

/*
 * Fancy ID generator that creates 20-character string identifiers with the following properties:
 *
 * 1. They're based on timestamp so that they sort *after* any existing ids.
 * 2. They contain 72-bits of random data after the timestamp so that IDs won't collide with other clients' IDs.
 * 3. They sort *lexicographically* (so the timestamp is converted to characters that will sort properly).
 * 4. They're monotonically increasing.  Even if you generate more than one in the same timestamp, the
 *    latter ones will sort after the former ones.  We do this by using the previous random bits
 *    but "incrementing" them by 1 (only in the case of a timestamp collision).
 */

// Modeled after base64 web-safe chars, but ordered by ASCII.
const String _kPushChars =
    '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz';
typedef String StringCallback();

StringCallback generatePushId = () {
  // Timestamp of last push, used to prevent local collisions if you push twice in one ms.
  int lastPushTime = 0;

  // We generate 72-bits of randomness which get turned into 12 characters and appended to the
  // timestamp to prevent collisions with other clients.  We store the last characters we
  // generated because in the event of a collision, we'll use those same characters except
  // "incremented" by one.
  final List<int> randomSuffix = new List<int>(12);
  final math.Random random = new math.Random.secure();

  return () {
    final int now = new DateTime.now().toUtc().millisecondsSinceEpoch;
    String id = _toPushIdBase64(now, 8);

    if (now != lastPushTime) {
      for (int i = 0; i < 12; i += 1) {
        randomSuffix[i] = random.nextInt(64);
      }
    } else {
      // If the timestamp hasn't changed since last push, use the same random number, except incremented by 1.
      int i;
      for (i = 11; i >= 0 && randomSuffix[i] == 63; i--) randomSuffix[i] = 0;
      randomSuffix[i] += 1;
    }
    final String suffixStr = randomSuffix.map((int i) => _kPushChars[i]).join();
    lastPushTime = now;

    return '$id$suffixStr';
  };
}();

String _toPushIdBase64(int value, int numChars) {
  List<String> chars = new List<String>(numChars);
  for (int i = numChars - 1; i >= 0; i -= 1) {
    chars[i] = _kPushChars[value % 64];
    value = (value / 64).floor();
  }
  assert(value == 0);
  return chars.join();
}
