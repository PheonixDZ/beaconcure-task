import client from 'prom-client';

// Create a Registry to register the metrics
const register = new client.Registry();

// Add default metrics (CPU, memory, etc.)
client.collectDefaultMetrics({ register });

// Custom metrics
export const httpRequestDurationMicroseconds = new client.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code'],
  buckets: [0.1, 0.5, 1, 2, 5],
  registers: [register],
});

export const httpErrorsTotal = new client.Counter({
  name: 'http_errors_total',
  help: 'Total number of HTTP errors',
  labelNames: ['method', 'route', 'status_code'],
  registers: [register],
});

export const activeUsers = new client.Gauge({
  name: 'active_users_total',
  help: 'Total number of active users',
  registers: [register],
});

export const imageUploadsTotal = new client.Counter({
  name: 'image_uploads_total',
  help: 'Total number of image uploads',
  labelNames: ['status'],
  registers: [register],
});

export { register }; 