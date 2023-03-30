/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Nonlabor%20Resources%20-%20Nonlabor%20Resources.sql $:
 * $Id: Manage Nonlabor Resources - Nonlabor Resources.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT pjfNONLaborEO.NLR_NAME RES_NONLABOR_RESOURCE
 ,pjfNONLaborEO.DESCRIPTION RES_DESCRIPTION
 ,(SELECT EXPENDITURE_TYPE_NAME FROM PJF_EXP_TYPES_VL
	WHERE EXPENDITURE_TYPE_ID = pjfNONLaborEO.EXPENDITURE_TYPE_ID) RES_EXPENDITURE_TYPE
 ,DECODE(pjfNONLaborEO.EQUIPMENT_RESOURCE_FLAG,'Y','Yes','No') RES_EQUIPMENT_RESOURCE_CLASS
 ,TO_CHAR(pjfNONLaborEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
 ,TO_CHAR(pjfNONLaborEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
 ,pjfNONLaborEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,pjfNONLaborEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,pjfNONLaborEO.CREATED_BY RSC_CREATED_BY
 ,pjfNONLaborEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_NON_LABOR_RES_VL pjfNONLaborEO
ORDER BY pjfNONLaborEO.NLR_NAME
