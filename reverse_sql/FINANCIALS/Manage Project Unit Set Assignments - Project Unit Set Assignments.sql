/* ****************************************************************************
 * $Revision: 54511 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-04-20 14:27:12 +0700 (Wed, 20 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Manage%20Trading%20Community%20Person%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Trading Community Person Lookups - Lookup Codes.sql 54511 2016-04-20 07:27:12Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT ORG_INFORMATION1
	FROM HR_ORGANIZATION_INFORMATION_F
	WHERE ORG_INFORMATION_CONTEXT = 'PRJ_PU_ATTRIBUTES'
	AND ORGANIZATION_ID = puImpleE0.PU_ID
	) RES_CODE
,org.NAME RES_NAME
,setRefGroupsE0.VISIBLE_GROUP_NAME RES_REFERENCE_DATA_OBJECT
,setsE0.SET_CODE RES_REFERENCE_DATA_SET_CODE
,setsE0.SET_NAME RES_REFERENCE_DATA_SET_NAME
,setAssingmentsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,setAssingmentsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,setAssingmentsE0.CREATED_BY  RSC_CREATED_BY
,setAssingmentsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,puImpleE0.PU_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ALL_ORGANIZATION_UNITS org
,PJF_PU_IMPL puImpleE0
,FND_SETID_SETS setsE0
,FND_SETID_ASSIGNMENTS setAssingmentsE0
,FND_SETID_REFERENCE_GROUPS_VL setRefGroupsE0
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
AND puImpleE0.PU_ID = setAssingmentsE0.DETERMINANT_VALUE
AND setsE0.SET_ID = setAssingmentsE0.SET_ID
AND setsE0.LANGUAGE = USERENV('LANG')
AND setAssingmentsE0.DETERMINANT_TYPE = setRefGroupsE0.DETERMINANT_TYPE
AND setAssingmentsE0.REFERENCE_GROUP_NAME = setRefGroupsE0.REFERENCE_GROUP_NAME
AND setAssingmentsE0.DETERMINANT_TYPE = 'PU'
ORDER BY 1,3