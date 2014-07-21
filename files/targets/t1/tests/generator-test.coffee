chai       = require 'chai'
{ expect } = chai
gen        = require '../lib/generator'
fs         = require 'fs'
path       = require 'path'


describe 'generator =>', ->

  exists = (root, dirs...) ->
    for dir in dirs
      file = path.resolve(root, dir)
      expect(fs.existsSync(file), 'should have created file: ' + file).to.be.true

  describe 'project generation =>', ->

    source = 'files/sources/t1'
    target = 'files/targets/t1'
    name   = 'new-project-test'

    beforeEach ->
      gen(source:source, target:target, projectName:name)()

    it 'should create all dirs/ and files into the target dir/', ->

      base = target
      exists(base, 'placeholder.js')

    it 'should have interpolated the projectName into the package.json file', ->

      json = fs.readFileSync(path.resolve(target, 'package.json'), 'utf8')
      conf = JSON.parse(json)
      expect(conf.name).to.equal(name)
