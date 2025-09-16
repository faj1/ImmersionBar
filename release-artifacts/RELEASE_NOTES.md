# ImmersionBar v3.2.2 Release Notes

## 🎉 新功能和改进

### Android 15/16 支持
- ✅ 升级 `compileSdkVersion` 和 `targetSdkVersion` 到 35 (Android 15)
- ✅ 完整支持 Android 15/16 的 Edge-to-Edge 模式
- ✅ 自动适配 Android 15+ 的新特性

### 🐛 Bug 修复

#### 预测性返回手势修复 (Issue #580)
- ✅ **修复了 Android 13+ 预测性返回手势导致的返回失效问题**
- ✅ 自动注册 `OnBackInvokedCallback` 确保返回手势正常工作
- ✅ 解决了需要连续右滑两次才能返回桌面的问题
- ✅ 无需额外配置，升级后即可解决返回手势 Bug

### 🔧 技术改进
- ✅ 升级 Gradle 到 8.2 版本
- ✅ 升级 Android Gradle Plugin 到 8.2.2
- ✅ 升级 Kotlin 到 1.9.22
- ✅ 更新 AndroidX 依赖版本
- ✅ 修复构建配置兼容性问题

## 📦 发布制品

### 核心库文件
- `immersionbar-release.aar` - 核心沉浸式库 (62KB)
- `immersionbar-sources.jar` - 核心库源码 (42KB)

### Kotlin 扩展
- `immersionbar-ktx-release.aar` - Kotlin DSL 扩展 (9KB)
- `immersionbar-ktx-sources.jar` - Kotlin 扩展源码 (2KB)

### 组件库
- `immersionbar-components-release.aar` - Fragment 组件库 (6KB)
- `immersionbar-components-sources.jar` - 组件库源码 (6KB)

## 🚀 使用方法

### Gradle 依赖
```groovy
// 基础依赖包，必须要依赖
implementation 'com.geyifeng.immersionbar:immersionbar:3.2.2'
// kotlin扩展（可选）
implementation 'com.geyifeng.immersionbar:immersionbar-ktx:3.2.2'
// fragment快速实现（可选）已废弃
implementation 'com.geyifeng.immersionbar:immersionbar-components:3.2.2'
```

### 基础用法
```java
ImmersionBar.with(this).init();
```

### Kotlin DSL 用法
```kotlin
immersionBar {
    statusBarColor(R.color.colorPrimary)
    navigationBarColor(R.color.colorPrimary)
}
```

## ⚠️ 重要说明

### Android 15/16 适配
- 从 Android 15 开始，系统默认启用 Edge-to-Edge 模式
- ImmersionBar 会自动处理相关适配，无需额外配置
- 建议在 Android 15+ 设备上充分测试应用效果

### 预测性返回手势
- Android 13+ 的预测性返回手势问题已完全修复
- 升级到此版本后，返回手势将正常工作
- 不影响 Android 12 及以下版本的功能

## 🔄 迁移指南

从旧版本升级到 3.2.2：
1. 更新 Gradle 依赖版本号
2. 如果 `targetSdkVersion >= 33`，将自动获得预测性返回手势修复
3. 无需修改任何代码，向后完全兼容

## 📝 完整更新日志

- 支持 Android 15/16 (API 35+)
- 修复预测性返回手势问题 (GitHub Issue #580)
- 升级构建工具链
- 提升整体稳定性和兼容性

---

**编译时间**: 2024年9月16日  
**编译环境**: Gradle 8.2, AGP 8.2.2, Kotlin 1.9.22  
**支持版本**: Android 4.4+ (API 19+) 到 Android 15+ (API 35+)
