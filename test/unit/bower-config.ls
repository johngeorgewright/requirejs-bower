require! { Promise: bluebird, path, sinon, chai }
require! <[ chai-as-promised ../../src/fs ]>
proxyquire = require \proxyquire .no-preserve-cache!
chai.use chai-as-promised
{expect} = chai
bower-config = null

function mock-bowerrc
  bowerrc = JSON.stringify directory: \mung
  bowerrc-path = path.join process.cwd!, \.bowerrc
  bowerrc-promise = Promise.resolve bowerrc
  sinon.stub fs, \readFileAsync .with-args bowerrc-path .returns bowerrc-promise

function mock-bower-json
  bower-json-path = path.join process.cwd!, \bower.json
  proxyquire-options = {}
  proxyquire-options[bower-json-path] = private: yes, '@noCallThru': on
  bower-config := proxyquire \../../src/bower-config proxyquire-options

<- suite 'bower-config'

suite '.load()' ->

  suite 'when files exist' ->
    setup mock-bowerrc
    setup mock-bower-json
    teardown -> fs.read-file-async.restore!

    test 'loading a .bowerrc file' ->
      expect bower-config.load! .to.eventually.have.property \directory \mung

    test 'loading a bower.json file' ->
      expect bower-config.load! .to.eventually.have.property \private yes

  suite "when files don't exist" ->
    setup -> bower-config := require \../../src/bower-config

    test 'returning an empty object' ->
      expect bower-config.load! .to.eventually.deep.equal {}

