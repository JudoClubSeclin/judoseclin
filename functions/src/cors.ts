import * as cors from "cors";

export const corsHandler = cors({
  origin: true, // en dev autorise tout
  methods: ["GET", "POST", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization"],
});
