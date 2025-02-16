import * as functions from "firebase-functions/v2";
interface EmailData {
    to: string;
    subject: string;
    text: string;
}
export declare const sendEmail: functions.https.CallableFunction<EmailData, Promise<{
    success: boolean;
    message: string;
}>, unknown>;
export {};
