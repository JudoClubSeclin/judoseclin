import * as functions from "firebase-functions/v2";
import * as nodemailer from "nodemailer";
import {HttpsError} from "firebase-functions/v2/https";

interface EmailData {
  to: string;
  subject: string;
  text: string;
}

// Configurer le transporteur SMTP (exemple avec Gmail)
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "votre_adresse@gmail.com", // Remplacez par votre adresse Gmail
    pass: "votre_mot_de_passe",
    // Remplacez par votre mot de passe ou un mot de passe d'application
  },
});

// Définir la fonction Firebase
export const sendEmail = functions.https
  .onCall(async (request: functions.https.CallableRequest<EmailData>) => {
    const data = request.data;
    const {to, subject, text} = data;

    const mailOptions = {
      from: "votre_adresse@gmail.com",
      to,
      subject,
      text,
    };

    try {
      await transporter.sendMail(mailOptions);
      return {success: true, message: "E-mail envoyé avec succès !"};
    } catch (error) {
      console.error("Erreur lors de l'envoi de l'e-mail :", error);
      throw new HttpsError(
        "internal",
        "Erreur lors de l'envoi de l'e-mail",
      );
    }
  });
