# R与(R)Markdown基础

[![Quarto](https://img.shields.io/badge/Made%20with-Quarto-blue)](https://quarto.org/)
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](license.qmd)

> 中南大学生物医学信息系 · 本科课程

## 课程简介

本课程面向生物医学信息学专业大二本科生，系统讲授 **R语言基础语法** 与 **(R)Markdown文档编写** 技术。通过"2学时理论讲授 + 2学时实验操作"的紧凑安排，帮助学生掌握R编程核心技能与可重复性研究报告撰写能力。

## 课程目标

- ✅ 掌握R语言核心编程技能（数据类型、控制流、函数）
- ✅ 熟悉tidyverse生态（dplyr、ggplot2）
- ✅ 学会使用R Markdown/Quarto撰写专业报告
- ✅ 建立可重复性研究的基本意识

## 课程结构

```
├── 理论讲授 (2学时)
│   ├── 第1讲：R语言基础
│   ├── 第2讲：数据处理与可视化
│   ├── 第3讲：R Markdown基础
│   └── 第4讲：现代报告工具
│
└── 实验操作 (2学时)
    ├── 实验1：R基础编程 (60分钟)
    └── 实验2：R Markdown报告编写 (60分钟)
```

## 访问课程网站

课程网站使用 Quarto 构建，包含完整的教学资源：

- 📋 [课程大纲](syllabus.qmd)
- 📊 [幻灯片：R基础](slides/slides-r-basics.qmd)
- 📊 [幻灯片：R Markdown](slides/slides-rmarkdown.qmd)
- 🧪 [实验1：R基础](labs/lab1-r-basics.qmd)
- 🧪 [实验2：R Markdown](labs/lab2-rmarkdown.qmd)
- 📚 [拓展资源](resources.qmd)

## 本地构建

### 环境要求

- [R](https://www.r-project.org/) >= 4.3.0
- [RStudio](https://posit.co/download/rstudio-desktop/) >= 2023.06
- [Quarto](https://quarto.org/docs/get-started/) >= 1.3

### 构建步骤

```bash
# 克隆仓库
git clone https://github.com/csu-bmi/rmarkdown-fundamentals.git
cd rmarkdown-fundamentals

# 渲染整个网站
quarto render

# 或者预览开发服务器
quarto preview
```

构建完成后，网站文件位于 `_site/` 目录。

## 项目结构

```
rmarkdown-fundamentals/
├── _quarto.yml           # 项目配置
├── index.qmd             # 课程主页
├── syllabus.qmd          # 课程大纲
├── resources.qmd         # 拓展资源
├── license.qmd           # 许可证
├── references.bib        # 参考文献
│
├── styles/               # 自定义样式
│   ├── custom.scss
│   ├── custom-dark.scss
│   ├── slides.scss
│   └── styles.css
│
├── lectures/             # 讲座笔记
│   ├── lecture1-r-basics.qmd
│   ├── lecture2-data-viz.qmd
│   ├── lecture3-rmarkdown.qmd
│   └── lecture4-quarto.qmd
│
├── slides/               # 交互式幻灯片
│   ├── slides-r-basics.qmd
│   └── slides-rmarkdown.qmd
│
├── labs/                 # 实验手册
│   ├── lab1-r-basics.qmd
│   └── lab2-rmarkdown.qmd
│
└── data/                 # 示例数据
    ├── sample_clinical.csv
    └── gene_expression.csv
```

## 课程特色

- 🎯 **面向实战**：所有内容紧密结合生物医学研究场景
- 🔗 **前后衔接**：为后续《转录组分析》《基因组突变分析》等课程奠定基础
- 📚 **资源丰富**：提供完整的幻灯片、实验指导、示例代码、拓展阅读
- 🚀 **现代工具**：基于 Quarto 构建，支持多格式输出

## 后续课程

本课程是生物医学信息学专业课程体系的基础模块，后续可衔接：

| 课程 | 内容 |
|------|------|
| 转录组数据分析 | RNA-seq数据处理、差异表达分析 |
| 基因组突变分析 | 突变检测、注释与可视化 |
| 生物信息学算法 | R实现生物信息学算法 |
| 系统生物学 | 网络分析与建模 |

## 授课教师

**王诗翔 副教授**

- 单位：中南大学生物医学信息系
- 研究方向：生物信息学、计算生物学、多组学数据分析
- 邮箱：shixiang.wang@csu.edu.cn
- GitHub：[@ShixiangWang](https://github.com/ShixiangWang)

## 许可证

本课程材料采用双许可：

- **内容**：知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议 (CC BY-NC-SA 4.0)
- **代码**：MIT License

详见 [license.qmd](license.qmd)

## 致谢

本课程开发参考了以下优秀资源：

- [R for Data Science](https://r4ds.had.co.nz/) by Hadley Wickham & Garrett Grolemund
- [R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/) by Yihui Xie et al.
- [Quarto Documentation](https://quarto.org/docs/) by Posit

---

<p align="center">
  <strong>中南大学生物医学信息系</strong><br>
  <em>School of Biomedical Informatics, Central South University</em>
</p>
