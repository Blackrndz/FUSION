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
-- DFF_LOGIC_TO_APPLY=401##RES##INV_INTERSUB_PARAMETERS
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE,ATTRIBUTE_TIMESTAMP
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
SElECT OrganizationParameterEO.ORGANIZATION_CODE RES_ORGANIZATION
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_INV_TO_DESTINATION_TYPE'
	AND LOOKUP_CODE = InvIntersubParametersE0.DESTINATION_TYPE
	) RES_DESTINATION_TYPE
,InvIntersubParametersE0.FROM_SUBINVENTORY RES_DESTINATION_SUBINVENTORY
,NVL(InvIntersubParametersE0.TO_SUBINVENTORY,'All') RES_SOURCE_SUBINVENTORY
,InvIntersubParametersE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,InvIntersubParametersE0.ATTRIBUTE_CHAR1
,InvIntersubParametersE0.ATTRIBUTE_CHAR2
,InvIntersubParametersE0.ATTRIBUTE_CHAR3
,InvIntersubParametersE0.ATTRIBUTE_CHAR4
,InvIntersubParametersE0.ATTRIBUTE_CHAR5
,InvIntersubParametersE0.ATTRIBUTE_CHAR6
,InvIntersubParametersE0.ATTRIBUTE_CHAR7
,InvIntersubParametersE0.ATTRIBUTE_CHAR8
,InvIntersubParametersE0.ATTRIBUTE_CHAR9
,InvIntersubParametersE0.ATTRIBUTE_CHAR10
,InvIntersubParametersE0.ATTRIBUTE_CHAR11
,InvIntersubParametersE0.ATTRIBUTE_CHAR12
,InvIntersubParametersE0.ATTRIBUTE_CHAR13
,InvIntersubParametersE0.ATTRIBUTE_CHAR14
,InvIntersubParametersE0.ATTRIBUTE_CHAR15
,InvIntersubParametersE0.ATTRIBUTE_CHAR16
,InvIntersubParametersE0.ATTRIBUTE_CHAR17
,InvIntersubParametersE0.ATTRIBUTE_CHAR18
,InvIntersubParametersE0.ATTRIBUTE_CHAR19
,InvIntersubParametersE0.ATTRIBUTE_CHAR20
,InvIntersubParametersE0.ATTRIBUTE_NUMBER1
,InvIntersubParametersE0.ATTRIBUTE_NUMBER2
,InvIntersubParametersE0.ATTRIBUTE_NUMBER3
,InvIntersubParametersE0.ATTRIBUTE_NUMBER4
,InvIntersubParametersE0.ATTRIBUTE_NUMBER5
,InvIntersubParametersE0.ATTRIBUTE_NUMBER6
,InvIntersubParametersE0.ATTRIBUTE_NUMBER7
,InvIntersubParametersE0.ATTRIBUTE_NUMBER8
,InvIntersubParametersE0.ATTRIBUTE_NUMBER9
,InvIntersubParametersE0.ATTRIBUTE_NUMBER10
,InvIntersubParametersE0.ATTRIBUTE_DATE1
,InvIntersubParametersE0.ATTRIBUTE_DATE2
,InvIntersubParametersE0.ATTRIBUTE_DATE3
,InvIntersubParametersE0.ATTRIBUTE_DATE4
,InvIntersubParametersE0.ATTRIBUTE_DATE5
,InvIntersubParametersE0.ATTRIBUTE_TIMESTAMP1
,InvIntersubParametersE0.ATTRIBUTE_TIMESTAMP2
,InvIntersubParametersE0.ATTRIBUTE_TIMESTAMP3
,InvIntersubParametersE0.ATTRIBUTE_TIMESTAMP4
,InvIntersubParametersE0.ATTRIBUTE_TIMESTAMP5
,InvIntersubParametersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,InvIntersubParametersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,InvIntersubParametersE0.CREATED_BY RSC_CREATED_BY
,InvIntersubParametersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,InvIntersubParametersE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_INTERSUB_PARAMETERS InvIntersubParametersE0
,INV_ORG_PARAMETERS OrganizationParameterEO
WHERE InvIntersubParametersE0.ORGANIZATION_ID = OrganizationParameterEO.ORGANIZATION_ID
ORDER BY OrganizationParameterEO.ORGANIZATION_CODE
,InvIntersubParametersE0.DESTINATION_TYPE
,InvIntersubParametersE0.FROM_SUBINVENTORY
,InvIntersubParametersE0.TO_SUBINVENTORY