const mysql = require('mysql')
const config = require('config');

const MYSQL_CONFIG = config.get('MYSQL');

/**
 * Create a Mysql Connection Pool for all the DB operations
 */
const db = mysql.createPool({
    connectionLimit: MYSQL_CONFIG.POOL_SIZE,
    host: MYSQL_CONFIG.HOST,
    user: MYSQL_CONFIG.USER,
    port: MYSQL_CONFIG.PORT,
    password: MYSQL_CONFIG.PASSWORD,
    database: MYSQL_CONFIG.DATABASE,
    timezone: require('moment-timezone').tz('America/Los_Angeles').format('Z'),
    timeout: MYSQL_CONFIG.TIMEOUT_SECS * 1000
});

module.exports = db;