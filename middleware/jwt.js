const jwt = require('jsonwebtoken');

// Middleware function to verify JWT
function verifyJwtToken(req, res, next) {
  const token = req.headers.authorization; // Extract the JWT from the request header

  if (!token) {
    return res.status(401).json({ message: 'Authentication token is missing' });
  }

  if(!req.body)
    console.log(`req.body initial= ${JSON.stringify(req.body)}`);
  
  try {
    const decoded = jwt.verify(token.split(' ')[1], process.env.SECRET_KEY); // Verify and decode the token
    req.user = decoded; // Store the decoded user data in the request object
    next(); // Move to the next middleware
  } catch (error) {
    return res.status(401).json({ message: 'Invalid token' });
  }
}

module.exports = {
  verifyJwtToken
};
