const express = require('express');
const morgan = require('morgan');
const winston = require('./lib/logger/winston');
const cors = require('cors');
const { sendError } = require("./lib/error/error-response");
const {
  UNHANDLED_SERVER_ERROR
} = require("./lib/error/errors.json");

// Routers
const indexRouter = require('./routes/index');
const categoryRouter = require('./routes/category');
const productRouter = require('./routes/product');
const laneRouter = require('./routes/lane');
const paymentRouter = require('./routes/payment');
const userCartRouter = require('./routes/user-cart');
const userWishlistRouter = require('./routes/user-wishlist');
const userBasketRouter = require('./routes/user-basket');
const authRouter = require('./routes/auth');
const userCartCheckoutRouter = require('./routes/cart-checkout');
const userBasketCheckoutRouter = require('./routes/basket-checkout');
const laneBookRouter = require('./routes/lane-book');
const userOrderRouter = require('./routes/user-order');
const shippingRouter = require('./routes/shipping');
const bookingRouter = require('./routes/lane-booking');
const userAccountRouter = require('./routes/user-account');
const shippoRouter = require('./routes/shippo');

const app = express();

app.use(cors());
app.use(morgan('combined', { stream: winston.stream }));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use('/', indexRouter);
app.use('/category', categoryRouter);
app.use('/product', productRouter);
app.use('/lane', laneRouter);
app.use('/lane/book', laneBookRouter);
app.use('/auth', authRouter);
app.use('/payment', paymentRouter);
app.use('/user/cart', userCartRouter);
app.use('/user/wishlist', userWishlistRouter);
app.use('/user/basket', userBasketRouter);
app.use('/user/order', userOrderRouter);
app.use('/cart/checkout', userCartCheckoutRouter);
app.use('/basket/checkout', userBasketCheckoutRouter);
app.use('/user/shipping', shippingRouter);
app.use('/user/booking', bookingRouter);
app.use('/user/account', userAccountRouter);
app.use('/shippo', shippoRouter);

// error handler
app.use((err, req, res, next) => {
  sendError(res, UNHANDLED_SERVER_ERROR, err);
});

module.exports = app;
