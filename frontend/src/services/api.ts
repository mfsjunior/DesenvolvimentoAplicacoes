import axios from 'axios';

// Vite env vars are prefixed with VITE_
const gatewayUrl = import.meta.env.VITE_API_GATEWAY_URL || 'http://localhost:8080';

const api = axios.create({
  baseURL: gatewayUrl,
  headers: {
    'Content-Type': 'application/json',
  },
});

export default api;
