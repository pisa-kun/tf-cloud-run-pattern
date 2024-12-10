# terraformでCloud Runをデプロイするまで
TerraformでCloud Runを何パターンか管理する。

## Cloud Runだけデプロイする
Hello Worldを返すページをCloud Runでデプロイする。

### ディレクトリ構成
```bash
terraform/
├── terraform.tfvars # プロジェクトIDを設定する
├── main.tf          # 主要なTerraform設定ファイル
├── variables.tf     # 変数定義ファイル
├── outputs.tf       # 出力設定ファイル
└── provider.tf      # プロバイダ設定ファイル

```

```hcl
project_id = "your-project-id"

```

```bash
terraform init

terraform apply
```

windowsの認証ファイルの場所
```
C:\Users\<YourUsername>\AppData\Roaming\gcloud\credentials
```

## Cloud RunとIAPを連携する(Load Balancerなし版)
https://zenn.dev/iret/articles/cloud-run-iap-auth

## Cloud RunとIAPを連携する(Load Balancerあり版)


## Cloud RunにNextjsのアプリをデプロイする
NextjsのサンプルアプリをCloud Runでデプロイする。

### 必要な準備
1. Next.js アプリケーションの作成
最初に、簡単な Next.js アプリケーションを作成して、それを Google Cloud Run にデプロイします。

2. Dockerfile の作成
Cloud Run にデプロイするためには、Next.js アプリを Docker コンテナとしてパッケージングする必要があります。そのために Dockerfile を作成します。

3. Terraform 設定
Terraform を使って Cloud Run のリソースを管理します。

#### 1. Next.js アプリケーションの作成
まず、Next.js アプリケーションを作成します。

```bash
# Next.js アプリケーションの作成
npx create-next-app my-next-app
cd my-next-app

# サンプルページが作成されたことを確認
npm run dev
```

#### 2. Docker イメージのビルドとプッシュ
1. Docker イメージをビルド
```bash
cd my-next-app

docker build -t gcr.io/${var.project_id}/nextjs-app .
```

2. Google Cloud にログイン
```bash
gcloud auth configure-docker
```

3. Docker イメージを Google Container Registry にプッシュ
```bash
docker push gcr.io/${var.project_id}/nextjs-app
```

#### 3. Terraformの初期化と実行

```
terraform init

terraform apply
```

## Cloud Run + Cloud SQLをデプロイする
Cloud Run上にNextjsのサンプルアプリをデプロイしてCloud SQL上のPostgreSQL DBと簡単な疎通を実施する。

### main.tfの変更

1. Cloud SQL インスタンスの作成
google_sql_database_instance リソースで PostgreSQL インスタンスを作成します。インスタンスのタイプ（db-f1-micro）や IP 設定（IPv4を無効にし、接続に必要な設定を行います）。

2. PostgreSQL データベースとユーザーの作成
google_sql_database リソースでデータベースを作成し、google_sql_user でデータベースユーザーを設定します。

3. Cloud Run サービスの作成
Cloud Run サービスを作成し、Next.js アプリケーションのコンテナを指定します。環境変数として、Cloud SQL インスタンスの接続名 (DB_HOST) やデータベースの設定 (DB_USER, DB_PASSWORD, DB_NAME) を設定します。

4. Cloud Run に対する IAM 設定
google_cloud_run_service_iam_member リソースで roles/run.invoker の権限を付与し、allUsers に対してアクセスを許可します。

### nextjsの変更

1. 必要なライブラリのインストール
まず、TypeScript を使うために、pg ライブラリと TypeScript の型定義をインストールします。

```bash
npm install pg
npm install --save-dev @types/pg
```

### デプロイ
1. dockerイメージのビルドとプッシュ
```bash
cd my-next-app
docker build -t gcr.io/${var.project_id}/nextjs-app .
docker push gcr.io/${var.project_id}/nextjs-app
```

2. terraformの適用
```bash
terraform init
terraform apply
```

db isntanceを立ち上げるのに13分

## Load Balancer + Cloud Runをデプロイする
https://zenn.dev/ring_belle/articles/gcp-iap-cloudrun

## Load Balancer + Cloud Run + Cloud SQLをデプロイする
**Cloud Run + Cloud SQLをデプロイする**でデプロイした構成の前段にLoad Balancerを設置する。

### IAPをLoad Balancerに連携する