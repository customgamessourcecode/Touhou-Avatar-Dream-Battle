modifier_bosses_minoriko = class({})

local public = modifier_bosses_minoriko

--------------------------------------------------------------------------------

function public:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function public:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function public:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function public:OnCreated(kv)
	if IsServer() then
		local caster = self:GetParent()
		local time = 10.0
		caster:SetContextThink(DoUniqueString("thtd_bosses_minoriko_buff"), 
			function()
				if GameRules:IsGamePaused() then return 0.03 end
				if caster==nil or caster:IsNull() or caster:IsAlive()==false then return nil end
				time = time - 0.1
				if time>0 then
					return 0.1
				else
					local healAmount = math.min(caster:GetHealth()+caster:GetMaxHealth()*0.3,caster:GetMaxHealth())
					caster:SetHealth(healAmount)
					local effectIndex = ParticleManager:CreateParticle("particles/heroes/minoriko/ability_minoriko_04.vpcf", PATTACH_CUSTOMORIGIN, caster)
					ParticleManager:SetParticleControl(effectIndex, 0, caster:GetOrigin())
					ParticleManager:DestroyParticleSystem(effectIndex,false)
					time = 10.0
					return 0.1
				end
			end, 
		0.1)
	end
end

--------------------------------------------------------------------------------

function public:OnDestroy(kv)
	if IsServer() then
		local caster = self:GetParent()

	end
end