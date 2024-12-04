// pages/index.tsx
import { GetServerSideProps } from 'next';
import { queryDatabase } from '../../lib/db';

// 取得したデータ型
interface HomeProps {
  time: string;
}

const Home = ({ time }: HomeProps) => {
  return (
    <div>
      <h1>Current Time from PostgreSQL</h1>
      <p>{time}</p>
    </div>
  );
};

// getServerSideProps でサーバーサイドでデータを取得して表示
export const getServerSideProps: GetServerSideProps = async () => {
  let time = '';

  try {
    // PostgreSQL から現在の時間を取得
    const result = await queryDatabase('SELECT NOW()');
    time = result[0].now; // 時間のデータを取得
  } catch (error) {
    time = 'Error connecting to the database'; // エラー処理
  }

  return {
    props: {
      time, // サーバーサイドで取得したデータをページに渡す
    },
  };
};


export default Home;