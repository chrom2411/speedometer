execute store result score @s ftmc_sm_x2 run data get entity @s Pos[0] 10
execute store result score @s ftmc_sm_y2 run data get entity @s Pos[1] 10
execute store result score @s ftmc_sm_z2 run data get entity @s Pos[2] 10

scoreboard players operation @s ftmc_sm_dx = @s ftmc_sm_x2
scoreboard players operation @s ftmc_sm_dy = @s ftmc_sm_y2
scoreboard players operation @s ftmc_sm_dz = @s ftmc_sm_z2

scoreboard players operation @s ftmc_sm_dx -= @s ftmc_sm_x1
scoreboard players operation @s ftmc_sm_dy -= @s ftmc_sm_y1
scoreboard players operation @s ftmc_sm_dz -= @s ftmc_sm_z1

scoreboard players operation @s ftmc_sm_x1 = @s ftmc_sm_x2
scoreboard players operation @s ftmc_sm_y1 = @s ftmc_sm_y2
scoreboard players operation @s ftmc_sm_z1 = @s ftmc_sm_z2


# Calculate the approximate current speed with the following algorithm:
# dmax = max(dx, dy, dz), where dx,dy,dz >= 0
# dsum = (dx + dy + dz) / sqrt(2)
# CurrentSpeed = max(dmax, dsum)
# Verified by "plot max(x, 10, (x+10)/sqrt(2)), sqrt(x*x+10*10) from x=0 to 50" on Wolfram Alpha

# Replace ftmc_sm_dx, ftmc_sm_dy, ftmc_sm_dz with their own absolute values.
scoreboard players set @s ftmc_sm_const -1
scoreboard players operation @s ftmc_sm_dt = @s ftmc_sm_dx
scoreboard players operation @s ftmc_sm_dt *= @s ftmc_sm_const
scoreboard players operation @s ftmc_sm_dx > @s ftmc_sm_dt
scoreboard players operation @s ftmc_sm_dt = @s ftmc_sm_dy
scoreboard players operation @s ftmc_sm_dt *= @s ftmc_sm_const
scoreboard players operation @s ftmc_sm_dy > @s ftmc_sm_dt
scoreboard players operation @s ftmc_sm_dt = @s ftmc_sm_dz
scoreboard players operation @s ftmc_sm_dt *= @s ftmc_sm_const
scoreboard players operation @s ftmc_sm_dz > @s ftmc_sm_dt

# Calculate dmax
scoreboard players operation @s ftmc_sm_dm_2d = @s ftmc_sm_dx
scoreboard players operation @s ftmc_sm_dm_2d > @s ftmc_sm_dz
scoreboard players operation @s ftmc_sm_dm_3d = @s ftmc_sm_dm_2d
scoreboard players operation @s ftmc_sm_dm_3d > @s ftmc_sm_dy

# Calculate dsum (where 707 below approximates 1000 / sqrt(2).)
scoreboard players operation @s ftmc_sm_ds_2d = @s ftmc_sm_dx
scoreboard players operation @s ftmc_sm_ds_2d += @s ftmc_sm_dz
scoreboard players operation @s ftmc_sm_ds_3d = @s ftmc_sm_ds_2d
scoreboard players operation @s ftmc_sm_ds_3d += @s ftmc_sm_dy
scoreboard players set @s ftmc_sm_const 707
scoreboard players operation @s ftmc_sm_ds_2d *= @s ftmc_sm_const
scoreboard players operation @s ftmc_sm_ds_3d *= @s ftmc_sm_const
scoreboard players set @s ftmc_sm_const 1000
scoreboard players operation @s ftmc_sm_ds_2d /= @s ftmc_sm_const
scoreboard players operation @s ftmc_sm_ds_3d /= @s ftmc_sm_const

# Calculate the final result
scoreboard players operation @s spd_2d_ms = @s ftmc_sm_dm_2d
scoreboard players operation @s spd_2d_ms > @s ftmc_sm_ds_2d

scoreboard players operation @s spd_3d_ms = @s ftmc_sm_dm_3d
scoreboard players operation @s spd_3d_ms > @s ftmc_sm_ds_3d

# Display the result
scoreboard players set @s ftmc_sm_const 5
scoreboard players operation @s spd_2d_ms *= @s ftmc_sm_const
scoreboard players operation @s spd_3d_ms *= @s ftmc_sm_const

scoreboard players operation @s spd_2d_kmh = @s spd_2d_ms
scoreboard players operation @s spd_3d_kmh = @s spd_3d_ms
# 3600/1000 == 18/5
scoreboard players set @s ftmc_sm_const 18
scoreboard players operation @s spd_2d_kmh *= @s ftmc_sm_const
scoreboard players operation @s spd_3d_kmh *= @s ftmc_sm_const
scoreboard players set @s ftmc_sm_const 5
scoreboard players operation @s spd_2d_kmh /= @s ftmc_sm_const
scoreboard players operation @s spd_3d_kmh /= @s ftmc_sm_const

scoreboard players set @s ftmc_sm_const 10
scoreboard players operation @s spd_2d_ms_dec = @s spd_2d_ms
scoreboard players operation @s spd_2d_ms_dec %= @s ftmc_sm_const
scoreboard players operation @s spd_2d_ms /= @s ftmc_sm_const

scoreboard players operation @s spd_3d_ms_dec = @s spd_3d_ms
scoreboard players operation @s spd_3d_ms_dec %= @s ftmc_sm_const
scoreboard players operation @s spd_3d_ms /= @s ftmc_sm_const

scoreboard players operation @s spd_2d_kmh_dec = @s spd_2d_kmh
scoreboard players operation @s spd_2d_kmh_dec %= @s ftmc_sm_const
scoreboard players operation @s spd_2d_kmh /= @s ftmc_sm_const

scoreboard players operation @s spd_3d_kmh_dec = @s spd_3d_kmh
scoreboard players operation @s spd_3d_kmh_dec %= @s ftmc_sm_const
scoreboard players operation @s spd_3d_kmh /= @s ftmc_sm_const

title @s actionbar ["",{"text":"2d:"},{"score":{"name":"@s","objective":"spd_2d_ms"}},{"text":"."},{"score":{"name":"@s","objective":"spd_2d_ms_dec"}},{"text":"m/s"},{"text":" ","color":"none"},{"score":{"name":"@s","objective":"spd_2d_kmh"}},{"text":"."},{"score":{"name":"@s","objective":"spd_2d_kmh_dec"}},{"text":"km/h"},{"text":" ","color":"none"},{"text":"3d:"},{"score":{"name":"@s","objective":"spd_3d_ms"}},{"text":"."},{"score":{"name":"@s","objective":"spd_3d_ms_dec"}},{"text":"m/s"},{"text":" ","color":"none"},{"score":{"name":"@s","objective":"spd_3d_kmh"}},{"text":"."},{"score":{"name":"@s","objective":"spd_3d_kmh_dec"}},{"text":"km/h"}]

# Finally reset the waiting time (in ticks) before the next call.
scoreboard players set @s ftmc_sm_timer 4