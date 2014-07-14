require! \../../src/fs
{expect} = require \chai

suite 'fs' ->
  suite '.readFileAsync()' ->
    test 'existance of a method called readFileAsync' ->
      expect fs.read-file-async .to.be.a \function

