import { useState, useEffect } from 'react';
import { Plus, BookOpen } from 'lucide-react';
import api from '../services/api';

interface Perfil {
  id: string;
  matriculaSqlId: number;
  biografia: string;
  habilidades: string[];
}

export default function PerfisPage() {
  const [perfis, setPerfis] = useState<Perfil[]>([]);
  const [matriculaId, setMatriculaId] = useState('');
  const [biografia, setBiografia] = useState('');
  const [habilidadesText, setHabilidadesText] = useState('');

  const fetchPerfis = async () => {
    try {
      const response = await api.get('/api/perfis');
      setPerfis(response.data);
    } catch (error) {
      console.error('Erro ao buscar perfis:', error);
    }
  };

  useEffect(() => {
    fetchPerfis();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const habilidades = habilidadesText.split(',').map(s => s.trim()).filter(s => s);
    
    try {
      await api.post('/api/perfis', { 
        matriculaSqlId: parseInt(matriculaId), 
        biografia, 
        habilidades 
      });
      setMatriculaId('');
      setBiografia('');
      setHabilidadesText('');
      fetchPerfis();
    } catch (error) {
      console.error('Erro ao criar perfil:', error);
    }
  };

  return (
    <div>
      <div className="page-header" style={{ marginBottom: '32px' }}>
        <h1>Perfis Acadêmicos</h1>
        <p>Enriquecimento de dados dos alunos em base NoSQL (MongoDB)</p>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr', gap: '32px' }}>
        <div className="card">
          <div className="card-title" style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
            <BookOpen size={20} color="var(--secondary)" />
            Novo Perfil
          </div>
          
          <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            <div className="input-group">
              <label>ID do Aluno (SQL)</label>
              <input 
                type="number" 
                value={matriculaId} 
                onChange={(e) => setMatriculaId(e.target.value)} 
                required 
                placeholder="Ex: 1"
              />
            </div>
            <div className="input-group">
              <label>Biografia</label>
              <textarea 
                value={biografia} 
                onChange={(e) => setBiografia(e.target.value)} 
                required 
                placeholder="Breve descrição do aluno..."
                rows={4}
              />
            </div>
            <div className="input-group">
              <label>Habilidades (separadas por vírgula)</label>
              <input 
                type="text" 
                value={habilidadesText} 
                onChange={(e) => setHabilidadesText(e.target.value)} 
                placeholder="Java, React, SQL..."
              />
            </div>
            
            <button type="submit" className="btn btn-primary" style={{ marginTop: '8px', backgroundColor: 'var(--secondary)' }}>
              <Plus size={18} />
              Criar Perfil
            </button>
          </form>
        </div>

        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>Aluno ID</th>
                <th>Biografia</th>
                <th>Habilidades</th>
              </tr>
            </thead>
            <tbody>
              {perfis.length === 0 ? (
                <tr>
                  <td colSpan={3} style={{ textAlign: 'center', padding: '32px', color: 'var(--text-muted)' }}>
                    Nenhum perfil cadastrado.
                  </td>
                </tr>
              ) : (
                perfis.map(perfil => (
                  <tr key={perfil.id}>
                    <td style={{ fontWeight: 500, color: 'var(--text-main)' }}>#{perfil.matriculaSqlId}</td>
                    <td>{perfil.biografia}</td>
                    <td>
                      <div style={{ display: 'flex', gap: '4px', flexWrap: 'wrap' }}>
                        {perfil.habilidades?.map((hab, idx) => (
                          <span key={idx} style={{ background: 'var(--bg-hover)', padding: '2px 8px', borderRadius: '12px', fontSize: '12px', color: 'var(--text-muted)' }}>
                            {hab}
                          </span>
                        ))}
                      </div>
                    </td>
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
