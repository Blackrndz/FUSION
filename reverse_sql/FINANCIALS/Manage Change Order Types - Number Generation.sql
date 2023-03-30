/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
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
,'' RES_ASSOCIATED_RULE_SET_NAME
,numbersE0.PREFIX RES_PREFIX
,numbersE0.STARTING_NUMBER RES_STARTING_NUMBER
,numbersE0.INCREMENT_BY RES_INCREMENT
,numbersE0.SUFFIX RES_SUFFIX
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
	WHERE OBJECT_NAME = 'EGO_CHANGE'
	) numbersE0
WHERE changeOrderTypesE0.COPIED_FROM IS NOT NULL
AND changeOrderTypesE0.CHANGE_TYPE_ID = numbersE0.OBJECT_ID1(+)
ORDER BY changeOrderTypesE0.TYPE_NAME