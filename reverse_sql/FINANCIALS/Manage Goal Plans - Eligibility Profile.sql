 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT goldPlansE0.GOAL_PLAN_NAME RES_GOAL_PLAN
,(SELECT NAME
	FROM BEN_ELIGY_PRFL
	WHERE SYSDATE BETWEEN START_DATE AND END_DATE
	AND ELIGY_PRFL_ID = eligyPrflsE0.ELIGY_PRFL_ID 
	) RES_ELIGIBILITY_PROFILE
,DECODE(eligyPrflsE0.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED
,eligyPrflsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,eligyPrflsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,eligyPrflsE0.CREATED_BY  RSC_CREATED_BY
,eligyPrflsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,goldPlansE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRG_GOAL_PLANS_VL goldPlansE0
,(SELECT *
	FROM HRT_ELGBLTY_PROFILE_OBJECTS 
	WHERE OBJECT_TYPE = 'GOAL'
	) eligyPrflsE0
WHERE goldPlansE0.MASS_REQUEST_ID = eligyPrflsE0.OBJECT_ID
AND goldPlansE0.GOAL_PLAN_TYPE_CODE = 'ORA_HRG_WORKER'
ORDER BY goldPlansE0.GOAL_PLAN_NAME