
#
# Stollbot
# 
# (c) 2012 Das Plutonium Imperium & @dlsym
# 

Twit = require 'twit'

StolliDB = require './stollidb'

sdb = new StolliDB 'stolli.dat'

console.log 'Welcome to Stollbot'
console.log sdb.randomQuote()



twitter = new Twit
	consumer_key: ''
	consumer_secret: ''
	access_token: '',
	access_token_secret: ''



stream = twitter.stream 'user'

stream.on 'tweet', (tweet) =>
	if tweet.in_reply_to_user_id? && tweet.user.screen_name != 'DrAxelStoll'
		twitter.post 'statuses/update'
			status: '@' + tweet.user.screen_name + ' Ja - heil.'
			(err, result) ->
				# do nothing


interval = (ms, func) -> setInterval func, ms

interval 500000, ->
	quote = sdb.randomQuote()
	twitter.post 'statuses/update',
		status: quote
		(err, result) ->
			console.log 'Tweet: ' + quote

interval 362500, ->
	quote = sdb.randomQuote()
	twitter.post 'statuses/update',
		status: quote,
			(err, result) ->
				console.log 'Tweet: ' + quote






