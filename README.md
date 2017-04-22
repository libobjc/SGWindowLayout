# SGWindowLayout for macOS

SGWindowLayout 是一款 macOS 平台的窗口布局工具。

## 功能特点

- 通过快捷键，快速布局焦点窗口的位置及大小。
- 可自定义快捷键及布局方式。
- 可设置开机自动启动。

## Usage

```
// 使用 control + a 将当前焦点窗口铺满屏幕左半部分。
[SGWLHotKey registerLayoutAttribute:SGWLLayoutAttributeLeft keyCode:SGWLKeyCodeA modifiers:SGWLModifiersKeyControl];
```

## 注意事项

- 如果出现在 Xcode 中直接 run 无响应的情况。可以先 build，再将 Products 下的 App 拷贝到 Applications 下进行使用。
