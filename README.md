# sustech-master-reports

南方科技大学硕士开题报告、年度考核报告 （中/英）

Thanks [Peng-YM](https://github.com/Peng-YM) for adapting the English template as required.

本模板仅验证了硕士研究生的模板与官方一致，博士研究生的选项尚无验证。

## 预览

[预览 中文模板 PDF](./main-cn.pdf)

[View English template](./main-en.pdf)

## 模版架构

- `main.tex`：定义文档结构：中英文设置，开题/考核报告选项
- `cover.tex`：定义一些封面的元数据，作者，标题，等
- `format.tex`：定义样式

## 编译环境

* xelatex
  * 通过 overleaf 和 Windows 下编译

## Windows 使用

* `make.bat` + `clean.bat`

## Unix 使用

* Arch 发行版安装 `ttf-ms-fonts` (Times New Roman等字体) 、Ubuntu 上请自行搜索
* Makefile