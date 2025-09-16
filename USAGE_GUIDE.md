# ImmersionBar 使用指南

本文档详细说明如何在其他 Android 项目中使用已发布到本地 Maven 仓库的 ImmersionBar v3.2.2。

## 📋 目录

1. [项目配置](#项目配置)
2. [基础用法](#基础用法)
3. [高级用法](#高级用法)
4. [Kotlin DSL 用法](#kotlin-dsl-用法)
5. [Fragment 中使用](#fragment-中使用)
6. [Dialog 中使用](#dialog-中使用)
7. [常见问题解决](#常见问题解决)
8. [最佳实践](#最佳实践)

## 🔧 项目配置

### 1. 添加本地 Maven 仓库

在您项目的 **根目录** `build.gradle` 文件中添加本地 Maven 仓库：

```groovy
allprojects {
    repositories {
        // 添加本地 Maven 仓库
        mavenLocal()
        
        // 其他仓库
        google()
        mavenCentral()
        jcenter()
    }
}
```

### 2. 添加依赖

在您的 **app 模块** `build.gradle` 文件中添加依赖：

```groovy
dependencies {
    // 基础依赖包（必须）
    implementation 'com.geyifeng.immersionbar:immersionbar:3.2.2'
    
    // Kotlin 扩展（可选，如果使用 Kotlin）
    implementation 'com.geyifeng.immersionbar:immersionbar-ktx:3.2.2'
    
    // Fragment 组件（可选，已废弃但仍可用）
    implementation 'com.geyifeng.immersionbar:immersionbar-components:3.2.2'
}
```

### 3. Android 配置要求

确保您的项目配置满足以下要求：

```groovy
android {
    compileSdkVersion 35  // 推荐使用最新版本
    
    defaultConfig {
        minSdkVersion 14      // ImmersionBar 最低支持 Android 4.4
        targetSdkVersion 35   // 推荐使用最新版本
    }
    
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    
    // 如果使用 Kotlin
    kotlinOptions {
        jvmTarget = '1.8'
    }
}
```

## 🚀 基础用法

### 1. 最简单的使用方式

在您的 Activity 中：

```java
public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        // 初始化沉浸式状态栏
        ImmersionBar.with(this).init();
    }
}
```

### 2. 基础配置

```java
ImmersionBar.with(this)
    .statusBarColor(R.color.colorPrimary)           // 状态栏颜色
    .navigationBarColor(R.color.colorPrimary)       // 导航栏颜色
    .statusBarDarkFont(true)                        // 状态栏字体深色
    .navigationBarDarkIcon(true)                    // 导航栏图标深色
    .init();
```

## 🎯 高级用法

### 1. 完整参数配置

```java
ImmersionBar.with(this)
    .transparentStatusBar()                         // 透明状态栏
    .transparentNavigationBar()                     // 透明导航栏
    .statusBarColor(R.color.colorPrimary)          // 状态栏颜色
    .navigationBarColor(R.color.colorPrimary)      // 导航栏颜色
    .statusBarAlpha(0.3f)                          // 状态栏透明度
    .navigationBarAlpha(0.4f)                      // 导航栏透明度
    .statusBarDarkFont(true)                       // 状态栏字体深色
    .navigationBarDarkIcon(true)                   // 导航栏图标深色
    .autoDarkModeEnable(true)                      // 自动深色模式
    .fullScreen(true)                              // 全屏显示
    .hideBar(BarHide.FLAG_HIDE_BAR)               // 隐藏状态栏或导航栏
    .fitsSystemWindows(true)                       // 解决重叠问题
    .statusBarView(R.id.status_bar_view)          // 状态栏占位视图
    .keyboardEnable(true)                          // 软键盘处理
    .init();
```

### 2. 解决状态栏与布局重叠

**方法一：使用 fitsSystemWindows**
```java
ImmersionBar.with(this)
    .fitsSystemWindows(true)
    .statusBarColor(R.color.colorPrimary)
    .init();
```

**方法二：使用 statusBarView**
```xml
<LinearLayout>
    <View
        android:id="@+id/status_bar_view"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:background="@color/colorPrimary" />
    
    <!-- 其他布局 -->
</LinearLayout>
```

```java
ImmersionBar.with(this)
    .statusBarView(R.id.status_bar_view)
    .init();
```

**方法三：使用 titleBar**
```java
ImmersionBar.with(this)
    .titleBar(toolbar)  // 传入 Toolbar 或其他标题栏视图
    .init();
```

### 3. 软键盘处理

```java
ImmersionBar.with(this)
    .keyboardEnable(true)  // 解决软键盘与底部输入框冲突
    .setOnKeyboardListener(new OnKeyboardListener() {
        @Override
        public void onKeyboardChange(boolean isPopup, int keyboardHeight) {
            if (isPopup) {
                // 软键盘弹出
                Log.d("Keyboard", "键盘弹出，高度: " + keyboardHeight);
            } else {
                // 软键盘关闭
                Log.d("Keyboard", "键盘关闭");
            }
        }
    })
    .init();
```

## 🎨 Kotlin DSL 用法

如果您的项目使用 Kotlin，可以使用更简洁的 DSL 语法：

### 1. 基础用法

```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        // 使用 DSL 语法
        immersionBar {
            statusBarColor(R.color.colorPrimary)
            navigationBarColor(R.color.colorPrimary)
            statusBarDarkFont(true)
        }
    }
}
```

### 2. 高级配置

```kotlin
immersionBar {
    transparentStatusBar()
    statusBarColor(R.color.colorPrimary)
    navigationBarColor(R.color.colorPrimary)
    statusBarDarkFont(true)
    navigationBarDarkIcon(true)
    fitsSystemWindows(true)
    keyboardEnable(true)
}
```

### 3. 获取系统栏信息

```kotlin
// 获取状态栏高度
val statusBarHeight = this.statusBarHeight

// 获取导航栏高度
val navigationBarHeight = this.navigationBarHeight

// 检查是否有导航栏
val hasNavigationBar = this.hasNavigationBar

// 检查是否是刘海屏
val hasNotchScreen = this.hasNotchScreen
```

## 📱 Fragment 中使用

### 1. 基础用法

```java
public class MyFragment extends Fragment {
    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        
        ImmersionBar.with(this)
            .statusBarColor(R.color.colorAccent)
            .init();
    }
}
```

### 2. Kotlin 中使用

```kotlin
class MyFragment : Fragment() {
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        immersionBar {
            statusBarColor(R.color.colorAccent)
            navigationBarColor(R.color.colorAccent)
        }
    }
}
```

### 3. ViewPager + Fragment

```java
// 在 Activity 中监听页面切换
viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
    @Override
    public void onPageSelected(int position) {
        // 根据不同页面设置不同的沉浸式效果
        switch (position) {
            case 0:
                ImmersionBar.with(MainActivity.this)
                    .statusBarColor(R.color.color1)
                    .init();
                break;
            case 1:
                ImmersionBar.with(MainActivity.this)
                    .statusBarColor(R.color.color2)
                    .init();
                break;
        }
    }
});
```

## 💬 Dialog 中使用

### 1. DialogFragment

```java
public class MyDialogFragment extends DialogFragment {
    @Override
    public void onStart() {
        super.onStart();
        
        ImmersionBar.with(this)
            .statusBarColor(R.color.dialog_color)
            .init();
    }
}
```

### 2. 普通 Dialog

```java
Dialog dialog = new Dialog(this);
dialog.setContentView(R.layout.dialog_layout);

// 为 Dialog 设置沉浸式
ImmersionBar.with(this, dialog)
    .statusBarColor(R.color.dialog_color)
    .init();

dialog.show();

// 记住在 Dialog 关闭时销毁
dialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
    @Override
    public void onDismiss(DialogInterface dialogInterface) {
        ImmersionBar.destroy(MainActivity.this, dialog);
    }
});
```

## 🔧 常见问题解决

### 1. Android 15+ 适配

ImmersionBar v3.2.2 已自动适配 Android 15+ 的 Edge-to-Edge 模式，无需额外配置。

### 2. 预测性返回手势问题

如果遇到返回手势失效问题，确保：
- 使用 ImmersionBar v3.2.2 或更高版本
- targetSdkVersion >= 33

### 3. 白色状态栏字体问题

```java
ImmersionBar.with(this)
    .statusBarColor(Color.WHITE)
    .statusBarDarkFont(true, 0.2f)  // 如果不支持深色字体，会添加透明度
    .init();
```

### 4. 刘海屏适配

在 AndroidManifest.xml 中添加：

```xml
<application>
    <!-- 华为刘海屏适配 -->
    <meta-data 
        android:name="android.notch_support" 
        android:value="true"/>
    
    <!-- 小米刘海屏适配 -->
    <meta-data
        android:name="notch.config"
        android:value="portrait|landscape" />
</application>
```

### 5. 全面屏适配

```xml
<application
    android:resizeableActivity="true"
    android:maxAspectRatio="2.4">
    
    <meta-data 
        android:name="android.max_aspect"
        android:value="2.4" />
</application>
```

## ✨ 最佳实践

### 1. BaseActivity 封装

```java
public abstract class BaseActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutId());
        initImmersionBar();
    }
    
    protected void initImmersionBar() {
        ImmersionBar.with(this)
            .statusBarColor(getStatusBarColor())
            .navigationBarColor(getNavigationBarColor())
            .statusBarDarkFont(isStatusBarDarkFont())
            .init();
    }
    
    protected abstract int getLayoutId();
    
    protected int getStatusBarColor() {
        return R.color.colorPrimary;
    }
    
    protected int getNavigationBarColor() {
        return R.color.colorPrimary;
    }
    
    protected boolean isStatusBarDarkFont() {
        return false;
    }
}
```

### 2. 主题适配

```java
// 根据系统主题自动切换
boolean isDarkMode = (getResources().getConfiguration().uiMode & 
    Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES;

ImmersionBar.with(this)
    .statusBarColor(isDarkMode ? R.color.dark_primary : R.color.light_primary)
    .statusBarDarkFont(!isDarkMode)
    .init();
```

### 3. 状态栏高度获取

```java
// 获取状态栏高度用于布局调整
int statusBarHeight = ImmersionBar.getStatusBarHeight(this);
view.setPadding(0, statusBarHeight, 0, 0);
```

## 🎯 完整示例

这里是一个完整的使用示例：

```java
public class MainActivity extends AppCompatActivity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        initImmersionBar();
        setupViews();
    }
    
    private void initImmersionBar() {
        ImmersionBar.with(this)
            .statusBarColor(R.color.colorPrimary)
            .navigationBarColor(R.color.colorPrimary)
            .statusBarDarkFont(true)
            .navigationBarDarkIcon(true)
            .keyboardEnable(true)
            .setOnKeyboardListener((isPopup, keyboardHeight) -> {
                // 处理软键盘事件
                if (isPopup) {
                    // 键盘弹出时的处理
                } else {
                    // 键盘收起时的处理
                }
            })
            .init();
    }
    
    private void setupViews() {
        // 设置其他视图...
    }
}
```

## 📞 技术支持

如果您在使用过程中遇到问题：

1. 首先查看本文档的常见问题部分
2. 查看项目的 README.md 文件
3. 检查 GitHub Issues 中是否有类似问题
4. 确保使用的是最新版本 (v3.2.2)

---

**版本**: ImmersionBar v3.2.2  
**支持系统**: Android 4.4+ (API 19+) 到 Android 15+ (API 35+)  
**更新时间**: 2024年9月16日
