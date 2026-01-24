# 路由调试指南

## 问题症状
- 点击个人中心后，再点击用户管理，页面消失
- 左侧导航栏没有正确显示

## 调试步骤

### 1. 打开浏览器开发者工具
- F12 打开开发者工具
- 切换到 Console 标签页

### 2. 刷新页面
- F5 刷新页面
- 在 Console 中查看以下日志：

```
"Menu list from server:" - 后端返回的原始菜单数据
"Transformed routes:" - 前端转换后的路由数据
```

### 3. 检查菜单数据结构

后端返回的菜单应该包含：
```json
{
  "path": "/user",
  "name": "user",
  "component": "LAYOUT",
  "children": [
    {
      "path": "index",  // 相对路径
      "name": "UserIndex",
      "component": "/user/index"
    }
  ]
}
```

### 4. 检查转换后的路由

转换后应该是：
```json
{
  "path": "/user",
  "name": "user",
  "component": "Layout (组件)",
  "children": [
    {
      "path": "/user/index",  // 已拼接成完整路径
      "name": "UserIndex",
      "component": "动态导入的组件"
    }
  ]
}
```

### 5. 验证路由是否正确添加

在控制台执行：
```javascript
// 检查 Vue Router 中是否有相关路由
const routes = router.getRoutes();
console.log('All routes:', routes);

// 查找特定路由
const userRoute = routes.find(r => r.name === 'user');
console.log('User route:', userRoute);

const userIndexRoute = routes.find(r => r.name === 'UserIndex');
console.log('UserIndex route:', userIndexRoute);
```

### 6. 测试导航

在控制台执行：
```javascript
// 测试是否能导航到用户管理页面
router.push('/system/user');

// 测试是否能导航回个人中心
router.push('/user/index');
```

## 关键修复点

### 修复 1: asyncImportRoute 函数
- 现在接受 `parentPath` 参数
- 如果子路由路径是相对路径，会自动拼接成完整路径
- 递归处理嵌套子路由时会传递当前路由的路径

### 修复 2: transformObjectToRoute 函数  
- 现在会对 LAYOUT 类型的路由处理其子路由的相对路径
- 调用 asyncImportRoute 时会传递正确的父路径

## 预期结果

修复后，应该可以：
- ✅ 点击个人中心，页面正常显示
- ✅ 从个人中心点击用户管理，页面正常显示
- ✅ 点击左侧导航栏，正确导航
- ✅ 浏览器地址栏显示正确的 URL

## 如果仍有问题

1. 检查后端返回的菜单数据是否正确
   - 访问 http://localhost:8080/get-menu-list-i18n (或相应的后端端口)
   - 查看返回的 JSON 结构

2. 检查路由转换逻辑
   - 在 `console` 中查看 "Menu list from server" 和 "Transformed routes" 日志
   - 对比两者的差异

3. 检查 Vue Router 是否正确识别路由
   - 在 console 执行 `router.getRoutes()` 查看所有已注册的路由
   - 确认路由的 path、name、component 都正确

## 相关文件

- 前端路由工具: `/frontend/src/utils/route/index.ts`
- 权限 store: `/frontend/src/store/modules/permission.ts`
- 后端菜单服务: `/backend/src/main/java/com/tencent/tdesign/service/MenuItemService.java`
- 后端菜单控制器: `/backend/src/main/java/com/tencent/tdesign/controller/MenuController.java`
