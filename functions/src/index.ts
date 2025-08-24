import * as nodemailer from "nodemailer";
import {defineSecret} from "firebase-functions/params";
import {onRequest} from "firebase-functions/v2/https";
import * as cors from "cors";

// Secrets SMTP
const smtpUser = defineSecret("SMTP_USER");
const smtpPass = defineSecret("SMTP_PASS");

// Autoriser CORS
const corsHandler = cors({origin: true});

export const sendEmail = onRequest(
    {
      secrets: [smtpUser, smtpPass],
      cors: true,
    },
    (req, res) => {
      corsHandler(req, res, async () => {
        try {
          console.log("=== NOUVELLE REQUÊTE ===");
          console.log("Méthode:", req.method);
          console.log("Content-Type:", req.headers["content-type"]);

          if (req.method !== "POST") {
            res.status(405).send({error: "Méthode non autorisée"});
            return;
          }

          // EXTRACTION DES DONNÉES - FORMAT CALLABLE FIREBASE
          let bodyData = req.body;

          console.log("Body initial:", JSON.stringify(bodyData, null, 2));

          // Format spécifique de Cloud Functions Callable
          if (bodyData && typeof bodyData === "object") {
            // Format 1: { data: { to: ..., subject: ... } }
            if (bodyData.data) {
              console.log("Format Callable avec 'data' détecté");
              bodyData = bodyData.data;
            } else if (bodyData.to || bodyData.subject) {
              console.log("Format direct détecté");
              // On garde bodyData tel quel
            } // <- Et l'accolade fermante sur la même ligne
          }

          console.log("Données après extraction:",
              JSON.stringify(bodyData, null, 2));

          const {to, subject, text, lien} = bodyData;

          if (!to || !subject || !text) {
            console.log("Paramètres manquants:", {to, subject, text});
            res.status(400).send({
              error: "Paramètres manquants",
              required: ["to", "subject", "text"],
              received: bodyData,
            });
            return;
          }

          console.log("Envoi email à:", to);

          const user = smtpUser.value();
          const pass = smtpPass.value();

          if (!user || !pass) {
            console.error("Secrets SMTP non configurés");
            res.status(500).send({error: "Configuration SMTP manquante"});
            return;
          }

          const transporter = nodemailer.createTransport({
            service: "gmail",
            auth: {
              user: user,
              pass: pass,
            },
          });

          // Vérification de la connexion SMTP
          try {
            await transporter.verify();
            console.log("Connexion SMTP OK");
          } catch (error) {
            console.error("Erreur SMTP:", error);
            res.status(500).send({
              error: "Erreur de configuration SMTP",
              details: "Vérifiez les identifiants SMTP",
            });
            return;
          }

          const htmlContent = `
          <div style="font-family: Arial, sans-serif; line-height:1.5;">
            <p>${text.replace(/\n/g, "<br>")}</p>
            // Dans votre fonction sendEmail, modifiez la partie lien :
            ${lien ?
              `<p style="margin-top:20px;">
                 <a href="${encodeURI(lien)}"
                    style="background-color:#1976d2;color:#fff;
                    padding:10px 20px;text-decoration:none;border-radius:5px;
                    display:inline-block;">Créer mon compte</a>
               </p>` :
              ""}
            <p style="margin-top:30px;">Cordialement,
            <br>L'équipe du Judo Club Seclin</p>
          </div>
        `;

          const mailOptions = {
            from: user,
            to: to,
            subject: subject,
            text: text,
            html: htmlContent,
          };

          console.log("Envoi en cours...");
          const result = await transporter.sendMail(mailOptions);
          console.log("Email envoyé:", result.messageId);

          res.status(200).send({
            success: true,
            message: "E-mail envoyé avec succès!",
            messageId: result.messageId,
          });
        } catch (error) {
          console.error("Erreur:", error);
          res.status(500).send({
            success: false,
            error: "Erreur lors de l'envoi de l'e-mail",
            details: error instanceof Error ? error.message : String(error),
          });
        }
      });
    }
);
