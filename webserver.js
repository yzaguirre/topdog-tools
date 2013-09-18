#!/usr/bin/env node
var connect = require('connect')

var app = connect()
	.use(connect.static(process.argv[2]))
	.use(function (req, res) {
		res.end("Couldn't find it.");
	})
	.listen(80);

