import * as functions from "firebase-functions/v2";
import * as nodemailer from "nodemailer";
import {HttpsError} from "firebase-functions/v2/https";
import {defineSecret} from "firebase-functions/params";

interface EmailData {
to: string;
subject: string;
text: string;
}

const smtpUser = defineSecret("SMTP_USER");
const smtpPass = defineSecret("SMTP_PASS");

// Fonction Firebase pour envoyer un e-mail
export const sendEmail = functions.https
    .onCall(async (request: functions.https.CallableRequest<EmailData>) => {
      const data = request.data;
      const {to, subject, text} = data;

      const transporter = nodemailer.createTransport({
        host: "smtp.office365.com", // Serveur SMTP d'Outlook
        port: 587, // Port SMTP pour Outlook
        secure: true, // `true` car on utilise STARTTLS
        auth: {
          user: smtpUser.value(), // Adresse e-mail Outlook
          pass: smtpPass.value(), // Mot de passe Outlook
        },
      });

      const mailOptions = {
        from: smtpUser.value(), // Expéditeur
        to, // Destinataire
        subject, // Sujet de l'e-mail
        text, // Corps de l'e-mail
      };

      try {
        await transporter.sendMail(mailOptions);
        return {success: true, message: "E-mail envoyé avec succès!"};
      } catch (error) {
        console.error("Erreur lors de l'envoi de l'e-mail :", error);
        throw new HttpsError(
            "internal",
            "Erreur lors de l'envoi del'e-mail"
        );
      }
    });
