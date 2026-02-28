#!/bin/bash
# 本地构建脚本

set -e

echo "=========================================="
echo "构建 CSU 生物信息学课程网站"
echo "=========================================="

# 清理旧的构建
echo "清理旧构建..."
rm -rf _site

# 渲染根目录
echo ""
echo "渲染网站..."
quarto render

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
