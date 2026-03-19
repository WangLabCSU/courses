#!/bin/bash

# 本地构建脚本
# 模拟GitHub Actions的构建流程

set -e

echo "=========================================="
echo "构建 CSU 生物信息学课程网站"
echo "=========================================="

# 自动发现所有课程目录（包含 _quarto.yml 的子目录）
# 排除隐藏目录和 site_libs、styles、logo 等特殊目录
discover_courses() {
    for dir in */; do
        # 移除末尾的斜杠
        dir_name="${dir%/}"
        # 检查是否是课程目录（包含 _quarto.yml）
        if [ -f "$dir_name/_quarto.yml" ]; then
            echo "$dir_name"
        fi
    done
}

# 清理旧的构建
echo ""
echo "清理旧构建..."
rm -rf _site

# 渲染根目录
echo ""
echo "1. 渲染根目录网站..."
quarto render

# 发现并渲染各个课程
echo ""
echo "2. 发现课程目录..."
COURSES=$(discover_courses)

if [ -z "$COURSES" ]; then
    echo "   未发现课程目录"
else
    echo "   发现课程: $COURSES"
    
    for course in $COURSES; do
        echo ""
        echo "   构建课程: $course"
        cd "$course"
        rm -rf _site
        quarto render
        cd ..
    done
fi

# 组织构建输出
echo ""
echo "3. 组织构建输出..."
mkdir -p _site

# 复制根目录文件（自动发现并复制所有生成的 HTML 文件）
echo "   复制根目录文件..."
for file in *.html; do
    if [ -f "$file" ]; then
        cp "$file" _site/
        echo "     - $file"
    fi
done

# 复制根目录资源目录
for dir in site_libs styles logo; do
    if [ -d "$dir" ]; then
        cp -r "$dir" _site/
    fi
done

# 复制各个课程（使用自动发现的课程列表）
for course in $COURSES; do
    if [ -d "$course/_site" ]; then
        echo "   复制课程: $course"
        mkdir -p "_site/$course"
        cp -r "$course/_site"/* "_site/$course/"
        # 复制 logo 到课程目录（用于修复相对路径问题）
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
find _site -maxdepth 2 -type d | sed 's|_site/|  |; s|_site|  [root]|'
echo ""
echo "预览命令:"
echo "  cd _site && python3 -m http.server 8000"
echo ""
