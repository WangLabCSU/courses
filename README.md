# 中南大学 - 生物信息学课程仓库

[![Quarto](https://img.shields.io/badge/Built%20with-Quarto-blue)](https://quarto.org/)
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](LICENSE)
[![Deploy](https://github.com/WangLabCSU/courses/actions/workflows/deploy.yml/badge.svg)](https://github.com/WangLabCSU/courses/actions/workflows/deploy.yml)

> 本仓库用于存放王诗翔副教授在中南大学生物信息学专业的课程材料。

🌐 **在线访问**: https://wanglabcsu.github.io/courses/

## 授课教师

<table>
<tr>
<td width="120">
<img src="http://biotree.top:38123/wsx.jpeg" width="100" style="border-radius: 50%;" alt="王诗翔">
</td>
<td>

**王诗翔 副教授**

- 单位：中南大学 · Department of Biomedical Informatics
- 研究方向：生物信息学、计算生物学、多组学数据分析
- 邮箱：wangshx@csu.edu.cn
- 实验室主页：https://wanglabcsu.github.io/
- GitHub：[@WangLabCSU](https://github.com/WangLabCSU)

</td>
</tr>
</table>

## 📚 课程列表

| 课程 | 学时 | 对象 | 链接 |
|------|:----:|------|------|
| **R与(R)Markdown基础** | 4学时 | 大二本科 | [进入课程](r-and-rmarkdown/) |

## 🚀 快速开始

### 在线访问

课程网站使用 **GitHub Pages** 自动部署：

🔗 **https://wanglabcsu.github.io/courses/**

### 本地构建

#### 环境要求

- [R](https://www.r-project.org/) >= 4.3.0
- [RStudio](https://posit.co/download/rstudio-desktop/) >= 2023.06
- [Quarto](https://quarto.org/docs/get-started/) >= 1.4

#### 一键构建

```bash
# 克隆仓库
git clone https://github.com/WangLabCSU/courses.git
cd courses

# 使用构建脚本（构建根目录+所有课程）
./build.sh

# 预览
cd _site && python3 -m http.server 8000
```

#### 手动构建

```bash
# 1. 构建根目录
quarto render index.qmd

# 2. 构建各个课程
cd r-and-rmarkdown && quarto render && cd ..

# 3. 组织输出（复制到_site目录）
mkdir -p _site
cp index.html _site/
cp -r r-and-rmarkdown/_site _site/r-and-rmarkdown
```

## 📁 仓库结构

```
courses/                       # Git根目录（可直接部署）
├── _quarto.yml               # 根目录站点配置
├── index.qmd                 # 课程总览主页
├── license.qmd               # 许可证
├── build.sh                  # 本地构建脚本
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actions自动部署
├── styles/                   # 共享样式
├── logo/                     # 共享资源
│
├── r-and-rmarkdown/          # 课程1：R与R Markdown
│   ├── _quarto.yml          # 课程配置
│   ├── index.qmd            # 课程主页
│   ├── slides/              # 幻灯片
│   ├── labs/                # 实验手册
│   └── ...
│
└── [future-courses]/        # 未来课程（转录组、基因组等）
    └── ...
```

## 🎯 开发计划

- [x] R与(R)Markdown基础（4学时）
- [ ] 转录组数据分析（规划）
- [ ] 基因组突变分析（规划）
- [ ] 生物信息学算法（规划）

## 🌐 部署说明

### GitHub Actions 自动部署

仓库已配置 `.github/workflows/deploy.yml`，推送代码后自动：

1. 构建根目录网站（课程总览）
2. 构建所有子课程
3. 合并输出到 `_site/` 目录
4. 部署到 GitHub Pages

### 服务器独立部署

直接复制 `_site/` 目录到服务器即可：

```bash
# 本地构建
./build.sh

# 复制到服务器
scp -r _site/* user@server:/var/www/html/courses/

# 或使用 rsync
rsync -avz _site/ user@server:/var/www/html/courses/
```

### 机房离线使用

```bash
# 复制整个 _site 目录到学生机
# 学生用浏览器打开 index.html 即可
```

所有链接使用相对路径，**可完全离线使用**。

## 🤝 参与贡献

欢迎提交 Issue 和 Pull Request 来改进课程内容！

### AI协作规范

本仓库使用AI助手协助维护，规范详见 [AGENTS.md](AGENTS.md)。

### 添加新课程

1. 创建课程目录：`mkdir new-course`
2. 复制 `_quarto.yml` 模板并修改
3. 创建 `index.qmd`, `syllabus.qmd` 等
4. 在根目录 `index.qmd` 中添加课程卡片
5. 更新 `build.sh` 中的课程列表

## 📄 许可证

本仓库内容采用双许可：

- **教学内容**：知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议 ([CC BY-NC-SA 4.0](LICENSE))
- **示例代码**：MIT License

---

<p align="center">
  <strong>中南大学 · Department of Biomedical Informatics</strong><br>
  <em>Central South University</em>
</p>

<p align="center">
  <a href="https://wanglabcsu.github.io/">实验室主页</a> • 
  <a href="https://github.com/WangLabCSU">GitHub</a> • 
  <a href="mailto:wangshx@csu.edu.cn">联系教师</a>
</p>
