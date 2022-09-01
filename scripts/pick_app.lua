---
--- Generated by Luanalysis
--- Created by landers.
--- DateTime: 2022/8/31 21:17
---

--根据环境中当前上下文启用的服务过滤
--如果域名匹配 该服务已经停止则返回

local ngx = require('ngx');
local response = require('response');

function pickApp()
    ngx.log(ngx.STDERR, 'start to pick app');
    --获取当前请求的域名
    local host = ngx.req.get_headers()["Host"]
    ngx.log(ngx.STDERR, 'request domain is:', host);
    for key, value in pairs(apps) do
        --父域名的服务暂时不会被停止 所以通过contains判断
        --实际只需要判断stat和域名关系
        local stat = value['stat'];
        local domain = value['domain'];

        if (stat == 'stop' and string.find(host, domain)) then
            return response.resStop();
        end
    end
end

pickApp();