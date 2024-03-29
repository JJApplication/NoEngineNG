---
--- Generated by Luanalysis
--- Created by landers.
--- DateTime: 2022/7/7 23:24
---

-- 初始化lua进程

local ngx = require('ngx');
local app_loader = require('load_apps');
local load_pages = require('load_pages');

ngx.log(ngx.STDERR, 'hello NoEngine');
ngx.log(ngx.STDERR, 'init NoEngine workers');

--加载全局变量微服务群组NoEngine
local dict_apps = ngx.shared.dict_apps;
dict_apps:set('init', 'NoEngine');

--加载全局app映射表
apps = app_loader.loadApps();
for key, value in pairs(apps) do
    ngx.log(ngx.STDERR, 'app:', key, ' stat:', value['stat'], ' domain:', value['domain']);
end

--加载全局pages页面
page_stop = load_pages.load_stop_page();