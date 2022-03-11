export as namespace notification
export = notification

declare namespace notification {
    interface Template {
        [string]: {
            MAIL: {
                subject: string;
                html: string;
            },
            SMS: {
                body: string;
            }
        }
    }

    /**
     * SMS
     */
    interface SMS {
        /**
         * Receiver
         */
        to: string;
        /**
         * Actual content
         */
        body: string;
    }
    /**
     * EMAIL
     */
    interface Email {
        /**
         * Receiver
         */
        to: string;
        /**
         * Subject of EMAIL
         */
        subject: string;
        /**
         * Actual content
         */
        html: string;
    }
}