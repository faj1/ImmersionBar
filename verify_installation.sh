#!/bin/bash

# ImmersionBar 本地安装验证脚本
# 用于检查 ImmersionBar v3.2.2 是否正确发布到本地 Maven 仓库

echo "🔍 ImmersionBar v3.2.2 安装验证"
echo "================================="

# 定义变量
LOCAL_REPO="$HOME/.m2/repository/com/geyifeng/immersionbar"
VERSION="3.2.2"

# 检查本地 Maven 仓库目录
echo "📁 检查本地 Maven 仓库..."
if [ ! -d "$LOCAL_REPO" ]; then
    echo "❌ 错误: 本地 Maven 仓库中未找到 ImmersionBar"
    echo "   路径: $LOCAL_REPO"
    echo "   请先运行: ./gradlew publishToMavenLocal"
    exit 1
fi

echo "✅ 找到本地 Maven 仓库目录"

# 检查各个模块
modules=("immersionbar" "immersionbar-ktx" "immersionbar-components")
missing_modules=()

for module in "${modules[@]}"; do
    module_path="$LOCAL_REPO/$module/$VERSION"
    echo ""
    echo "📦 检查模块: $module"
    
    if [ ! -d "$module_path" ]; then
        echo "❌ 模块目录不存在: $module_path"
        missing_modules+=("$module")
        continue
    fi
    
    # 检查必需文件
    required_files=("${module}-${VERSION}.aar" "${module}-${VERSION}.pom")
    optional_files=("${module}-${VERSION}-sources.jar")
    
    for file in "${required_files[@]}"; do
        if [ -f "$module_path/$file" ]; then
            size=$(du -h "$module_path/$file" | cut -f1)
            echo "  ✅ $file ($size)"
        else
            echo "  ❌ 缺少文件: $file"
            missing_modules+=("$module")
        fi
    done
    
    for file in "${optional_files[@]}"; do
        if [ -f "$module_path/$file" ]; then
            size=$(du -h "$module_path/$file" | cut -f1)
            echo "  ✅ $file ($size)"
        else
            echo "  ⚠️  可选文件不存在: $file"
        fi
    done
done

echo ""
echo "================================="

# 总结结果
if [ ${#missing_modules[@]} -eq 0 ]; then
    echo "🎉 验证成功!"
    echo "✅ 所有 ImmersionBar 模块都已正确安装到本地 Maven 仓库"
    echo ""
    echo "📋 可用模块:"
    echo "  • com.geyifeng.immersionbar:immersionbar:$VERSION"
    echo "  • com.geyifeng.immersionbar:immersionbar-ktx:$VERSION"
    echo "  • com.geyifeng.immersionbar:immersionbar-components:$VERSION"
    echo ""
    echo "📖 使用方法:"
    echo "  1. 在项目根目录 build.gradle 中添加: mavenLocal()"
    echo "  2. 在 app/build.gradle 中添加依赖"
    echo "  3. 参考 USAGE_GUIDE.md 和 QUICK_START_EXAMPLE.md"
    echo ""
    echo "🔗 相关文件:"
    echo "  • 详细使用指南: USAGE_GUIDE.md"
    echo "  • 快速开始示例: QUICK_START_EXAMPLE.md"
    echo "  • 发布说明: release-artifacts/RELEASE_NOTES.md"
else
    echo "❌ 验证失败!"
    echo "缺少以下模块: ${missing_modules[*]}"
    echo ""
    echo "🔧 解决方案:"
    echo "  1. 运行: ./gradlew clean"
    echo "  2. 运行: ./gradlew publishToMavenLocal"
    echo "  3. 重新运行此验证脚本"
    exit 1
fi

echo ""
echo "🚀 现在您可以在其他项目中使用 ImmersionBar v$VERSION 了!"
