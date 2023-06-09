/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10110##RES##ANC_ABSENCE_PLANS_LEG_DDF
-- DFF_ATTRIBUTES=INFORMATION,INFORMATION_NUMBER,INFORMATION_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT absencePlansTLE0.NAME RES_PLAN
,(SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL
	WHERE TERRITORY_CODE = absencePlansE0.LEGISLATION_CODE 
	) RES_LEGISLATION
,(SELECT NAME
	FROM PER_LEGISLATIVE_DATA_GROUPS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND LEGISLATIVE_DATA_GROUP_ID = absencePlansE0.LEGISLATIVE_DATA_GROUP_ID 
	) RES_LEGISLATIVE_DATA_GROUP
,TO_CHAR(absencePlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,absencePlansE0.INFORMATION_CATEGORY RES_CONTEXT_CODE
,absencePlansE0.INFORMATION1
,absencePlansE0.INFORMATION2
,absencePlansE0.INFORMATION3
,absencePlansE0.INFORMATION4
,absencePlansE0.INFORMATION5
,absencePlansE0.INFORMATION6
,absencePlansE0.INFORMATION7
,absencePlansE0.INFORMATION8
,absencePlansE0.INFORMATION9
,absencePlansE0.INFORMATION10
,absencePlansE0.INFORMATION11
,absencePlansE0.INFORMATION12
,absencePlansE0.INFORMATION13
,absencePlansE0.INFORMATION14
,absencePlansE0.INFORMATION15
,absencePlansE0.INFORMATION16
,absencePlansE0.INFORMATION17
,absencePlansE0.INFORMATION18
,absencePlansE0.INFORMATION19
,absencePlansE0.INFORMATION20
,absencePlansE0.INFORMATION21
,absencePlansE0.INFORMATION22
,absencePlansE0.INFORMATION23
,absencePlansE0.INFORMATION24
,absencePlansE0.INFORMATION25
,absencePlansE0.INFORMATION26
,absencePlansE0.INFORMATION27
,absencePlansE0.INFORMATION28
,absencePlansE0.INFORMATION29
,absencePlansE0.INFORMATION30
,absencePlansE0.INFORMATION_NUMBER1
,absencePlansE0.INFORMATION_NUMBER2
,absencePlansE0.INFORMATION_NUMBER3
,absencePlansE0.INFORMATION_NUMBER4
,absencePlansE0.INFORMATION_NUMBER5
,absencePlansE0.INFORMATION_NUMBER6
,absencePlansE0.INFORMATION_NUMBER7
,absencePlansE0.INFORMATION_NUMBER8
,absencePlansE0.INFORMATION_NUMBER9
,absencePlansE0.INFORMATION_NUMBER10
,absencePlansE0.INFORMATION_NUMBER11
,absencePlansE0.INFORMATION_NUMBER12
,absencePlansE0.INFORMATION_NUMBER13
,absencePlansE0.INFORMATION_NUMBER14
,absencePlansE0.INFORMATION_NUMBER15
,absencePlansE0.INFORMATION_NUMBER16
,absencePlansE0.INFORMATION_NUMBER17
,absencePlansE0.INFORMATION_NUMBER18
,absencePlansE0.INFORMATION_NUMBER19
,absencePlansE0.INFORMATION_NUMBER20
, TO_CHAR(absencePlansE0.INFORMATION_DATE1, 'DD-Mon-YYYY') INFORMATION_DATE1
, TO_CHAR(absencePlansE0.INFORMATION_DATE2, 'DD-Mon-YYYY') INFORMATION_DATE2
, TO_CHAR(absencePlansE0.INFORMATION_DATE3, 'DD-Mon-YYYY') INFORMATION_DATE3
, TO_CHAR(absencePlansE0.INFORMATION_DATE4, 'DD-Mon-YYYY') INFORMATION_DATE4
, TO_CHAR(absencePlansE0.INFORMATION_DATE5, 'DD-Mon-YYYY') INFORMATION_DATE5
, TO_CHAR(absencePlansE0.INFORMATION_DATE6, 'DD-Mon-YYYY') INFORMATION_DATE6
, TO_CHAR(absencePlansE0.INFORMATION_DATE7, 'DD-Mon-YYYY') INFORMATION_DATE7
, TO_CHAR(absencePlansE0.INFORMATION_DATE8, 'DD-Mon-YYYY') INFORMATION_DATE8
, TO_CHAR(absencePlansE0.INFORMATION_DATE9, 'DD-Mon-YYYY') INFORMATION_DATE9
, TO_CHAR(absencePlansE0.INFORMATION_DATE10, 'DD-Mon-YYYY') INFORMATION_DATE10
, TO_CHAR(absencePlansE0.INFORMATION_DATE11, 'DD-Mon-YYYY') INFORMATION_DATE11
, TO_CHAR(absencePlansE0.INFORMATION_DATE12, 'DD-Mon-YYYY') INFORMATION_DATE12
, TO_CHAR(absencePlansE0.INFORMATION_DATE13, 'DD-Mon-YYYY') INFORMATION_DATE13
, TO_CHAR(absencePlansE0.INFORMATION_DATE14, 'DD-Mon-YYYY') INFORMATION_DATE14
, TO_CHAR(absencePlansE0.INFORMATION_DATE15, 'DD-Mon-YYYY') INFORMATION_DATE15
,absencePlansE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,absencePlansE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,absencePlansE0.CREATED_BY  RSC_CREATED_BY
,absencePlansE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,absencePlansE0.LEGISLATION_CODE RSC_COUNTRY_ID
 
FROM ANC_ABSENCE_PLANS_F absencePlansE0
,(SELECT ABSENCE_PLAN_ID
	,NAME
	,DESCRIPTION
	,EFFECTIVE_START_DATE
	FROM ANC_ABSENCE_PLANS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	) absencePlansTLE0
WHERE absencePlansE0.ABSENCE_PLAN_ID = absencePlansTLE0.ABSENCE_PLAN_ID
AND absencePlansE0.EFFECTIVE_START_DATE = absencePlansTLE0.EFFECTIVE_START_DATE
AND (absencePlansE0.INFORMATION_CATEGORY IS NOT NULL OR
absencePlansE0.INFORMATION1 IS NOT NULL OR 
absencePlansE0.INFORMATION2 IS NOT NULL OR 
absencePlansE0.INFORMATION3 IS NOT NULL OR 
absencePlansE0.INFORMATION4 IS NOT NULL OR 
absencePlansE0.INFORMATION5 IS NOT NULL OR 
absencePlansE0.INFORMATION6 IS NOT NULL OR 
absencePlansE0.INFORMATION7 IS NOT NULL OR 
absencePlansE0.INFORMATION8 IS NOT NULL OR 
absencePlansE0.INFORMATION9 IS NOT NULL OR 
absencePlansE0.INFORMATION10 IS NOT NULL OR 
absencePlansE0.INFORMATION11 IS NOT NULL OR 
absencePlansE0.INFORMATION12 IS NOT NULL OR 
absencePlansE0.INFORMATION13 IS NOT NULL OR 
absencePlansE0.INFORMATION14 IS NOT NULL OR 
absencePlansE0.INFORMATION15 IS NOT NULL OR 
absencePlansE0.INFORMATION16 IS NOT NULL OR 
absencePlansE0.INFORMATION17 IS NOT NULL OR 
absencePlansE0.INFORMATION18 IS NOT NULL OR 
absencePlansE0.INFORMATION19 IS NOT NULL OR 
absencePlansE0.INFORMATION20 IS NOT NULL OR 
absencePlansE0.INFORMATION21 IS NOT NULL OR 
absencePlansE0.INFORMATION22 IS NOT NULL OR 
absencePlansE0.INFORMATION23 IS NOT NULL OR 
absencePlansE0.INFORMATION24 IS NOT NULL OR 
absencePlansE0.INFORMATION25 IS NOT NULL OR 
absencePlansE0.INFORMATION26 IS NOT NULL OR 
absencePlansE0.INFORMATION27 IS NOT NULL OR 
absencePlansE0.INFORMATION28 IS NOT NULL OR 
absencePlansE0.INFORMATION29 IS NOT NULL OR 
absencePlansE0.INFORMATION30 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER1 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER2 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER3 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER4 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER5 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER6 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER7 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER8 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER9 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER10 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER11 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER12 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER13 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER14 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER15 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER16 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER17 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER18 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER19 IS NOT NULL OR 
absencePlansE0.INFORMATION_NUMBER20 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE1 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE2 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE3 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE4 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE5 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE6 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE7 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE8 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE10 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE11 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE12 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE13 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE14 IS NOT NULL OR 
absencePlansE0.INFORMATION_DATE15 IS NOT NULL )
ORDER BY absencePlansTLE0.NAME
,absencePlansE0.EFFECTIVE_START_DATE