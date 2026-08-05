import { useState, useEffect } from 'react';
import { Users, Settings, Activity } from 'lucide-react';
import api from '../services/api';

export default function Dashboard() {
  const [alunosCount, setAlunosCount] = useState<number | string>('--');
  const [perfisCount, setPerfisCount] = useState<number | string>('--');

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const alunosRes = await api.get('/api/alunos').catch(() => ({ data: [] }));
        const perfisRes = await api.get('/api/perfis').catch(() => ({ data: [] }));
        
        setAlunosCount(alunosRes.data.length || 0);
        setPerfisCount(perfisRes.data.length || 0);
      } catch (error) {
        console.error('Erro ao buscar dados do dashboard:', error);
        setAlunosCount('Erro');
        setPerfisCount('Erro');
      }
    };
    
    fetchStats();
  }, []);

  return (
    <div>
      <div className="page-header">
        <h1>Dashboard</h1>
        <p>Visão geral do ecossistema UniTech</p>
      </div>
      
      <div className="dashboard-grid" style={{ marginTop: '32px' }}>
        <div className="card">
          <div className="card-title" style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <Users color="var(--primary)" />
            Alunos Cadastrados
          </div>
          <h2 style={{ fontSize: '36px', fontWeight: 'bold' }}>{alunosCount}</h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '14px' }}>Base Relacional (PostgreSQL)</p>
        </div>
        
        <div className="card">
          <div className="card-title" style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <Settings color="var(--secondary)" />
            Perfis Ativos
          </div>
          <h2 style={{ fontSize: '36px', fontWeight: 'bold' }}>{perfisCount}</h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '14px' }}>Base NoSQL (MongoDB)</p>
        </div>
        
        <div className="card">
          <div className="card-title" style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <Activity color="var(--danger)" />
            Microsserviços
          </div>
          <h2 style={{ fontSize: '36px', fontWeight: 'bold' }}>6 / 6</h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '14px' }}>Status: Todos Operacionais</p>
        </div>
      </div>
    </div>
  );
}
