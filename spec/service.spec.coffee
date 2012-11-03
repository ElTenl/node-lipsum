###
  Behavioral Tests for Lipsum Service
###
Service = require "../lib/service"
http = require "http"
_ = require "lodash"

describe "The lipsum service", ->
  lipsumService = new Service()
  defaultFormat = "json"
  callback = -> {}
  stubOutHTTP = ->
    spyOn(http, 'request').andCallThrough()


  it "should build an endpoint given a format and a callback", ->
    stubOutHTTP()
    lipsumService.get(defaultFormat, callback)
    expect(http.request.mostRecentCall.args[0]).toEqual(
      "http://lipsum.lipsum.com/feed/json")

  it "should be able to accept different query params", ->
    stubOutHTTP()
    lipsumService.get(defaultFormat, callback, {amount: 2, what: "paras"})
    expect(http.request.mostRecentCall.args[0]).toEqual(
      "http://lipsum.lipsum.com/feed/json?amount=2&what=paras")

  it "should be able to accept a callback that gets a payload", ->
    fooFunction = createSpy()
    lipsumService.get("xml", fooFunction)
    waitsFor(->
      return fooFunction.callCount > 0
    , "callback to be called", 1000)
