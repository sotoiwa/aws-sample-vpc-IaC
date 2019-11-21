# プロバイダー
provider "aws" {
  region = "ap-northeast-1"
}

# VPCの定義
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-tf"
  }
}

# VPCにインターネットゲートウェイをアタッチ
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-tf"
  }
}

# AZを取得
data "aws_availability_zones" "all" {}

# パブリックサブネットその1
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.all.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-1-tf"
  }
}

# パブリックサブネットその2
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.all.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-2-tf"
  }
}

# プライベートサブネットその1
resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = data.aws_availability_zones.all.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-1-tf"
  }
}

# プライベートサブネットその2
resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = data.aws_availability_zones.all.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private-2-tf"
  }
}

# NATゲートウェイ用のEIPその1
resource "aws_eip" "eip_1" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

# NATゲートウェイ用のEIPその2
resource "aws_eip" "eip_2" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

# NATゲートウェイその1
resource "aws_nat_gateway" "ngw_1" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.public_1.id
  depends_on    = ["aws_internet_gateway.igw"]
}

# NATゲートウェイその2
resource "aws_nat_gateway" "ngw_2" {
  allocation_id = aws_eip.eip_2.id
  subnet_id     = aws_subnet.public_2.id
  depends_on    = ["aws_internet_gateway.igw"]
}

# パブリックサブネット共通のルートテーブル
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "public-tf"
  }
}

# パブリックサブネットとルートテーブルの関連づけ
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# パブリックサブネットとルートテーブルの関連づけ
resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# インターネットゲートウェイへのルーティング
resource "aws_route" public {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# プライベートサブネットその1用のルートテーブル
resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-1-tf"
  }
}

# プライベートサブネットその2用のルートテーブル
resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-2-tf"
  }
}

# プライベートサブネットとルートテーブルの関連づけ
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

# プライベートサブネットとルートテーブルの関連づけ
resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}

# NATゲートウェイへのルーティング
resource "aws_route" private_1 {
  route_table_id         = aws_route_table.private_1.id
  nat_gateway_id         = aws_nat_gateway.ngw_1.id
  destination_cidr_block = "0.0.0.0/0"
}

# NATゲートウェイへのルーティング
resource "aws_route" private_2 {
  route_table_id         = aws_route_table.private_2.id
  nat_gateway_id         = aws_nat_gateway.ngw_2.id
  destination_cidr_block = "0.0.0.0/0"
}
