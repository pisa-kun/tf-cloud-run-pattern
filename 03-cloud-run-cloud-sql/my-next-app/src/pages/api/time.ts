// pages/api/time.ts
import type { NextApiRequest, NextApiResponse } from 'next';
import { queryDatabase } from '../../../lib/db';

const handler = async (req: NextApiRequest, res: NextApiResponse) => {
  try {
    // PostgreSQL から現在の時間を取得
    const result = await queryDatabase('SELECT NOW()');
    res.status(200).json({ time: result[0].now });
  } catch (error) {
    res.status(500).json({ error: 'Failed to connect to the database' });
  }
};

export default handler;