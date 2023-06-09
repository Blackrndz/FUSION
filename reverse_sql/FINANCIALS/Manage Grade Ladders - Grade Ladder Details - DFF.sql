/* ****************************************************************************
 * $Revision: 73540 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2020-02-17 14:08:16 +0700 (Mon, 17 Feb 2020) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Remittance%20Bank%20Account%20-%20DFF.sql $:
 * $Id: Manage Receipt Classes and Methods - Remittance Bank Account - DFF.sql 73540 2020-02-17 07:08:16Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=800##RES##PER_GRADE_LADDERS_DF
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT TO_CHAR(laddersE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,laddersE0.NAME RES_NAME
,laddersE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,laddersE0.ATTRIBUTE1
,laddersE0.ATTRIBUTE2
,laddersE0.ATTRIBUTE3
,laddersE0.ATTRIBUTE4
,laddersE0.ATTRIBUTE5
,laddersE0.ATTRIBUTE6
,laddersE0.ATTRIBUTE7
,laddersE0.ATTRIBUTE8
,laddersE0.ATTRIBUTE9
,laddersE0.ATTRIBUTE10
,laddersE0.ATTRIBUTE11
,laddersE0.ATTRIBUTE12
,laddersE0.ATTRIBUTE13
,laddersE0.ATTRIBUTE14
,laddersE0.ATTRIBUTE15
,laddersE0.ATTRIBUTE16
,laddersE0.ATTRIBUTE17
,laddersE0.ATTRIBUTE18
,laddersE0.ATTRIBUTE19
,laddersE0.ATTRIBUTE20
,laddersE0.ATTRIBUTE21
,laddersE0.ATTRIBUTE22
,laddersE0.ATTRIBUTE23
,laddersE0.ATTRIBUTE24
,laddersE0.ATTRIBUTE25
,laddersE0.ATTRIBUTE26
,laddersE0.ATTRIBUTE27
,laddersE0.ATTRIBUTE28
,laddersE0.ATTRIBUTE29
,laddersE0.ATTRIBUTE30
,laddersE0.ATTRIBUTE_NUMBER1
,laddersE0.ATTRIBUTE_NUMBER2
,laddersE0.ATTRIBUTE_NUMBER3
,laddersE0.ATTRIBUTE_NUMBER4
,laddersE0.ATTRIBUTE_NUMBER5
,laddersE0.ATTRIBUTE_NUMBER6
,laddersE0.ATTRIBUTE_NUMBER7
,laddersE0.ATTRIBUTE_NUMBER8
,laddersE0.ATTRIBUTE_NUMBER9
,laddersE0.ATTRIBUTE_NUMBER10
,laddersE0.ATTRIBUTE_NUMBER11
,laddersE0.ATTRIBUTE_NUMBER12
,laddersE0.ATTRIBUTE_NUMBER13
,laddersE0.ATTRIBUTE_NUMBER14
,laddersE0.ATTRIBUTE_NUMBER15
,laddersE0.ATTRIBUTE_NUMBER16
,laddersE0.ATTRIBUTE_NUMBER17
,laddersE0.ATTRIBUTE_NUMBER18
,laddersE0.ATTRIBUTE_NUMBER19
,laddersE0.ATTRIBUTE_NUMBER20
,TO_CHAR(laddersE0.ATTRIBUTE_DATE1,'DD-Mon-YYYY') ATTRIBUTE_DATE1
,TO_CHAR(laddersE0.ATTRIBUTE_DATE2,'DD-Mon-YYYY') ATTRIBUTE_DATE2
,TO_CHAR(laddersE0.ATTRIBUTE_DATE3,'DD-Mon-YYYY') ATTRIBUTE_DATE3
,TO_CHAR(laddersE0.ATTRIBUTE_DATE4,'DD-Mon-YYYY') ATTRIBUTE_DATE4
,TO_CHAR(laddersE0.ATTRIBUTE_DATE5,'DD-Mon-YYYY') ATTRIBUTE_DATE5
,TO_CHAR(laddersE0.ATTRIBUTE_DATE6,'DD-Mon-YYYY') ATTRIBUTE_DATE6
,TO_CHAR(laddersE0.ATTRIBUTE_DATE7,'DD-Mon-YYYY') ATTRIBUTE_DATE7
,TO_CHAR(laddersE0.ATTRIBUTE_DATE8,'DD-Mon-YYYY') ATTRIBUTE_DATE8
,TO_CHAR(laddersE0.ATTRIBUTE_DATE9,'DD-Mon-YYYY') ATTRIBUTE_DATE9
,TO_CHAR(laddersE0.ATTRIBUTE_DATE10,'DD-Mon-YYYY') ATTRIBUTE_DATE10
,TO_CHAR(laddersE0.ATTRIBUTE_DATE11,'DD-Mon-YYYY') ATTRIBUTE_DATE11
,TO_CHAR(laddersE0.ATTRIBUTE_DATE12,'DD-Mon-YYYY') ATTRIBUTE_DATE12
,TO_CHAR(laddersE0.ATTRIBUTE_DATE13,'DD-Mon-YYYY') ATTRIBUTE_DATE13
,TO_CHAR(laddersE0.ATTRIBUTE_DATE14,'DD-Mon-YYYY') ATTRIBUTE_DATE14
,TO_CHAR(laddersE0.ATTRIBUTE_DATE15,'DD-Mon-YYYY') ATTRIBUTE_DATE15
,laddersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,laddersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,laddersE0.CREATED_BY RSC_CREATED_BY
,laddersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_GRADE_LADDERS_F_VL laddersE0
WHERE (laddersE0.ATTRIBUTE_CATEGORY IS NOT NULL
	OR laddersE0.ATTRIBUTE1 IS NOT NULL
	OR laddersE0.ATTRIBUTE2 IS NOT NULL
	OR laddersE0.ATTRIBUTE3 IS NOT NULL
	OR laddersE0.ATTRIBUTE4 IS NOT NULL
	OR laddersE0.ATTRIBUTE5 IS NOT NULL
	OR laddersE0.ATTRIBUTE6 IS NOT NULL
	OR laddersE0.ATTRIBUTE7 IS NOT NULL
	OR laddersE0.ATTRIBUTE8 IS NOT NULL
	OR laddersE0.ATTRIBUTE9 IS NOT NULL
	OR laddersE0.ATTRIBUTE10 IS NOT NULL
	OR laddersE0.ATTRIBUTE11 IS NOT NULL
	OR laddersE0.ATTRIBUTE12 IS NOT NULL
	OR laddersE0.ATTRIBUTE13 IS NOT NULL
	OR laddersE0.ATTRIBUTE14 IS NOT NULL
	OR laddersE0.ATTRIBUTE15 IS NOT NULL
	OR laddersE0.ATTRIBUTE16 IS NOT NULL
	OR laddersE0.ATTRIBUTE17 IS NOT NULL
	OR laddersE0.ATTRIBUTE18 IS NOT NULL
	OR laddersE0.ATTRIBUTE19 IS NOT NULL
	OR laddersE0.ATTRIBUTE20 IS NOT NULL
	OR laddersE0.ATTRIBUTE21 IS NOT NULL
	OR laddersE0.ATTRIBUTE22 IS NOT NULL
	OR laddersE0.ATTRIBUTE23 IS NOT NULL
	OR laddersE0.ATTRIBUTE24 IS NOT NULL
	OR laddersE0.ATTRIBUTE25 IS NOT NULL
	OR laddersE0.ATTRIBUTE26 IS NOT NULL
	OR laddersE0.ATTRIBUTE27 IS NOT NULL
	OR laddersE0.ATTRIBUTE28 IS NOT NULL
	OR laddersE0.ATTRIBUTE29 IS NOT NULL
	OR laddersE0.ATTRIBUTE30 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER1 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER2 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER3 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER4 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER5 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER6 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER7 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER8 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER9 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER10 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER11 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER12 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER13 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER14 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER15 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER16 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER17 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER18 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER19 IS NOT NULL
	OR laddersE0.ATTRIBUTE_NUMBER20 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE1 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE2 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE3 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE4 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE5 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE6 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE7 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE8 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE9 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE10 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE11 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE12 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE13 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE14 IS NOT NULL
	OR laddersE0.ATTRIBUTE_DATE15 IS NOT NULL)
ORDER BY laddersE0.NAME
,laddersE0.EFFECTIVE_START_DATE