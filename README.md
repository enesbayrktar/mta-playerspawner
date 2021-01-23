# mta-playerspawner
A dbConnection resource for MTA:SA supports create dynamic connections


#### İnstall instructions
```markdown
# Download resource from Github/release
- move at youre mta-server's resources folder
- type refresh in console
- command start mta-playerspawner
```

```markdown
# Exported functions
- playerAtSpawnpoint
- getRandomPositionInRange
- getRandomSpawnpoint
- createSpawnpoint
```

```markdown
# How to use?
- open anyserverside Lua
- write example below
```

##### `server.lua` example
```lua
local spawnPoint = exports.spawn:createSpawnpoint(2536.41260, -1798.64929, 12.54688)
if not spawnPoint then
  return false
end

addEventHandler('onPlayerJoin', root, function()
    exports.spawn:playerAtSpawnpoint(source, spawnPoint, 10)
  end
)

local x, y = 0, 0
local radiusX, radiusY = 100, 200
local randomPositionVector = exports.spawn:getRandomPositionInRange( Vector2(x, y), Vector2(math.random(0, radiusX), math.random(0, radiusY)) )

print(randomPositionVector.x, randomPositionVector.y)
```
