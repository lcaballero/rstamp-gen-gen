qu        = require 'inquirer'
_         = require 'lodash'
path      = require 'path'
gen       = require './generator'
questions = require './questions'


module.exports = (rstampConf) ->
  qu.prompt(questions(rstampConf or {}), (answer) ->
    answer.source = path.resolve(__dirname, "../files/sources/s1")
    gen(answer)()
  )
