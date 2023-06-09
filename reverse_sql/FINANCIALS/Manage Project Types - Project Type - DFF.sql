 /* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10037##RES##PJF_PROJECT_TYPES_DESC_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT pjfPROTypeE0.PROJECT_TYPE RES_NAME
 ,fndSETidE0.SET_NAME RES_SET
 ,pjfPROTypeE0.DESCRIPTION RES_DESCRIPTION
 ,TO_CHAR(pjfPROTypeE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
 ,TO_CHAR(pjfPROTypeE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
 ,pjfWORKTypeE0.NAME	RES_WORK_TYPE
,pjfPROTypeE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,pjfPROTypeE0.ATTRIBUTE1
,pjfPROTypeE0.ATTRIBUTE2
,pjfPROTypeE0.ATTRIBUTE3
,pjfPROTypeE0.ATTRIBUTE4
,pjfPROTypeE0.ATTRIBUTE5
,pjfPROTypeE0.ATTRIBUTE6
,pjfPROTypeE0.ATTRIBUTE7
,pjfPROTypeE0.ATTRIBUTE8
,pjfPROTypeE0.ATTRIBUTE9
,pjfPROTypeE0.ATTRIBUTE10
,pjfPROTypeE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfPROTypeE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfPROTypeE0.CREATED_BY  RSC_CREATED_BY
,pjfPROTypeE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECT_TYPES_VL pjfPROTypeE0
,FND_SETID_SETS fndSETidE0
,PJF_WORK_TYPES_VL pjfWORKTypeE0
WHERE pjfPROTypeE0.SET_ID = fndSETidE0.SET_ID
AND pjfPROTypeE0.LANGUAGE = fndSETidE0.LANGUAGE
AND pjfPROTypeE0.WORK_TYPE_ID = pjfWORKTypeE0.WORK_TYPE_ID (+)
AND(pjfPROTypeE0.ATTRIBUTE_CATEGORY IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE1 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE2 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE3 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE4 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE5 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE6 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE7 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE8 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE9 IS NOT NULL
OR pjfPROTypeE0.ATTRIBUTE10 IS NOT NULL)
ORDER BY pjfPROTypeE0.PROJECT_TYPE