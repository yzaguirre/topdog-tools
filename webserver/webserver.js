#!/usr/bin/env node
var connect = require('connect')
var root = process.argv[2]
var app = connect()
	.use(connect.static(root, {hidden:true}))
	.use(connect.directory(root, {hidden:true}))
	// .use(connect.bodyParser()) // body parser not required at this time
	.use(function (req, res) {
		res.end("Couldn't find "+ req.originalUrl);
	})
	.listen(80);

