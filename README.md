![Logo](https://github.com/libobjc/resource/blob/master/SGWindowLayout/SGWindowLayout-logo.png?raw=true)

# SGWindowLayout

SGWindowLayout 是一款 macOS 窗口布局小应用。

## 功能特点

- 通过快捷键，快速布局焦点窗口的位置及大小。
- 可自定义快捷键及布局方式。
- 可设置开机自动启动。

## 使用示例

默认绑定了如下快捷键

- Control + A -> 铺满屏幕左半部分
- Control + S -> 全屏
- Control + D -> 铺满屏幕左右部分
- Control + W -> 铺满屏幕上半部分
- Control + X -> 铺满屏幕下半部分

如需更改，可在 AppDelegate 的 registerHotKey 方法中更改。例如：

```obj-c
// 使用 control + a 将当前焦点窗口铺满屏幕左半部分。
[SGWLHotKey registerLayoutAttribute:SGWLLayoutAttributeLeft keyCode:SGWLKeyCodeA modifiers:SGWLModifiersKeyControl];
```

### 默认加入了

## 效果演示

![Example](https://github.com/libobjc/resource/blob/master/SGWindowLayout/SGWindowLayout-example.gif?raw=true)


## 注意事项

- 如果出现在 Xcode 中直接 run 无响应的情况。可以先 build，再将 Products 下的 App 拷贝到 Applications 下进行使用。
