---
--- Generated by Luanalysis
--- Created by landers.
--- DateTime: 2022/9/1 21:44
---

--加载app map状态表

local ngx = require('ngx');
local cjson = require('cjson');
local appMap = '/app/apps.json';

local empty = {};
empty['Demo'] = {['stat'] = 'run', ['domain'] = ''};

--octopus表是appName: domain的映射关系
--如果stat = stop 则禁止访问
--不存在则创建
local function loadApps()
    local file = io.open(appMap, 'r');
    if (file == nil) then
        ngx.log(ngx.STDERR, 'init app maps');
        local fn = io.open(appMap, 'a+');
        local data = cjson.encode(empty);
        fn:write(data);
        fn:close();
        return empty;
    else
        local jsonData = file:read('*a');
        file:close();
        local data = cjson.decode(jsonData);
        ngx.log(ngx.STDERR, 'load apps from ', appMap);
        return data;
    end
end

return {loadApps = loadApps}