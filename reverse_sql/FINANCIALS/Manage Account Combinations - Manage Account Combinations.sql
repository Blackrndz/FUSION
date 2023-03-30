/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Account%20Combinations%20-%20Manage%20Account%20Combinations.sql $:
 * $Id: Manage Account Combinations - Manage Account Combinations.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_ALTERNATE_ACCOUNT/GET_CODE_COMBINATION

SELECT
	(SELECT name
	FROM FND_KF_STR_INSTANCES_VL
	WHERE STRUCTURE_INSTANCE_NUMBER = CodeCombinationEO.CHART_OF_ACCOUNTS_ID
	) AS RES_CHART_OF_ACCOUNTS
,(SELECT MEANING
	FROM GL_Lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = CodeCombinationEO.ENABLED_FLAG
	)                           AS RES_ENABLED
,CodeCombinationEO.SEGMENT1  AS RES_ACCOUNT_NAME1
,CodeCombinationEO.SEGMENT2  AS RES_ACCOUNT_NAME2
,CodeCombinationEO.SEGMENT3  AS RES_ACCOUNT_NAME3
,CodeCombinationEO.SEGMENT4  AS RES_ACCOUNT_NAME4
,CodeCombinationEO.SEGMENT5  AS RES_ACCOUNT_NAME5
,CodeCombinationEO.SEGMENT6  AS RES_ACCOUNT_NAME6
,CodeCombinationEO.SEGMENT7  AS RES_ACCOUNT_NAME7
,CodeCombinationEO.SEGMENT8  AS RES_ACCOUNT_NAME8
,CodeCombinationEO.SEGMENT9  AS RES_ACCOUNT_NAME9
,CodeCombinationEO.SEGMENT10 AS RES_ACCOUNT_NAME10
,(SELECT meaning
	FROM GL_LOOKUPS
	WHERE LOOKUP_TYPE = 'ACCOUNT TYPE'
	AND LOOKUP_CODE   = CodeCombinationEO.ACCOUNT_TYPE
	)                                                          AS RES_ACCOUNT_TYPE
,TO_CHAR(CodeCombinationEO.START_DATE_ACTIVE,'DD-Mon-YYYY') AS RES_FROM_DATE
,TO_CHAR(CodeCombinationEO.END_DATE_ACTIVE,'DD-Mon-YYYY')   AS RES_TO_DATE
,(SELECT MEANING
	FROM GL_Lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = CodeCombinationEO.PRESERVE_FLAG
	) AS RES_PRESERVE_ATTRIBUTES
,(SELECT MEANING
	FROM GL_Lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = CodeCombinationEO.DETAIL_POSTING_ALLOWED_FLAG
	)                                               AS RES_ALLOW_POSTING
,CodeCombinationEO.ALTERNATE_CODE_COMBINATION_ID AS RES_ALTERNATE_ACCOUNT
,CodeCombinationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CodeCombinationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CodeCombinationEO.CREATED_BY RSC_CREATED_BY
,CodeCombinationEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,CodeCombinationEO.CHART_OF_ACCOUNTS_ID RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_CODE_COMBINATIONS CodeCombinationEO
ORDER BY RES_CHART_OF_ACCOUNTS