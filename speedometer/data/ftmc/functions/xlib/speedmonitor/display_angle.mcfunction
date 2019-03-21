execute store result score @s angle_yaw run data get entity @s Rotation[0] 100
execute store result score @s angle_pitch run data get entity @s Rotation[1] 100

scoreboard players set @a ftmc_sm_canfly 0
scoreboard players set @a angle_yaw_dec 0
scoreboard players set @a angle_pitch_dec 0

execute as @a[nbt={Inventory:[{Slot:-106b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:0b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:1b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:2b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:3b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:4b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:5b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:6b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:7b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1
execute as @a[nbt={Inventory:[{Slot:8b,id:"minecraft:firework_rocket"}]}] run scoreboard players set @s ftmc_sm_canfly 1

# Adjust yaw angle +360/-360 -> +180/-180
scoreboard players set @s ftmc_sm_const 36000
execute as @a[scores={angle_yaw=-36000..-18000}] run scoreboard players operation @s angle_yaw += @s ftmc_sm_const
execute as @a[scores={angle_yaw=18000..36000}] run scoreboard players operation @s angle_yaw -= @s ftmc_sm_const

# Replace with their own absolute values before take modulo
scoreboard players operation @s angle_yaw_dec = @s angle_yaw
scoreboard players set @s ftmc_sm_const -1
scoreboard players operation @s angle_yaw_dec *= @s ftmc_sm_const
scoreboard players operation @s angle_yaw_dec > @s angle_yaw
scoreboard players set @s ftmc_sm_const 100
scoreboard players operation @s angle_yaw_dec %= @s ftmc_sm_const
scoreboard players operation @s angle_yaw /= @s ftmc_sm_const

scoreboard players operation @s angle_pitch_dec = @s angle_pitch
scoreboard players set @s ftmc_sm_const -1
scoreboard players operation @s angle_pitch_dec *= @s ftmc_sm_const
scoreboard players operation @s angle_pitch_dec > @s angle_pitch
scoreboard players set @s ftmc_sm_const 100
scoreboard players operation @s angle_pitch_dec %= @s ftmc_sm_const
scoreboard players operation @s angle_pitch /= @s ftmc_sm_const

# Adjust negative pitch angle
scoreboard players set @s ftmc_sm_const 1
execute as @a[scores={angle_pitch=..-1,angle_pitch_dec=1..}] run scoreboard players operation @s angle_pitch += @s ftmc_sm_const

# fixme: How can I zero-pad in smart way?
execute as @a[scores={ftmc_sm_canfly=1,angle_yaw_dec=10..,angle_pitch_dec=10..}] run title @s actionbar ["",{"text":"yaw:"},{"score":{"name":"@s","objective":"angle_yaw"}},{"text":"."},{"score":{"name":"@s","objective":"angle_yaw_dec"}},{"text":" ","color":"none"},{"text":"pitch:"},{"score":{"name":"@s","objective":"angle_pitch"}},{"text":"."},{"score":{"name":"@s","objective":"angle_pitch_dec"}}]
execute as @a[scores={ftmc_sm_canfly=1,angle_yaw_dec=..9,angle_pitch_dec=10..}] run title @s actionbar ["",{"text":"yaw:"},{"score":{"name":"@s","objective":"angle_yaw"}},{"text":".0"},{"score":{"name":"@s","objective":"angle_yaw_dec"}},{"text":" ","color":"none"},{"text":"pitch:"},{"score":{"name":"@s","objective":"angle_pitch"}},{"text":"."},{"score":{"name":"@s","objective":"angle_pitch_dec"}}]
execute as @a[scores={ftmc_sm_canfly=1,angle_yaw_dec=10..,angle_pitch_dec=..9}] run title @s actionbar ["",{"text":"yaw:"},{"score":{"name":"@s","objective":"angle_yaw"}},{"text":"."},{"score":{"name":"@s","objective":"angle_yaw_dec"}},{"text":" ","color":"none"},{"text":"pitch:"},{"score":{"name":"@s","objective":"angle_pitch"}},{"text":".0"},{"score":{"name":"@s","objective":"angle_pitch_dec"}}]
execute as @a[scores={ftmc_sm_canfly=1,angle_yaw_dec=..9,angle_pitch_dec=..9}] run title @s actionbar ["",{"text":"yaw:"},{"score":{"name":"@s","objective":"angle_yaw"}},{"text":".0"},{"score":{"name":"@s","objective":"angle_yaw_dec"}},{"text":" ","color":"none"},{"text":"pitch:"},{"score":{"name":"@s","objective":"angle_pitch"}},{"text":".0"},{"score":{"name":"@s","objective":"angle_pitch_dec"}}]
