// pages/index.tsx
import { useEffect, useState } from 'react';

const Home = () => {
  const [time, setTime] = useState<string>('');
  const [error, setError] = useState<string>('');

  useEffect(() => {
    // サーバーからデータを取得
    const fetchData = async () => {
      try {
        const response = await fetch('/api/time');
        const data = await response.json();
        if (response.ok) {
          setTime(data.time);
        } else {
          setError(data.error || 'Failed to fetch data');
        }
      } catch (err) {
        setError('Error fetching data');
      }
    };

    fetchData();
  }, []);

  return (
    <div>
      <h1>Current Time from PostgreSQL</h1>
      {error ? <p>{error}</p> : <p>{time}</p>}
    </div>
  );
};

export default Home;
