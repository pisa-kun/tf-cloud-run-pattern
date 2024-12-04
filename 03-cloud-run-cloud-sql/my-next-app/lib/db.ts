import { Pool } from 'pg'

// PostgreSQL データベースへの接続設定
const pool = new Pool({
    user: process.env.DB_USER,           // 環境変数で DB ユーザー
    host: process.env.DB_HOST,           // 環境変数で DB ホスト（Cloud SQL 接続名）
    database: process.env.DB_NAME,       // 環境変数で DB 名
    password: process.env.DB_PASSWORD,   // 環境変数で DB パスワード
    port: 5432,                          // PostgreSQL のポート
});

export const queryDatabase = async(query: string) => {
    try {
        const result = await pool.query(query);
        return result.rows;
    }catch(_){
        throw new Error('Database query failed');
    }
};