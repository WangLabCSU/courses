# CSU生物信息学课程仓库 - AI协作规范

> 本文档规范AI助手在协助维护本课程仓库时的行为准则和技术标准。

## 1. 仓库结构规范

### 1.1 目录层级

```
courses/                          # Git根目录
├── AGENTS.md                     # 本文件
├── README.md                     # 仓库主页
├── LICENSE                       # 许可证
├── .gitignore                    # Git忽略规则
├── .github/                      # GitHub配置
│   └── workflows/                # Actions工作流
│       └── deploy.yml
├── logo/                         # 共享资源
│   └── csu_logo.png              # 中南大学logo
│
└── [course-name]/                # 课程子目录（小写+连字符）
    ├── _quarto.yml               # 课程配置
    ├── index.qmd                 # 课程主页
    ├── syllabus.qmd              # 课程大纲
    ├── resources.qmd             # 拓展资源
    ├── license.qmd               # 课程许可证
    ├── references.bib            # 参考文献
    ├── README.md                 # 课程README
    │
    ├── styles/                   # 自定义样式
    │   ├── custom.scss
    │   ├── custom-dark.scss
    │   ├── slides.scss
    │   └── styles.css
    │
    ├── lectures/                 # 讲座笔记
    │   └── lecture[0-9]*.qmd
    │
    ├── labs/                     # 实验手册
    │   └── lab[0-9]*.qmd
    │
    ├── slides/                   # 幻灯片
    │   └── slides-*.qmd
    │
    ├── data/                     # 示例数据
    │   └── *.csv
    │
    └── _site/                    # 构建输出（Git忽略）
```

### 1.2 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 课程目录 | 小写，连字符分隔 | `r-and-rmarkdown/`, `transcriptomics/` |
| Quarto文件 | 小写，连字符分隔 | `index.qmd`, `lab1-r-basics.qmd` |
| 幻灯片 | `slides-`前缀 | `slides-r-basics.qmd` |
| 实验手册 | `lab`+数字前缀 | `lab1-r-basics.qmd` |
| 讲座笔记 | `lecture`+数字前缀 | `lecture1-r-basics.qmd` |
| 数据文件 | 小写，下划线分隔 | `gene_expression.csv` |

## 2. 内容规范

### 2.1 课程信息标准

所有课程必须包含以下标准化信息：

```yaml
# 必填信息
课程名称: "XXX基础"
英文名称: "XXX Fundamentals"
授课对象: "生物医学信息系 本科生/研究生"
授课教师: "王诗翔 副教授"
开课单位: "中南大学"

# 学时规范（总学时为4的倍数）
理论学时: 2
实验学时: 2
总学时: 4

# 联系方式（固定格式）
邮箱: wangshx@csu.edu.cn
实验室: https://wanglabcsu.github.io/
GitHub: https://github.com/WangLabCSU
```

### 2.2 禁止内容

- ❌ 课程代码（如 BMI2XXX）
- ❌ 学分信息
- ❌ 具体考核方式和分值比例
- ❌ 个人手机号或私人邮箱
- ❌ 内部教学系统链接

### 2.3 必须内容

- ✅ 课程目标（知识、能力、素质三维度）
- ✅ 详细的教学内容和安排
- ✅ 实验手册包含完整参考答案
- ✅ 参考文献和拓展资源
- ✅ 学术诚信声明

## 3. 技术规范

### 3.1 Quarto配置标准

```yaml
# _quarto.yml 标准配置
project:
  type: website
  output-dir: _site

website:
  title: "课程名称"
  site-url: https://wanglabcsu.github.io/courses/[course-name]
  repo-url: https://github.com/WangLabCSU/courses
  
  navbar:
    left:
      - href: index.qmd
        text: 首页
      - href: syllabus.qmd
        text: 课程大纲
      # 幻灯片必须使用 .html 链接
      - text: 幻灯片
        menu:
          - href: slides/slides-xxx.html
            text: "幻灯片名称"

format:
  html:
    theme:
      light: [cosmo, styles/custom.scss]
      dark: [darkly, styles/custom-dark.scss]
    css: styles/styles.css
    toc: true
    code-copy: true
```

### 3.2 幻灯片配置标准

```yaml
# 幻灯片YAML头部
format:
  revealjs:
    theme: [default, ../styles/slides.scss]
    slide-number: true
    chalkboard: true
    logo: ../../logo/csu_logo.png    # 统一使用根目录logo
    footer: "课程名称 | 中南大学"
```

### 3.3 代码块规范

实验手册中的代码块必须使用可执行的R代码：

````markdown
```{r}
#| eval: true
#| echo: true

# 完整的、可运行的代码
result <- mean(c(1, 2, 3, 4, 5))
print(result)
```
````

参考答案使用 `<details>` 标签包裹：

```markdown
<details>
<summary>点击查看参考答案</summary>

```{r}
# 参考答案代码
```
</details>
```

## 4. 样式规范

### 4.1 颜色系统

使用中南大学标准色：

```scss
// styles/custom.scss
$csu-red: #8B0000;      // 主色：中南红
$csu-gold: #C5B358;     // 辅色
$dark-blue: #1a5276;    // 强调色
```

### 4.2 教师信息展示

使用统一的教师信息卡片：

```markdown
::: {.instructor-card}
::: {.instructor-avatar style="width: 100px; height: 100px; overflow: hidden; padding: 0;"}
![](logo/wsx.jpeg){style="width: 100%; height: 100%; object-fit: cover;"}
:::
::: {.instructor-info}
### 王诗翔 副教授

**中南大学 · 生物医学信息系**

研究方向：生物信息学、计算生物学、多组学数据分析

🌐 [实验室主页](https://wanglabcsu.github.io/)  
📧 wangshx@csu.edu.cn  
🐙 [WangLabCSU](https://github.com/WangLabCSU)
:::
:::
```

## 5. 链接检查清单

发布前必须验证以下链接：

- [ ] 所有幻灯片链接指向 `.html` 而非 `.qmd`
- [ ] 实验室主页 https://wanglabcsu.github.io/
- [ ] GitHub组织 https://github.com/WangLabCSU
- [ ] 邮箱链接 wangshx@csu.edu.cn
- [ ] 外部资源链接（R文档、Quarto等）
- [ ] 课程间交叉引用链接

## 6. 新增课程流程

AI协助创建新课程时，按以下步骤执行：

1. **创建目录结构**
   ```bash
   mkdir -p [course-name]/{styles,lectures,labs,slides,data}
   ```

2. **复制模板文件**
   - `_quarto.yml`（修改课程特定信息）
   - `styles/`（直接复制）
   - `index.qmd`（修改课程信息）
   - `syllabus.qmd`（修改课程大纲）
   - `resources.qmd`（修改资源列表）
   - `license.qmd`（直接复制）

3. **创建内容**
   - 讲座笔记（4个文件）
   - 实验手册（2个，含完整答案）
   - 幻灯片（2个）
   - 示例数据

4. **验证清单**
   - [ ] 所有页面能正确渲染
   - [ ] 幻灯片链接指向HTML
   - [ ] 教师信息完整
   - [ ] 实验室和GitHub链接正确
   - [ ] 代码可执行

5. **更新根README**
   在课程列表中添加新课程

## 8. 常见问题处理

### Q1: 幻灯片logo不显示

确保路径正确：`logo: ../../logo/csu_logo.png`

### Q2: 中文显示乱码

在YAML中添加：
```yaml
lang: zh
```

### Q3: 代码执行错误

检查：
- R包是否已安装
- 数据文件路径是否正确
- 代码块选项 `eval: true`

### Q4: 链接404

- 网站内链接使用相对路径
- 幻灯片链接使用 `.html` 后缀
- 外部链接使用完整URL

## 9. 联系信息

- **维护者**：王诗翔 副教授
- **邮箱**：wangshx@csu.edu.cn
- **实验室**：https://wanglabcsu.github.io/
- **GitHub**：https://github.com/WangLabCSU

---

*本文档版本：v1.0*  
*最后更新：2025年2月*
