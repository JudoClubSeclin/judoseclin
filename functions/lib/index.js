"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendEmail = void 0;
const functions = require("firebase-functions/v2");
const nodemailer = require("nodemailer");
const https_1 = require("firebase-functions/v2/https");
const params_1 = require("firebase-functions/params");
const smtpUser = (0, params_1.defineSecret)("SMTP_USER");
const smtpPass = (0, params_1.defineSecret)("SMTP_PASS");
// Fonction Firebase pour envoyer un e-mail
exports.sendEmail = functions.https
    .onCall(async (request) => {
    const data = request.data;
    const { to, subject, text } = data;
    const transporter = nodemailer.createTransport({
        host: "smtp.office365.com",
        port: 587,
        secure: true,
        auth: {
            user: smtpUser.value(),
            pass: smtpPass.value(), // Mot de passe Outlook
        },
    });
    const mailOptions = {
        from: smtpUser.value(),
        to,
        subject,
        text, // Corps de l'e-mail
    };
    try {
        await transporter.sendMail(mailOptions);
        return { success: true, message: "E-mail envoyé avec succès!" };
    }
    catch (error) {
        console.error("Erreur lors de l'envoi de l'e-mail :", error);
        throw new https_1.HttpsError("internal", "Erreur lors de l'envoi del'e-mail");
    }
});
//# sourceMappingURL=index.js.map