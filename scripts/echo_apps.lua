---
--- Generated by Luanalysis
--- Created by landers.
--- DateTime: 2022/8/31 21:26
---

local ngx = require('ngx');
local dict_apps = ngx.shared.dict_apps;
--table->string
for key, value in pairs(dict_apps) do
    ngx.log(ngx.STDERR, key, '--');
end