/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Leave%20Agreements%20-%20Entitlements.sql $:
 * $Id: Manage Leave Agreements - Entitlements.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=ANC_ABSENCE_AGREEMENTS_VL
-- RSC_PREREQUISITE_OBJECTS=ANC_ABS_AGREEMENT_PLANS_F

SELECT ancABSENAGREEMEO.NAME RES_NAME
,(SELECT NAME
	FROM ANC_ABSENCE_PLANS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	AND ABSENCE_PLAN_ID = ancABSAGREEPLANE0.SOURCE_PLAN_ID 
	) RES_SOURCE_PLAN
,(SELECT NAME
	FROM ANC_ABSENCE_PLANS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	AND ABSENCE_PLAN_ID = ancABSAGREEPLANE0.TARGET_PLAN_ID 
	) RES_TARGET_PLAN
,TO_CHAR(ancABSAGREEPLANE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(TO_CHAR(ancABSAGREEPLANE0.EFFECTIVE_END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(ancABSAGREEPLANE0.EFFECTIVE_END_DATE,'DD-MM-YYYY')) RES_EFFECTIVE_END_DATE
,(SELECT FORMULA_NAME 
	FROM FF_FORMULAS_F 
	WHERE FORMULA_ID = ancABSAGREEPLANE0.PAY_PCT_DISP_FORMULA 
	) RES_PAYMENT_PERCENTAGE
,DECODE(ancABSAGREEPLANE0.OVERIDE_FLAG,'Y','Yes','No') RES_OVERRIDE_ALLOWED
,ancABSAGREEPLANE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ancABSAGREEPLANE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ancABSAGREEPLANE0.CREATED_BY RSC_CREATED_BY
,ancABSAGREEPLANE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,ancABSENAGREEMEO.LEGISLATION_CODE RSC_COUNTRY_ID

FROM ANC_ABSENCE_AGREEMENTS_VL ancABSENAGREEMEO
,ANC_ABS_AGREEMENT_PLANS_F ancABSAGREEPLANE0
WHERE ancABSENAGREEMEO.ABSENCE_AGREEMENT_ID = ancABSAGREEPLANE0.ABSENCE_AGREEMENT_ID
AND SYSDATE BETWEEN ancABSENAGREEMEO.EFFECTIVE_START_DATE AND NVL(ancABSENAGREEMEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND SYSDATE BETWEEN ancABSAGREEPLANE0.EFFECTIVE_START_DATE AND NVL(ancABSAGREEPLANE0.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND ancABSENAGREEMEO.LANGUAGE = USERENV('LANG')
ORDER BY ancABSENAGREEMEO.NAME