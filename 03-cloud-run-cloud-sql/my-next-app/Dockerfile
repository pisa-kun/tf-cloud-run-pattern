# ベースイメージとしてNode.js 22系を使用
FROM node:22-alpine

# 作業ディレクトリを設定
WORKDIR /app

# package.json と package-lock.json をコンテナにコピー
COPY package*.json ./

# 必要なパッケージをインストール
RUN npm install

# アプリケーションコードをコンテナにコピー
COPY . .

# Next.js アプリケーションのビルド
RUN npm run build

# サーバーを起動するコマンドを指定
CMD ["npm", "start"]

# コンテナがリッスンするポートを指定
EXPOSE 3000