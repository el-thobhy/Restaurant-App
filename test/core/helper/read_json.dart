import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  if (dir.endsWith('lib')) {
    return File('$dir/test/core/$name').readAsStringSync();
  }
  return File('$dir/test/core/$name').readAsStringSync();
}
