const jwt = require("jsonwebtoken");

function verifyToken(req, res, next) {
    const authHeader = req.headers.authorization;

    if (!authHeader) {
        return res.status(401).json({ ok: false, msg: "Token não fornecido" });
    }

    const parts = authHeader.split(" ");
    if (parts.length !== 2 || parts[0] !== "Bearer") {
        return res.status(401).json({ ok: false, msg: "Token mal formatado" });
    }

    const token = parts[1];

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
            return res.status(401).json({ ok: false, msg: "Token inválido" });
        }

        req.user = {
            id: decoded.id,
            userType: decoded.userType
        };

        next();
    });
}

module.exports = { verifyToken };
