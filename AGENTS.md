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

#### 可执行代码块

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

#### 示例代码块（不执行）

当需要展示代码块语法本身时（如教程、幻灯片中展示R Markdown语法），使用以下技巧：

**方法：4个反引号 + `{{r}}` 双大括号语法**

````markdown
````markdown
```{{r chunk-name, echo=TRUE}}
# 这段代码不会被实际执行
# 仅作为语法示例展示
x <- 1:10
mean(x)
```
````
````

**原理说明**：

1. **4个反引号**（````）用于包裹整个示例块，比内部代码块多一个反引号
2. **`{{r}}` 双大括号**：Quarto会将 `{{r}}` 转换为 `{r}` 进行渲染，但不会解析执行
3. 这样示例代码块只会被语法高亮显示，不会被实际运行

**适用场景**：
- 讲座笔记中展示R Markdown/Quarto语法
- 幻灯片中演示代码块选项
- 教程文档中说明代码块写法

**R Markdown vs Quarto 语法区分**：

在介绍R Markdown时，应使用R Markdown传统语法：
````markdown
````markdown
```{{r chunk-name, echo=TRUE, eval=TRUE}}
# R代码
```
````
````

在介绍Quarto时，才使用Quarto风格的 `#|` 语法：
````markdown
````markdown
```{{r}}
#| label: chunk-name
#| echo: true
#| eval: true

# R代码
```
````
````

#### 参考答案格式

参考答案使用 `<details>` 标签包裹：

````markdown
<details>
<summary>点击查看参考答案</summary>

```{r}
# 参考答案代码
```
</details>
````

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

## 5. 链接规范与检查清单

### 5.1 链接使用规则

由于采用**多项目独立构建**架构，链接使用需遵循以下规则：

#### 根目录 `_quarto.yml` 中的链接
```yaml
# ✅ 正确：指向子课程必须使用 .html 后缀
- href: r-and-rmarkdown/index.html
  text: "R与(R)Markdown基础"

# ❌ 错误：不要使用 .qmd 后缀
# - href: r-and-rmarkdown/index.qmd  # 这会导致下载源文件！
```

**原因**：根目录排除了子目录渲染 (`- "!*/**"`)，Quarto 不会自动转换 `.qmd` 链接为 `.html`。

#### 根目录内容文件（如 `index.qmd`）中的链接
```markdown
# ✅ 正确：指向子课程使用 .html
[进入课程](r-and-rmarkdown/index.html)

# ✅ 正确：根目录内部链接可以使用 .qmd（Quarto会自动转换）
[学习资源](learning-resources.qmd)

# ❌ 错误：不要使用 .qmd 指向子课程
# [进入课程](r-and-rmarkdown/index.qmd)  # 会导致下载源文件！
```

#### 子课程内部的链接
```markdown
# ✅ 正确：子课程内部链接可以使用 .qmd（Quarto会自动转换）
[课程大纲](syllabus.qmd)
[实验1](labs/lab1-r-basics.qmd)

# ✅ 正确：指向根目录使用 .html
[返回首页](../index.html)
[学习资源](../learning-resources.html)

# ✅ 正确：图片路径
![](../logo/wsx.jpeg)
```

#### 子课程 `_quarto.yml` 中的链接
```yaml
# ✅ 正确：指向根目录使用 .html
- href: ../index.html
  text: "← 返回课程主页"
- href: ../learning-resources.html
  text: 学习资源

# ✅ 正确：子课程内部使用 .qmd（Quarto会自动转换）
- href: syllabus.qmd
  text: 课程大纲
- href: labs/lab1-r-basics.qmd
  text: 实验1
```

### 5.2 链接检查清单

发布前必须验证以下链接：

- [ ] **根目录到子课程**：所有链接使用 `.html` 后缀
- [ ] **子课程到根目录**：所有链接使用 `.html` 后缀
- [ ] **子课程内部**：可以使用 `.qmd`（Quarto 会自动转换）
- [ ] **幻灯片链接**：指向 `.html` 而非 `.qmd`
- [ ] **实验室主页**：https://wanglabcsu.github.io/
- [ ] **GitHub组织**：https://github.com/WangLabCSU
- [ ] **邮箱链接**：wangshx@csu.edu.cn
- [ ] **外部资源链接**（R文档、Quarto等）
- [ ] **课程间交叉引用链接**

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

### 6.1 构建架构说明

本仓库采用**多项目独立构建**架构：

#### 根目录 `_quarto.yml` 关键配置
```yaml
project:
  type: website
  output-dir: _site
  render:
    - "*.qmd"
    # 排除子课程目录（它们有独立的_quarto.yml，需要单独构建）
    - "!*/**"
```

**重要**：`- "!*/**"` 配置确保根目录的 `quarto render` **不会**递归渲染子目录，避免：
- 子课程被根目录配置重复渲染（导致菜单栏不完整）
- 二次渲染问题

#### 构建流程
1. 根目录执行 `quarto render` → 仅构建根目录的 `.qmd` 文件
2. 每个子课程目录独立执行 `quarto render` → 使用各自的 `_quarto.yml` 配置
3. `build.sh` 自动发现并构建所有课程（见下文）

#### build.sh 自动发现机制
```bash
# 自动发现所有包含 _quarto.yml 的子目录
discover_courses() {
    for dir in */; do
        dir_name="${dir%/}"
        if [ -f "$dir_name/_quarto.yml" ]; then
            echo "$dir_name"
        fi
    done
}
```

**新增课程时无需修改 build.sh**，只需确保课程目录包含 `_quarto.yml` 文件。

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

### Q5: 子课程菜单栏显示不完整

**原因**：根目录的 `quarto render` 默认会递归渲染子目录，使用根目录的配置覆盖子课程配置。

**解决方案**：已在根目录 `_quarto.yml` 中配置 `- "!*/**"` 排除子目录。如果问题仍存在，检查：
- 子目录是否有 `_quarto.yml` 文件
- 是否使用了 `build.sh` 或 GitHub Actions 进行构建

### Q6: 构建时文件被渲染两次

**原因**：根目录 `quarto render` 递归处理了子课程文件，然后 `build.sh` 又单独构建了子课程。

**解决方案**：确保根目录 `_quarto.yml` 包含排除规则：
```yaml
render:
  - "*.qmd"
  - "!*/**"  # 排除所有子目录
```

### Q7: 新增课程后 build.sh 需要更新

**解决方案**：新版 `build.sh` 已支持自动发现课程。只需确保新课程目录包含 `_quarto.yml` 文件即可，无需修改构建脚本。

### Q8: 点击子课程链接时下载 .qmd 文件而不是打开网页

**原因**：根目录链接指向了 `.qmd` 文件而非 `.html`。由于根目录排除了子目录渲染，Quarto 不会自动转换链接。

**示例**：
```yaml
# ❌ 错误 - 会导致下载 r-and-rmarkdown/index.qmd
- href: r-and-rmarkdown/index.qmd

# ✅ 正确 - 正常打开网页
- href: r-and-rmarkdown/index.html
```

**解决方案**：
1. 检查根目录 `_quarto.yml` 中的子课程链接，确保使用 `.html` 后缀
2. 检查根目录 `index.qmd` 中的子课程链接，确保使用 `.html` 后缀
3. 参见 [5.1 链接使用规则](#51-链接使用规则)

## 9. 联系信息

- **维护者**：王诗翔 副教授
- **邮箱**：wangshx@csu.edu.cn
- **实验室**：https://wanglabcsu.github.io/
- **GitHub**：https://github.com/WangLabCSU

---

*本文档版本：v1.0*  
*最后更新：2025年2月*
