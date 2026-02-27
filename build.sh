#!/bin/bash

# 本地构建脚本
# 模拟GitHub Actions的构建流程

set -e

echo "=========================================="
echo "构建 CSU 生物信息学课程网站"
echo "=========================================="

# 清理旧的构建
echo "清理旧构建..."
rm -rf _site

# 渲染根目录
echo ""
echo "1. 渲染根目录网站..."
quarto render index.qmd

# 渲染各个课程
echo ""
echo "2. 渲染课程..."
for course in r-and-rmarkdown; do
  if [ -d "$course" ] && [ -f "$course/_quarto.yml" ]; then
    echo "   构建课程: $course"
    cd "$course"
    quarto render
    cd ..
  fi
done

# 组织构建输出
echo ""
echo "3. 组织构建输出..."
mkdir -p _site

# 复制根目录文件
if [ -f "index.html" ]; then
  cp index.html _site/
fi

for file in license.html resources.html syllabus.html robots.txt sitemap.xml search.json; do
  if [ -f "$file" ]; then
    cp "$file" _site/
  fi
done

# 复制资源目录
for dir in site_libs styles logo; do
  if [ -d "$dir" ]; then
    cp -r "$dir" _site/
  fi
done

# 复制课程
for course in r-and-rmarkdown; do
  if [ -d "$course/_site" ]; then
    echo "   复制课程: $course"
    mkdir -p "_site/$course"
    cp -r "$course/_site"/* "_site/$course/"
    if [ -f "logo/csu_logo.png" ]; then
      cp "logo/csu_logo.png" "_site/$course/"
    fi
  fi
done

echo ""
echo "=========================================="
echo "构建完成!"
echo "=========================================="
echo ""
echo "网站结构:"
ls -la _site/
echo ""
echo "预览命令:"
echo "  cd _site && python3 -m http.server 8000"
echo ""
