/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Financial%20Plan%20Types%20-%20Set%20Assignments.sql $:
* $Id: Manage Financial Plan Types - Set Assignments.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjoPlanTypeEO.NAME							RES_NAME
,(SELECT SET_CODE FROM FND_SETID_SETS
		WHERE SET_ID = pjoPlanTypeBSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))			RES_ASSIGNMENTS_CODE
,(SELECT SET_NAME FROM FND_SETID_SETS
		WHERE SET_ID = pjoPlanTypeBSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))			RES_ASSIGNMENTS_NAME
,(SELECT DESCRIPTION FROM FND_SETID_SETS
		WHERE SET_ID = pjoPlanTypeBSTEO.SET_ID
			AND LANGUAGE = USERENV('LANG'))			RES_DESCRIPTION	
,pjoPlanTypeBSTEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjoPlanTypeBSTEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjoPlanTypeBSTEO.CREATED_BY  RSC_CREATED_BY
,pjoPlanTypeBSTEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJO_PLAN_TYPES_VL pjoPlanTypeEO
,PJO_PLAN_TYPES_B_ST pjoPlanTypeBSTEO
WHERE pjoPlanTypeEO.PLAN_TYPE_ID = pjoPlanTypeBSTEO.PLAN_TYPE_ID
ORDER BY pjoPlanTypeEO.NAME


