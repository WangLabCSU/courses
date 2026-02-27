# 独立部署说明

本文档说明如何将课程网站独立部署到服务器或本地机房。

## 部署方式

### 方式1：直接复制已构建的站点（推荐）

我们已经为您构建了完整的静态站点，位于 `dist/` 目录：

```bash
# 复制 dist 目录到服务器
cp -r dist/ /path/to/webserver/r-and-rmarkdown/

# 或者使用 scp
scp -r dist/ user@server:/var/www/html/r-and-rmarkdown/
```

### 方式2：自行构建

```bash
# 进入课程目录
cd r-and-rmarkdown

# 渲染网站
quarto render

# 复制 _site 目录到服务器
cp -r _site/ /path/to/webserver/r-and-rmarkdown/
```

## 目录结构

部署后的目录结构：

```
r-and-rmarkdown/          # 网站根目录
├── index.html           # 课程主页
├── logo.png            # 课程logo
├── data/               # 示例数据
│   ├── sample_clinical.csv
│   ├── gene_expression.csv
│   └── samples/        # 挑战题数据
├── slides/             # 幻灯片
│   ├── slides-r-basics.html
│   └── slides-rmarkdown.html
├── labs/               # 实验手册
├── lectures/           # 讲座笔记
├── styles/             # 样式文件
└── site_libs/          # 依赖库
```

## Web服务器配置

### Nginx

```nginx
server {
    listen 80;
    server_name courses.example.com;
    root /var/www/html/r-and-rmarkdown;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    # 启用gzip压缩
    gzip on;
    gzip_types text/css application/javascript application/json;
}
```

### Apache

```apache
<VirtualHost *:80>
    ServerName courses.example.com
    DocumentRoot /var/www/html/r-and-rmarkdown
    
    <Directory /var/www/html/r-and-rmarkdown>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

### Python 简单服务器（测试用）

```bash
cd r-and-rmarkdown
python3 -m http.server 8000
# 访问 http://localhost:8000
```

## 离线使用（机房环境）

如果学生机没有网络连接：

1. **复制完整目录**到学生机
2. **使用浏览器直接打开** `index.html`
3. 所有资源都是相对路径，无需网络

### 注意事项

- ✅ 所有链接使用相对路径（`./slides/` 而非 `https://...`）
- ✅ 所有资源（CSS、JS、图片）都包含在目录中
- ✅ 示例数据在 `data/` 目录中
- ❌ 外部链接（如GitHub、在线文档）需要网络

## 验证部署

部署后检查以下链接：

- [ ] 主页：http://your-server/r-and-rmarkdown/
- [ ] 幻灯片：http://your-server/r-and-rmarkdown/slides/slides-r-basics.html
- [ ] 实验手册：http://your-server/r-and-rmarkdown/labs/lab1-r-basics.html
- [ ] 示例数据：http://your-server/r-and-rmarkdown/data/sample_clinical.csv

## 更新内容

更新课程时：

1. 修改源文件（`.qmd`）
2. 重新渲染：`quarto render`
3. 复制新的 `_site/` 到服务器
4. 或者复制 `dist/` 目录

## 技术支持

- 邮箱：wangshx@csu.edu.cn
- GitHub：https://github.com/WangLabCSU/courses
