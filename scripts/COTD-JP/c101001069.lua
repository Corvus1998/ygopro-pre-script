--パルス・ボム
--Pulse Bomb
--Scripted by Eerie Code
function c101001069.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c101001069.condition)
	e1:SetTarget(c101001069.target)
	e1:SetOperation(c101001069.activate)
	c:RegisterEffect(e1)
end
function c101001069.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c101001069.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c101001069.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c101001069.filter(c,e)
	return c:IsPosition(POS_FACEUP_ATTACK) and not c:IsImmuneToEffect(e)
end
function c101001069.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsPosition,tp,0,LOCATION_MZONE,1,nil,POS_FACEUP_ATTACK) end
	local g=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c101001069.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c101001069.filter,tp,0,LOCATION_MZONE,nil,e)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c101001069.posop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c101001069.posfilter(c,e,tp)
	return c101001069.filter(c,e) and c:IsControler(1-tp)
end
function c101001069.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c101001069.posfilter,nil,e,tp)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end
