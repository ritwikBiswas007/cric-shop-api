const { createLogger, format, transports } = require('winston');
const config = require('config');
const logConfig = config.get('LOGGER');

// define the custom settings for each transport (file, console)
const options = {
	file: {
		level: logConfig.FILE.LEVEL,
		filename: `${__dirname}/../../logs/${logConfig.FILE.NAME}`,
		handleExceptions: true,
		json: false,
		maxsize: 5242880, // 5MB
		maxFiles: 5,
		colorize: true,
		format: format.combine(
			format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
			format.align(),
			format.printf(info => `${info.level}:${[info.timestamp]}:${info.message}`),
		)
	},
	console: {
		level: logConfig.CONSOLE.LEVEL,
		handleExceptions: true,
		json: false,
		colorize: true,
		format: format.combine(
			format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
			format.align(),
			format.printf(info => `${info.level}:${[info.timestamp]}:${info.message}`),
		)
	},
};

// instantiate a new Winston Logger with the settings defined above
var logger = createLogger({
	transports: [
		new transports.File(options.file),
		new transports.Console(options.console)
	],
	exitOnError: false, // do not exit on handled exceptions
});

// create a stream object with a 'write' function that will be used by `morgan`
logger.stream = {
	write: function (message, encoding) {
		// use the 'info' log level so the output will be picked up by both transports (file and console)
		logger.debug(message);
	},
};

module.exports = logger;