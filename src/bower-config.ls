require! { path, \./fs }

bowerrc-path = path.join process.cwd!, \.bowerrc
bower-json-path = path.join process.cwd!, \bower.json
bower-json = try
  require bower-json-path
catch
  {}

function require-bowerrc
  fs.read-file-async bowerrc-path .then JSON.parse .catch -> {}

function load
  bowerrc <- require-bowerrc!then
  json = bowerrc
  json <<<< bower-json
  json

module.exports <<< { load }

