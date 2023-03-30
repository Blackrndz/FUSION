/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20New%20Item%20Request%20Type%20Details%20-%20Number%20Generation.sql $:
 * $Id: Manage New Item Request Type Details - Number Generation.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGO_CHANGE_TYPES_VL
 
SELECT changeOrderTypesE0.TYPE_NAME RES_NAME
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'EGO_CHANGE_AUTO_NUM_GEN_TYPES'
	AND LOOKUP_CODE = changeOrderTypesE0.AUTO_NUMBERING_METHOD
	) RES_NUMBER_GENERATION_METHOD
,numbersE0.PREFIX RES_PREFIX
,numbersE0.STARTING_NUMBER RES_STARTING_NUMBER
,numbersE0.INCREMENT_BY RES_INCREMENT
,numbersE0.SUFFIX RES_SUFFIX
,'' RES_ASSOCIATED_RULE_SET_NAME
,changeOrderTypesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,changeOrderTypesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,changeOrderTypesE0.CREATED_BY  RSC_CREATED_BY
,changeOrderTypesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM EGO_CHANGE_TYPES_VL changeOrderTypesE0
,(SELECT * 
	FROM EGO_ENTITY_AUTO_GEN_METADATA
	WHERE OBJECT_NAME = 'EGO_NIR'
	) numbersE0
WHERE changeOrderTypesE0.CHANGE_TYPE_ID = numbersE0.OBJECT_ID1(+)
AND changeOrderTypesE0.TYPE_INTERNAL_NAME = 'NewItemRequest'
ORDER BY changeOrderTypesE0.TYPE_NAME