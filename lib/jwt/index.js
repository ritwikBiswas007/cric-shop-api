const { sign, verify } = require('jsonwebtoken')
const config = require('config');
const SECRET = config.get('SERVER.SECRET');

/**
 * Create token
 * @param {object} payload 
 * @param {Number} expiresIn - expiry in seconds
 * @returns {string} The JSON Web Token string
 */
function createToken(payload, expiresIn) {
    const options = { algorithm: 'HS256', expiresIn: expiresIn ? expiresIn : 3600 * 24 * 7 };
    return sign(payload, SECRET, options);
}

/**
 * Decode token
 * @param {string} token - The JSON Web Token string
 * @returns {object} Decoded payload
 */
function verifyToken(token) {
    return verify(token, SECRET, { complete: true });
}

exports.jwt = { createToken, verifyToken };