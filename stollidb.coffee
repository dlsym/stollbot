
fs = require 'fs'

class StolliDB

	constructor: (@dbfile) ->
		# load stolli quotes
		quotes = fs.readFileSync(@dbfile).toString()
		@quotes = quotes.split /\n/


	randomQuote: ->
		nq  = @quotes.length
		rnd = Math.floor Math.random() * (nq-1)
		@quotes[rnd]




module.exports = StolliDB

