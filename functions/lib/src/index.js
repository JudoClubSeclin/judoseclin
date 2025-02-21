"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendEmail = void 0;
const functions = __importStar(require("firebase-functions/v2"));
const nodemailer = __importStar(require("nodemailer"));
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