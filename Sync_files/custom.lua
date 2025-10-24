--[[
-- Kui_Nameplates
-- By Kesava at curse.com
-- All rights reserved

   Rename this file to custom.lua to attach custom code to the addon. Once
   renamed, you'll need to completely restart WoW so that it detects the file.

   Some examples can be found at the following URL:
   https://github.com/rbtwrrr/Kui_Nameplates-Customs
]]
local kn = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')
local mod = kn:NewModule('CustomInjector', 'AceEvent-3.0')

---------------------------------------------------------------------- Create --
function mod:PostCreate(msg, frame)
	-- Place code to be performed after a frame is created here.

end

------------------------------------------------------------------------ Show --
function mod:PostShow(msg, frame)
	-- Place code to be performed after a frame is shown here.

end

------------------------------------------------------------------------ Hide --
function mod:PostHide(msg, frame)
	-- Place code to be performed after a frame is hidden here.

end

---------------------------------------------------------------------- Target --
function mod:PostTarget(msg, frame)
	-- Place code to be performed when a frame becomes the player's target here.
   
end


---------------------------------------------------------------------- Update --
function mod:PostUpdate(msg, frame)
   local f = frame
   if not f.name then return end

   local text = f.name:GetText()
   if not text then return end
   if f._namecache == text then return end

   f.name:SetPoint('BOTTOMLEFT', f.health, 'BOTTOMLEFT', 15, 0)
   f.name:SetJustifyV('CENTER')
   f.name:SetJustifyH('LEFT')

   f.level:SetPoint('TOPLEFT', f.health, 'TOPLEFT', 2, -1)
   f.level:SetJustifyV('CENTER')
   f.level:SetJustifyH('LEFT')

   f.health.p:SetPoint('TOPRIGHT', f.health, 'TOPRIGHT', 0, 0)
   f.health.p:SetFontSize(8)

   
   --f.health.mo:Show()
   --print(f.health.percent)
   --print(f.name.text..":"..f.name:GetStringWidth())
   
   hooksecurefunc(f.name, "SetText", function(self, text)
      local maxLen=20
      if f.name:GetStringWidth()<=80 then return end
      --if string.len(text)<= maxLen then return end
      local t = explode(f.name.text, " ")
      local temp = ""

      for _, v in pairs(t) do
         if next(t,_) == nil then
            temp = temp .. v
         else
            temp = temp .. string.sub(v,1,1) .. ". "
         end
      end

      if f.name:GetText() == temp then
         --print("Gleich:"..temp)
      else
         f.name:SetText(temp)
         f._namecache=temp
         --print("Ändern:"..temp)
      end
   end)
end



-------------------------------------------------------------------- Register --
mod:RegisterMessage('KuiNameplates_PostCreate', 'PostCreate')
mod:RegisterMessage('KuiNameplates_PostShow', 'PostShow')
mod:RegisterMessage('KuiNameplates_PostHide', 'PostHide')
mod:RegisterMessage('KuiNameplates_PostTarget', 'PostTarget')
mod:RegisterMessage('KuiNameplates_PostUpdate', 'PostUpdate')

