local effil = require("effil")

-- channel allow to push data in one thread and pop in other
local channel = effil.channel()

-- writes some numbers to channel
local function producer(channel)
    for i = 1, 5 do
        print("push " .. i)
        channel:push(i)
    end
    channel:push(nil)
end

-- read numbers from channels
local function consumer(channel)
    local i = channel:pop()
    -- while i do
    --     print("pop " .. i)
    --     i = channel:pop()
    -- end
end

-- run producer
local thr = effil.thread(producer)(channel)

-- run consumer
consumer(channel)

-- thr:wait()
