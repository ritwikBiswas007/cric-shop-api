/**
 * @type {notification.Template}
 */
const template = {
    USER_REGISTRATION: {
        MAIL: {
            subject: 'User Registration Mail',
            html: `<p>A warm welcome to US Cricket Store. Thank you for registering with us. We hope that our relationship with you will be a long-lasting one.<br><br>
Regards,<br>
US Cricket Store<br>
(Operations team)
</p>`
        },
        SMS: {
            body: 'Welcome to US Cricket Store. Thanks for choosing us. Your order has been placed and we will dispatch your order from our store within 2-3 working days.'
        }
    },
    PASSWORD_RESET: {
        MAIL: {
            subject: 'Password Reset OTP',
            html: `<p>You have requested for a password reset. Please use OTP $ to confirm the process.</p>`
        },
        SMS: {
            body: 'You have requested for a password reset. Please use OTP $ to confirm the process.'
        }
    },
    ORDER_COMPLETION: {
        MAIL: {
            subject: 'Order Completion Mail',
            html: `<p>Thanks for placing the order with us.<br>
Now sit back and relax. We know you can’t wait to get your hands on it.<br>
We will dispatch the order within 3-4 working days.<br><br>
Thanks for choosing us,<br>
US Cricket Store.
</p>`
        },
        SMS: {
            body: 'Welcome to US Cricket Store. Thanks for choosing us. Your order has been placed and we will dispatch your order from our store within 2-3 working days.'
        }
    },
    BOOKING_COMPLETION: {
        MAIL: {
            subject: 'Booking Completion Mail',
            html: `<p>Thanks for placing the booking with us.<br>
We are eagerly waiting to serve you.<br>
*Incase, you want to reschedule the booking, reschedule it 24hours prior your booking.<br><br>
Thanks for choosing us,<br>
US Cricket Store.
</p>`
        },
        SMS: {
            body: `Welcome to US Cricket Store. Thanks for choosing us. Your booking has been confirmed. We are eagerly waiting to serve you.
*Incase, you want to reschedule the booking, reschedule it 24hours prior your booking.`
        }
    }
}

module.exports = template;