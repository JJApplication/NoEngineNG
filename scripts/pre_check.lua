---
--- Generated by Luanalysis
--- Created by landers.
--- DateTime: 2022/9/1 0:39
---

--前置校验 空refer 爬虫

local ngx = require('ngx');

function pre_check()
    local headers = ngx.req.get_headers();
    if (headers['user-agent'] == '' or headers['user-agent'] == nil) then
        return false
    end
    local user_agent = string.lower(headers['user-agent']);
    if (string.match(user_agent, 'scrapy') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'java') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'python') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'urllib') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'apache') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'httplib') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'nodejs') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'feed') ~= nil) then
        return false
    end
    if (string.match(user_agent, 'spider') ~= nil) then
        return false
    end

    return true
end

return {pre_check = pre_check}