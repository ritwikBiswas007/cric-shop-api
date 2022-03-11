var express = require('express');
var router = express.Router();
const logger = require('../lib/logger/winston');

router.get('/',
  (req, res, next) => {
    logger.debug("ROOT");
    res.send("ROOT");
  }
);

module.exports = router;
