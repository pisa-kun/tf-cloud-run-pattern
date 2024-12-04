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

## Cloud Run + Cloud SQLをデプロイする
Cloud Run上にNextjsのサンプルアプリをデプロイしてCloud SQL上のPostgreSQL DBと簡単な疎通を実施する。

## Load Balancer + Cloud Run + Cloud SQLをデプロイする
**Cloud Run + Cloud SQLをデプロイする**でデプロイした構成の前段にLoad Balancerを設置する。