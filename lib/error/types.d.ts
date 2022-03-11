export as namespace error
export = error

declare namespace error {

    interface ErrorDefinition {
        /**
         * HTTP Status
         */
        status: number;
        /**
         * Error code
         */
        code: string;
        /**
         * Error message
         */
        message: string;
    }
}