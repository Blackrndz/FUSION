/* ****************************************************************************
 * $Revision: 53999 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-28 18:07:14 +0700 (Mon, 28 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Scheduling%20Rules%20-%20Schedule%20-%20DFF.sql $:
 * $Id: Manage Revenue Scheduling Rules - Schedule - DFF.sql 53999 2016-03-28 11:07:14Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=INV_INTERSUB_PARAMETERS 

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=401##RES##INV_CYCLE_COUNT_HEADERS
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
SELECT (SELECT ORGANIZATION_CODE 
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = CycleCountHE0.ORGANIZATION_ID
	) RES_ORGANIZATION
,CycleCountHE0.CYCLE_COUNT_HEADER_NAME RES_COUNT_NAME
,CycleCountHE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,CycleCountHE0.ATTRIBUTE1
,CycleCountHE0.ATTRIBUTE2
,CycleCountHE0.ATTRIBUTE3
,CycleCountHE0.ATTRIBUTE4
,CycleCountHE0.ATTRIBUTE5
,CycleCountHE0.ATTRIBUTE6
,CycleCountHE0.ATTRIBUTE7
,CycleCountHE0.ATTRIBUTE8
,CycleCountHE0.ATTRIBUTE9
,CycleCountHE0.ATTRIBUTE10
,CycleCountHE0.ATTRIBUTE11
,CycleCountHE0.ATTRIBUTE12
,CycleCountHE0.ATTRIBUTE13
,CycleCountHE0.ATTRIBUTE14
,CycleCountHE0.ATTRIBUTE15
,CycleCountHE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CycleCountHE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CycleCountHE0.CREATED_BY  RSC_CREATED_BY
,CycleCountHE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,CycleCountHE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM INV_CYCLE_COUNT_HEADERS CycleCountHE0
WHERE (CycleCountHE0.ATTRIBUTE1 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE2 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE3 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE4 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE5 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE6 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE7 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE8 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE9 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE10 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE11 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE12 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE13 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE14 IS NOT NULL
	OR CycleCountHE0.ATTRIBUTE15 IS NOT NULL)
ORDER BY 1,2