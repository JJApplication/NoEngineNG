---
--- Generated by Luanalysis
--- Created by landers.
--- DateTime: 2022/9/3 11:39
---


function load_stop_page()
    page_stop_file = io.open('/app/html/stop.html', 'r');
    local page_stop_content = page_stop_file:read('*a');
    page_stop_file:close();
    return page_stop_content;
end

return {load_stop_page = load_stop_page}