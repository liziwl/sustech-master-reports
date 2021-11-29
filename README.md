# sustech-master-reports

[![Actions Status](https://github.com/liziwl/sustech-master-reports/actions/workflows/verify-compile.yml/badge.svg)](https://github.com/liziwl/sustech-master-reports/actions/workflows/verify-compile.yml)
[![GitHub pre-release](https://img.shields.io/github/v/release/liziwl/sustech-master-reports?include_prereleases&label=%E5%BC%80%E5%8F%91%E7%89%88-%E9%A2%84%E6%9E%84%E5%BB%BA)](https://github.com/liziwl/sustech-master-reports/releases/tag/dev-latest)

南方科技大学硕士开题报告、年度考核报告 （中/英）

Thanks [Peng-YM](https://github.com/Peng-YM) for adapting the English template as required.

本模板仅验证了硕士研究生的模板与官方一致，博士研究生的选项尚无验证。

## 下载
### 新版
该版本进行了大幅度修改，使用时请注意备份旧版文件，再更新。
- **[开发版-预构建（点此）](https://github.com/liziwl/sustech-master-reports/releases/tag/dev-latest)**

### 旧版
大版本升级前的最后版本，包含2021年开题报告的修改。
- **[v0.1.0（点此）](https://github.com/liziwl/sustech-master-reports/releases/tag/v0.1.0)**

## 升级

旧版不再维护，需将内容迁移至新版使用。新版大部分更新仅需替换 `sustech-gs-report.cls` 和 `config.tex` 文件。

## 模版架构

- `main-example.tex`：定义文档结构：中英文设置，开题/考核报告选项
- `config.tex`：定义一些封面的元数据，作者，标题，等
- `sustech-gs-report.cls`：定义模板样式

## 编译环境

* XeLaTeX
  * 通过 Overleaf 和 Windows / Mac 下编译

## Windows 使用

* 使用 `make.bat` + `clean.bat` 调用 `latexmk` 命令
* 直接使用 `latexmk` 命令

## Unix 使用

* 安装微软字体 (Times New Roman等字体)
  * Arch：安装 `yay -S ttf-ms-fonts`
  * Ubuntu / Debian：`sudo apt install ttf-mscorefonts-installer`
* Makefile