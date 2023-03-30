/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT CONTENT_TYPE_NAME
	FROM HRT_CONTENT_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND CONTENT_TYPE_ID = setsE0.CONTENT_TYPE_ID 
	) RES_CONTENT_TYPE
,setsE0.QUALIFIER_SET_CODE RES_INSTANCE_QUALIFIER_SET
,qualifiersE0.QUALIFIER_SEQ_NUMBER RES_PRIORITY
,qualifiersE0.QUALIFIER_CODE RES_CODE
,qualifiersE0.DESCRIPTION RES_DESCRIPTION
,DECODE(qualifiersE0.EMP_VIEW_FLAG,'Y','Yes','No') RES_EMPLOYEE_VIEW
,DECODE(qualifiersE0.MGR_VIEW_FLAG,'Y','Yes','No') RES_MANAGER_VIEW
,DECODE(qualifiersE0.SEARCH_FLAG,'Y','Yes','No') RES_SEARCHABLE
,DECODE(qualifiersE0.EMP_DEF_FLAG,'Y','Yes','No') RES_EMPLOYEE_DEFAULT
,DECODE(qualifiersE0.MGR_DEF_FLAG,'Y','Yes','No') RES_MANAGER_DEFAULT
,qualifiersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,qualifiersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,qualifiersE0.CREATED_BY RSC_CREATED_BY
,qualifiersE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,setsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_QUALIFIER_SETS_VL setsE0
,HRT_QUALIFIERS_VL qualifiersE0
WHERE setsE0.QUALIFIER_SET_ID = qualifiersE0.QUALIFIER_SET_ID
ORDER BY 1,2,3