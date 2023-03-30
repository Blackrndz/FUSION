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
    AND ORGANIZATION_ID = org.ORGANIZATION_ID
	) RES_CODE
,org.NAME RES_NAME
,puImpleE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,puImpleE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,puImpleE0.CREATED_BY RSC_CREATED_BY
,puImpleE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,org.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HR_ALL_ORGANIZATION_UNITS org
,PJF_PU_IMPL puImpleE0
WHERE org.ORGANIZATION_ID = puImpleE0.PU_ID
ORDER BY 1