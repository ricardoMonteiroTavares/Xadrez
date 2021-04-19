--local startTimePlayerOne = nil
--local startTimePlayerTwo = nil
--local lastTime = nil
--local endTime = 3600
--local currentTimePlayerOne = 0
--local currentTimePlayerTwo = 0
--local isPlayerOne = true

Timer = {
    startTimePlayerOne = nil,
    startTimePlayerTwo = nil,
    lastTime = nil,
    endTime = 3600,
    currentTimePlayerOne = 0,
    currentTimePlayerTwo = 0,
    isPlayerOne = true
}

function Timer:new(o, endTime)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.endTime = endTime or 3600
    self.startTimePlayerOne = nil
    self.startTimePlayerTwo = nil
    self.lastTime = nil
    self.currentTimePlayerOne = 0
    self.currentTimePlayerTwo = 0
    self.isPlayerOne = true
    return o
end

function Timer:timerGame(isPlayerOne)
	if isPlayerOne then
		if lastTime == nil then 
			lastTime = os.time()
			currentTimePlayerOne = currentTimePlayerOne + os.time() - lastTime
			return
		end
		if currentTimePlayerOne < endTime then
			currentTimePlayerOne = currentTimePlayerOne + os.time() - lastTime
			lastTime = os.time()
			return
		end
	else
		if currentTimePlayerTwo < endTime then
			currentTimePlayerTwo = currentTimePlayerTwo + os.time() - lastTime
			lastTime = os.time()
			return
		end
	end
end

function Timer:getCurrentTimePlayerOne() return currentTimePlayerOne end
function Timer:getCurrentTimePlayerTwo() return currentTimePlayerTwo end
function Timer:getEndTime() return endTime end

return Timer