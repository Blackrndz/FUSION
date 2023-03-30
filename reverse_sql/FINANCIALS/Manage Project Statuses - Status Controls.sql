/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Statuses%20-%20Status%20Controls.sql $:
 * $Id: Manage Project Statuses - Status Controls.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT pjfPROJECTstatEO.PROJECT_STATUS_NAME RES_PROJECT_STATUS
 ,(SELECT MEANING FROM FND_LOOKUPS
			WHERE LOOKUP_CODE = pjfPROJcontrolsEO.STATUS_TYPE
			AND LOOKUP_TYPE = 'PJF_STATUS_TYPE')RES_STATUS_TYPE
 ,(SELECT MEANING FROM FND_LOOKUPS
			WHERE LOOKUP_CODE = pjfPROJcontrolsEO.ACTION_CODE
			AND LOOKUP_TYPE = 'PJF_PROJECT_STATUS_ACTIONS') RES_ACTION
 ,DECODE(pjfPROJcontrolsEO.ALLOW_OVERRIDES_FLAG,'Y','Yes','No') RES_ALLOW
 ,pjfPROJcontrolsEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,pjfPROJcontrolsEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,pjfPROJcontrolsEO.CREATED_BY RSC_CREATED_BY
 ,pjfPROJcontrolsEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,NULL RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECT_STATUSES_VL pjfPROJECTstatEO 
,PJF_PROJ_STATUS_CONTROLS  pjfPROJcontrolsEO
WHERE pjfPROJECTstatEO.PROJECT_STATUS_CODE = pjfPROJcontrolsEO.PROJECT_STATUS_CODE



 