# ImmersionBar 快速开始示例

这是一个完整的示例，展示如何在新项目中快速集成 ImmersionBar v3.2.2。

## 📁 项目结构示例

```
MyApp/
├── app/
│   ├── build.gradle
│   └── src/main/
│       ├── AndroidManifest.xml
│       ├── java/com/example/myapp/
│       │   └── MainActivity.java
│       └── res/
│           ├── layout/activity_main.xml
│           ├── values/colors.xml
│           └── values/styles.xml
└── build.gradle (Project)
```

## 🔧 配置文件

### 1. 项目根目录 build.gradle

```groovy
// Top-level build file
buildscript {
    ext.kotlin_version = '1.9.22'
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        // 添加本地 Maven 仓库（重要！）
        mavenLocal()
        
        google()
        mavenCentral()
    }
}
```

### 2. app/build.gradle

```groovy
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'  // 如果使用 Kotlin

android {
    namespace 'com.example.myapp'
    compileSdkVersion 35
    
    defaultConfig {
        applicationId "com.example.myapp"
        minSdkVersion 21
        targetSdkVersion 35
        versionCode 1
        versionName "1.0"
    }
    
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    
    kotlinOptions {  // 如果使用 Kotlin
        jvmTarget = '1.8'
    }
    
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.11.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
    
    // ImmersionBar 依赖
    implementation 'com.geyifeng.immersionbar:immersionbar:3.2.2'
    implementation 'com.geyifeng.immersionbar:immersionbar-ktx:3.2.2'  // 如果使用 Kotlin
}
```

### 3. AndroidManifest.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/AppTheme"
        android:maxAspectRatio="2.4">
        
        <!-- 全面屏适配 -->
        <meta-data
            android:name="android.max_aspect"
            android:value="2.4" />
            
        <!-- 华为刘海屏适配 -->
        <meta-data
            android:name="android.notch_support"
            android:value="true" />
            
        <!-- 小米刘海屏适配 -->
        <meta-data
            android:name="notch.config"
            android:value="portrait|landscape" />

        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
```

## 🎨 资源文件

### colors.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="colorPrimary">#6200EE</color>
    <color name="colorPrimaryDark">#3700B3</color>
    <color name="colorAccent">#03DAC5</color>
    <color name="white">#FFFFFF</color>
    <color name="black">#000000</color>
    <color name="transparent">#00000000</color>
</resources>
```

### styles.xml

```xml
<resources>
    <!-- 透明状态栏主题 -->
    <style name="AppTheme" parent="Theme.AppCompat.Light.NoActionBar">
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
        <item name="colorAccent">@color/colorAccent</item>
        <!-- 使状态栏透明 -->
        <item name="android:statusBarColor">@color/transparent</item>
    </style>
</resources>
```

## 📱 布局文件

### activity_main.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">

    <!-- 状态栏占位视图（可选） -->
    <View
        android:id="@+id/status_bar_view"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:background="@color/colorPrimary" />

    <!-- 标题栏 -->
    <androidx.appcompat.widget.Toolbar
        android:id="@+id/toolbar"
        android:layout_width="match_parent"
        android:layout_height="?attr/actionBarSize"
        android:background="@color/colorPrimary"
        android:title="ImmersionBar Demo"
        android:titleTextColor="@color/white" />

    <!-- 主要内容 -->
    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:padding="16dp">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical">

            <TextView
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:text="欢迎使用 ImmersionBar!"
                android:textSize="18sp"
                android:gravity="center"
                android:padding="16dp" />

            <Button
                android:id="@+id/btn_transparent"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:text="透明状态栏"
                android:layout_marginTop="8dp" />

            <Button
                android:id="@+id/btn_colored"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:text="彩色状态栏"
                android:layout_marginTop="8dp" />

            <Button
                android:id="@+id/btn_dark_font"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:text="深色字体"
                android:layout_marginTop="8dp" />

            <EditText
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:hint="测试软键盘处理"
                android:layout_marginTop="16dp" />

        </LinearLayout>
    </ScrollView>
</LinearLayout>
```

## 💻 Java 代码示例

### MainActivity.java

```java
package com.example.myapp;

import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import com.gyf.immersionbar.ImmersionBar;

public class MainActivity extends AppCompatActivity {

    private Toolbar toolbar;
    private View statusBarView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        initViews();
        initImmersionBar();
        setupClickListeners();
    }

    private void initViews() {
        toolbar = findViewById(R.id.toolbar);
        statusBarView = findViewById(R.id.status_bar_view);
        setSupportActionBar(toolbar);
    }

    private void initImmersionBar() {
        ImmersionBar.with(this)
            .statusBarView(statusBarView)           // 使用状态栏占位视图
            .statusBarColor(R.color.colorPrimary)   // 状态栏颜色
            .navigationBarColor(R.color.colorPrimary) // 导航栏颜色
            .statusBarDarkFont(false)               // 状态栏字体颜色
            .navigationBarDarkIcon(false)           // 导航栏图标颜色
            .keyboardEnable(true)                   // 解决软键盘问题
            .init();
    }

    private void setupClickListeners() {
        Button btnTransparent = findViewById(R.id.btn_transparent);
        Button btnColored = findViewById(R.id.btn_colored);
        Button btnDarkFont = findViewById(R.id.btn_dark_font);

        btnTransparent.setOnClickListener(v -> {
            // 透明状态栏
            ImmersionBar.with(this)
                .transparentStatusBar()
                .statusBarDarkFont(true)
                .fitsSystemWindows(true)
                .init();
        });

        btnColored.setOnClickListener(v -> {
            // 彩色状态栏
            ImmersionBar.with(this)
                .statusBarColor(R.color.colorAccent)
                .navigationBarColor(R.color.colorAccent)
                .statusBarDarkFont(false)
                .statusBarView(statusBarView)
                .init();
        });

        btnDarkFont.setOnClickListener(v -> {
            // 白色状态栏 + 深色字体
            ImmersionBar.with(this)
                .statusBarColor(Color.WHITE)
                .navigationBarColor(Color.WHITE)
                .statusBarDarkFont(true, 0.2f)  // 不支持时添加透明度
                .navigationBarDarkIcon(true)
                .statusBarView(statusBarView)
                .init();
        });
    }
}
```

## 🎯 Kotlin 代码示例

### MainActivity.kt

```kotlin
package com.example.myapp

import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import com.gyf.immersionbar.ktx.immersionBar

class MainActivity : AppCompatActivity() {

    private lateinit var toolbar: Toolbar
    private lateinit var statusBarView: View

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        initViews()
        initImmersionBar()
        setupClickListeners()
    }

    private fun initViews() {
        toolbar = findViewById(R.id.toolbar)
        statusBarView = findViewById(R.id.status_bar_view)
        setSupportActionBar(toolbar)
    }

    private fun initImmersionBar() {
        immersionBar {
            statusBarView(statusBarView)
            statusBarColor(R.color.colorPrimary)
            navigationBarColor(R.color.colorPrimary)
            statusBarDarkFont(false)
            navigationBarDarkIcon(false)
            keyboardEnable(true)
        }
    }

    private fun setupClickListeners() {
        findViewById<Button>(R.id.btn_transparent).setOnClickListener {
            // 透明状态栏
            immersionBar {
                transparentStatusBar()
                statusBarDarkFont(true)
                fitsSystemWindows(true)
            }
        }

        findViewById<Button>(R.id.btn_colored).setOnClickListener {
            // 彩色状态栏
            immersionBar {
                statusBarColor(R.color.colorAccent)
                navigationBarColor(R.color.colorAccent)
                statusBarDarkFont(false)
                statusBarView(statusBarView)
            }
        }

        findViewById<Button>(R.id.btn_dark_font).setOnClickListener {
            // 白色状态栏 + 深色字体
            immersionBar {
                statusBarColor(Color.WHITE)
                navigationBarColor(Color.WHITE)
                statusBarDarkFont(true, 0.2f)
                navigationBarDarkIcon(true)
                statusBarView(statusBarView)
            }
        }
    }
}
```

## 🚀 运行步骤

1. **创建新项目**：使用 Android Studio 创建新项目
2. **配置依赖**：按照上面的配置修改 build.gradle 文件
3. **复制代码**：将示例代码复制到对应文件中
4. **同步项目**：点击 "Sync Now" 同步 Gradle
5. **运行测试**：连接设备或启动模拟器运行应用

## 📱 测试功能

运行应用后，您可以测试：

- ✅ 基础沉浸式效果
- ✅ 透明状态栏
- ✅ 彩色状态栏
- ✅ 深色字体切换
- ✅ 软键盘处理
- ✅ Android 15+ 兼容性
- ✅ 预测性返回手势

## 🔍 验证本地依赖

如果遇到依赖找不到的问题，可以检查：

```bash
# 查看本地 Maven 仓库
ls ~/.m2/repository/com/geyifeng/immersionbar/

# 应该看到以下目录：
# - immersionbar/3.2.2/
# - immersionbar-ktx/3.2.2/
# - immersionbar-components/3.2.2/
```

---

这个示例提供了一个完整的起始项目模板，您可以直接使用或根据需要进行修改。
