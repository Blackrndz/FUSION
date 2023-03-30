/* ****************************************************************************
 * $Revision: 72749 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-10-23 15:22:46 +0700 (Wed, 23 Oct 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Availability%20Lookups%20-%20Lookup%20Types.sql $:
 * $Id: Manage Availability Lookups - Lookup Types.sql 72749 2019-10-23 08:22:46Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT cmpPLANEO.PLAN_NAME RES_PLAN
,DECODE(cmpCALALERTE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLE
,cmpCALALERTE0.ALERT_NAME RES_NAME
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_CODE = cmpCALALERTE0.ALERT_TYPE 
	AND LOOKUP_TYPE = 'CMP_ALERT_TYPE' 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	) RES_TYPE
,cmpCALALERTE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpCALALERTE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpCALALERTE0.CREATED_BY RSC_CREATED_BY
,cmpCALALERTE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM CMP_PLANS_VL cmpPLANEO
,CMP_CALC_ALERTS_VL cmpCALALERTE0
WHERE cmpPLANEO.PLAN_ID = cmpCALALERTE0.ALERT_KEY
AND cmpCALALERTE0.QUICK_ALERT_FLAG = 'Y'
AND cmpPLANEO.COMP_TYPE = 'CWB'
ORDER BY PLAN_NAME