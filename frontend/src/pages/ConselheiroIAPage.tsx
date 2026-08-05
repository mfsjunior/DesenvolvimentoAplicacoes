import { useState } from 'react';
import { Send, Bot, User } from 'lucide-react';
import api from '../services/api';

interface Message {
  text: string;
  sender: 'user' | 'ai';
}

export default function ConselheiroIAPage() {
  const [messages, setMessages] = useState<Message[]>([
    { text: 'Olá! Sou seu orientador pedagógico IA da UniTech. Como posso ajudar com sua trilha de carreira hoje?', sender: 'ai' }
  ]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSend = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!input.trim()) return;

    const userMessage = input.trim();
    setMessages(prev => [...prev, { text: userMessage, sender: 'user' }]);
    setInput('');
    setLoading(true);

    try {
      // The endpoint consumes raw String, but Axios sends text/plain when passed a string
      const response = await api.post('/api/ia/conselheiro/perguntar', userMessage, {
        headers: {
          'Content-Type': 'text/plain'
        }
      });
      setMessages(prev => [...prev, { text: response.data, sender: 'ai' }]);
    } catch (error) {
      console.error('Erro ao chamar Conselheiro:', error);
      setMessages(prev => [...prev, { text: 'Desculpe, ocorreu um erro de conexão com os serviços de Inteligência Artificial da UniTech.', sender: 'ai' }]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <div className="page-header" style={{ marginBottom: '32px' }}>
        <h1>Conselheiro IA</h1>
        <p>Integração com Spring AI e OpenAI</p>
      </div>

      <div className="chat-container">
        <div className="chat-messages">
          {messages.map((msg, idx) => (
            <div key={idx} className={`chat-bubble ${msg.sender}`} style={{ display: 'flex', gap: '12px', alignItems: 'flex-start' }}>
              {msg.sender === 'ai' ? <Bot size={24} color="var(--primary)" style={{ flexShrink: 0 }} /> : <User size={24} color="white" style={{ flexShrink: 0 }} />}
              <div style={{ paddingTop: '2px' }}>{msg.text}</div>
            </div>
          ))}
          {loading && (
            <div className="chat-bubble ai" style={{ display: 'flex', gap: '12px' }}>
              <Bot size={24} color="var(--primary)" />
              <div style={{ color: 'var(--text-muted)' }}>Pensando...</div>
            </div>
          )}
        </div>
        
        <form className="chat-input" onSubmit={handleSend}>
          <input 
            type="text" 
            value={input} 
            onChange={(e) => setInput(e.target.value)} 
            placeholder="Pergunte sobre cursos, trilhas, mercado de trabalho..."
            disabled={loading}
          />
          <button type="submit" className="btn btn-primary" disabled={loading}>
            <Send size={18} />
          </button>
        </form>
      </div>
    </div>
  );
}
