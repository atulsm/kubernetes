const http  = require('http');

http.createServer( (req,res) => {
	console.log('Received request from ' + req.url);
	res.writeHead(200);
	res.end('Hello world');
	
}).listen(8080);