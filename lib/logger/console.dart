import 'dart:io';
import 'package:tint/tint.dart';

import 'base.dart';

class ConsoleLogger extends Logger {
  final String prefix;
  final bool format;

  ConsoleLogger({this.prefix = '', this.format = true});

  @override
  void info(String s) {
    if (format) {
      print(prefix + s);
    } else {
      stdout.writeln(
        prefix + s.replaceAll(RegExp('\u001b\\[\\d+m'), ''),
      );
    }
  }

  @override
  void error(String s) {
    if (format) {
      stderr.writeln(prefix + s.onRed().bold());
    } else {
      stderr.writeln('$prefix[ERROR] $s');
    }
  }

  @override
  void verbose(String s) {
    if (format) {
      stdout.writeln(prefix + s.grey());
    } else {
      stdout.writeln(prefix + s);
    }
  }

  @override
  void warn(String s) {
    if (format) {
      stderr.writeln(prefix + s.yellow());
    } else {
      stderr.writeln('$prefix[warn] $s');
    }
  }

  @override
  void catched(e, st, [context]) {
    warn(prefix + e.toString() + (context == null ? '' : ' [$context]'));
    verbose(prefix + st.toString());
  }
}
