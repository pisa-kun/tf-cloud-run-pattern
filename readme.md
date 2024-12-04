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

## Load Balancer + Cloud Run + Cloud SQLをデプロイする
**Cloud Run + Cloud SQLをデプロイする**でデプロイした構成の前段にLoad Balancerを設置する。