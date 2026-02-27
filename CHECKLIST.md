# 修改检查清单

## 已完成修改

### 1. 年份更新 (2025 → 2026)
- [x] _quarto.yml 页脚版权
- [x] license.qmd 许可证文件
- [x] dist/index.html 部署主页

### 2. 学院名称修正
- [x] School of Biomedical Informatics → Department of Biomedical Informatics
- [x] 所有页面统一为"中南大学 · 生物信息学专业"

### 3. 管道操作符统一 (|>)
- [x] 所有 .qmd 文件中的 %>% 替换为 |>

### 4. 学时展示修正 (45分钟/学时)
- [x] syllabus.qmd: 明确标注"每学时 = 45分钟"
- [x] syllabus.qmd: 理论2学时=90分钟, 实验2学时=90分钟
- [x] index.qmd: 同步更新学时展示

### 5. 幻灯片补充核心包与生态
- [x] slides-r-basics.qmd: 新增"R包生态概览"章节
- [x] 介绍CRAN与Bioconductor
- [x] 介绍tidyverse和Bioconductor核心包

### 6. 示例数据文件生成
- [x] data/samples/sample1.txt
- [x] data/samples/sample2.txt
- [x] data/samples/sample3.txt

### 7. Logo修复
- [x] 复制 logo.png 到课程目录
- [x] 更新幻灯片logo路径为 ../logo.png

### 8. 独立部署版本创建
- [x] dist/ 目录包含完整静态网站
- [x] dist/index.html 课程总览主页
- [x] 所有资源相对路径
- [x] 可完全离线使用

### 9. 教师信息完善
- [x] 个人照片: http://biotree.top:38123/wsx.jpeg
- [x] 实验室主页: https://wanglabcsu.github.io/
- [x] GitHub组织: https://github.com/WangLabCSU

## 验证步骤

部署后请检查：

1. [ ] 主页显示正常: index.html
2. [ ] 幻灯片可访问: slides/slides-r-basics.html
3. [ ] Logo显示正常
4. [ ] 示例数据可下载: data/samples/sample1.txt
5. [ ] 所有链接可点击
6. [ ] 版权年份显示2026

## 最终输出

- 源码目录: /Users/wsx/courses/
- 部署目录: /Users/wsx/courses/dist/
- 可直接复制 dist/ 到服务器使用
