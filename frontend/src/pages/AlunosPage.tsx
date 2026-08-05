import { useState, useEffect } from 'react';
import { Plus, UserPlus } from 'lucide-react';
import api from '../services/api';

interface Aluno {
  id: number;
  nome: string;
  cpf: string;
  matricula: string;
}

export default function AlunosPage() {
  const [alunos, setAlunos] = useState<Aluno[]>([]);
  const [nome, setNome] = useState('');
  const [cpf, setCpf] = useState('');
  const [matricula, setMatricula] = useState('');

  const fetchAlunos = async () => {
    try {
      const response = await api.get('/api/alunos');
      setAlunos(response.data);
    } catch (error) {
      console.error('Erro ao buscar alunos:', error);
    }
  };

  useEffect(() => {
    fetchAlunos();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await api.post('/api/alunos', { nome, cpf, matricula });
      setNome('');
      setCpf('');
      setMatricula('');
      fetchAlunos();
    } catch (error) {
      console.error('Erro ao criar aluno:', error);
    }
  };

  return (
    <div>
      <div className="page-header" style={{ marginBottom: '32px' }}>
        <h1>Alunos</h1>
        <p>Gestão do corpo discente acadêmico</p>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '32px' }}>
        {/* Form */}
        <div className="card">
          <div className="card-title" style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
            <UserPlus size={20} color="var(--primary)" />
            Novo Aluno
          </div>
          
          <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            <div className="input-group">
              <label>Nome Completo</label>
              <input 
                type="text" 
                value={nome} 
                onChange={(e) => setNome(e.target.value)} 
                required 
                placeholder="Ex: João Silva"
              />
            </div>
            <div className="input-group">
              <label>CPF</label>
              <input 
                type="text" 
                value={cpf} 
                onChange={(e) => setCpf(e.target.value)} 
                required 
                placeholder="000.000.000-00"
              />
            </div>
            <div className="input-group">
              <label>Matrícula</label>
              <input 
                type="text" 
                value={matricula} 
                onChange={(e) => setMatricula(e.target.value)} 
                required 
                placeholder="Ex: 2024001"
              />
            </div>
            
            <button type="submit" className="btn btn-primary" style={{ marginTop: '8px' }}>
              <Plus size={18} />
              Matricular Aluno
            </button>
          </form>
        </div>

        {/* Table */}
        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>CPF</th>
                <th>Matrícula</th>
              </tr>
            </thead>
            <tbody>
              {alunos.length === 0 ? (
                <tr>
                  <td colSpan={4} style={{ textAlign: 'center', padding: '32px', color: 'var(--text-muted)' }}>
                    Nenhum aluno matriculado ainda.
                  </td>
                </tr>
              ) : (
                alunos.map(aluno => (
                  <tr key={aluno.id}>
                    <td>#{aluno.id}</td>
                    <td style={{ fontWeight: 500, color: 'var(--text-main)' }}>{aluno.nome}</td>
                    <td>{aluno.cpf}</td>
                    <td><span style={{ background: 'var(--bg-dark)', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', border: '1px solid var(--border)' }}>{aluno.matricula}</span></td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
