import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/core/data/models/detail/detail_restaurant.dart';

class FakeEither<L, R> extends Fake implements Either<L, R> {}

class FakeDetailResponse extends Fake implements DetailResponse {}

class FakeResponse extends Fake implements Response {}

class FakeStreamedResponse extends Fake implements StreamedResponse {}

class MockHttpClient extends Mock implements Client {
  MockHttpClient() {
    throwOnMissingStub(this);
  }

  @override
  Future<Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  Future<Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  Future<Response> post(Uri? url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  Future<Response> put(Uri? url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  Future<Response> patch(Uri? url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  Future<Response> delete(Uri? url,
          {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<Response>.value(FakeResponse()))
          as Future<Response>);
  @override
  Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as Future<String>);
  @override
  Future<Uint8List> readBytes(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<Uint8List>.value(Uint8List(0)))
          as Future<Uint8List>);
  @override
  Future<StreamedResponse> send(BaseRequest? request) => (super.noSuchMethod(
          Invocation.method(#send, [request]),
          returnValue: Future<StreamedResponse>.value(FakeStreamedResponse()))
      as Future<StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
