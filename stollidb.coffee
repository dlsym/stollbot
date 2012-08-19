#
# Stollbot - StolliDB 
# 
# (c) 2012 Das Plutonium Imperium & @dlsym
# 
fs = require 'fs'

class StolliDB

	constructor: (@dbfile) ->
		# load stolli quotes
		console.log "[i] Loading #{@dbfile}"
		quotes = fs.readFileSync(@dbfile).toString()
		@quotes = quotes.split /\n/
		console.log "[+] Stolling with #{@quotes.length} quotes."


	randomQuote: ->
		rnd = Math.floor Math.random() * @quotes.length
		@quotes[rnd]


module.exports = StolliDB

