/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Instance%20Qualifiers%20-%20Instance%20Qualifier%20Set.sql $:
 * $Id: Manage Instance Qualifiers - Instance Qualifier Set.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT CONTENT_TYPE_NAME
	FROM HRT_CONTENT_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CONTENT_TYPE_ID = setsE0.CONTENT_TYPE_ID 
	) RES_CONTENT_TYPE
,setsE0.QUALIFIER_SET_CODE RES_INSTANCE_QUALIFIER_SET
,setsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRT_INST_QUAL_TYPE'
    AND LOOKUP_CODE = setsE0.QUALIFIER_TYPE_CODE 
	 ) RES_SOURCE_OF_INSTANCE_QUALIFI
,setsE0.KEY_TABLE_NAME RES_LOOK_UP_RECORD
,setsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,setsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,setsE0.CREATED_BY RSC_CREATED_BY
,setsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,setsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_QUALIFIER_SETS_VL setsE0
ORDER BY 1,2