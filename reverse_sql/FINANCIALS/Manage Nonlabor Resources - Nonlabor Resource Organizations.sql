/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Nonlabor%20Resources%20-%20Nonlabor%20Resource%20Organizations.sql $:
 * $Id: Manage Nonlabor Resources - Nonlabor Resource Organizations.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT pjfNONLaborEO.NLR_NAME RES_NONLABOR_RESOURCE
 ,hrORGE0.NAME RES_NAME
 ,TO_CHAR(pjfNONLaborORGEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
 ,TO_CHAR(pjfNONLaborORGEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
 ,pjfNONLaborORGEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,pjfNONLaborORGEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,pjfNONLaborORGEO.CREATED_BY RSC_CREATED_BY
 ,pjfNONLaborORGEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_NON_LABOR_RES_VL pjfNONLaborEO
,PJF_NON_LABOR_RES_ORGS pjfNONLaborORGEO
,(SELECT ORGANIZATION_ID
	,NAME
	FROM HR_ORGANIZATION_UNITS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) hrORGE0
WHERE pjfNONLaborEO.NON_LABOR_RESOURCE_ID = pjfNONLaborORGEO.NON_LABOR_RESOURCE_ID
AND pjfNONLaborORGEO.ORGANIZATION_ID = hrORGE0.ORGANIZATION_ID
ORDER BY pjfNONLaborEO.NLR_NAME
,hrORGE0.NAME