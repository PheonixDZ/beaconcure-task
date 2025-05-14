import { Request, Response, NextFunction } from 'express';
import { httpRequestDurationMicroseconds, httpErrorsTotal, activeUsers } from './metrics';

// Track unique users using IP addresses
const userIPs = new Set<string>();

export const metricsMiddleware = (req: Request, res: Response, next: NextFunction) => {
  const start = Date.now();
  const userIP = req.ip;

  // Track active users
  userIPs.add(userIP);
  activeUsers.set(userIPs.size);

  // Track response time and errors
  res.on('finish', () => {
    const duration = Date.now() - start;
    const route = req.route ? req.route.path : req.path;
    const statusCode = res.statusCode;

    // Record request duration
    httpRequestDurationMicroseconds
      .labels(req.method, route, statusCode.toString())
      .observe(duration / 1000); // Convert to seconds

    // Record errors (status codes >= 400)
    if (statusCode >= 400) {
      httpErrorsTotal
        .labels(req.method, route, statusCode.toString())
        .inc();
    }
  });

  next();
}; 