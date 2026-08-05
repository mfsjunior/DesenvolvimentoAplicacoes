import { BrowserRouter, Routes, Route, Link, useLocation } from 'react-router-dom';
import { Home, Users, Settings, MessageSquare, Menu } from 'lucide-react';
import Dashboard from './pages/Dashboard';
import AlunosPage from './pages/AlunosPage';
import PerfisPage from './pages/PerfisPage';
import ConselheiroIAPage from './pages/ConselheiroIAPage';

function NavItem({ to, icon: Icon, children }: { to: string; icon: any; children: React.ReactNode }) {
  const location = useLocation();
  const isActive = location.pathname === to;
  
  return (
    <Link to={to} className={`nav-item ${isActive ? 'active' : ''}`}>
      <Icon size={20} />
      {children}
    </Link>
  );
}

function App() {
  return (
    <BrowserRouter>
      <div className="app-container">
        <aside className="sidebar">
          <div className="brand">
            <div style={{ background: 'var(--primary)', padding: '8px', borderRadius: '8px', display: 'flex' }}>
              <Menu size={20} color="white" />
            </div>
            UniTech
          </div>
          
          <nav className="nav-links">
            <NavItem to="/" icon={Home}>Dashboard</NavItem>
            <NavItem to="/alunos" icon={Users}>Alunos</NavItem>
            <NavItem to="/perfis" icon={Settings}>Perfis</NavItem>
            <NavItem to="/conselheiro" icon={MessageSquare}>Conselheiro IA</NavItem>
          </nav>
        </aside>

        <main className="main-content">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/alunos" element={<AlunosPage />} />
            <Route path="/perfis" element={<PerfisPage />} />
            <Route path="/conselheiro" element={<ConselheiroIAPage />} />
          </Routes>
        </main>
      </div>
    </BrowserRouter>
  );
}

export default App;
