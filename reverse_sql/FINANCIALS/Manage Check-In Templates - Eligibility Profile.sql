/* ****************************************************************************
 * $Revision: 53935 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-03-25 16:18:48 +0700 (Fri, 25 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Statement%20Transaction%20Creation%20Rules%20-%20Manage%20Bank%20Statement%20Transaction%20Creation%20Rules.sql $:
 * $Id: Manage Bank Statement Transaction Creation Rules - Manage Bank Statement Transaction Creation Rules.sql 53935 2016-03-25 09:18:48Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=HRA_CHECK_IN_TMPLS_VL

SELECT hraCHECKINTMPE0.NAME RES_NAME
,(SELECT NAME FROM BEN_ELIGY_PRFL WHERE ELIGY_PRFL_ID = hrtELIGPROFILE0.ELIGY_PRFL_ID
	AND SYSDATE BETWEEN START_DATE AND NVL(END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_ELIGIBILITY_PROFILE
,DECODE(hrtELIGPROFILE0.REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRED

,hrtELIGPROFILE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hrtELIGPROFILE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hrtELIGPROFILE0.CREATED_BY RSC_CREATED_BY
,hrtELIGPROFILE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRA_CHECK_IN_TMPLS_VL hraCHECKINTMPE0
,HRT_ELGBLTY_PROFILE_OBJECTS hrtELIGPROFILE0
WHERE hraCHECKINTMPE0.CHECK_IN_TEMPLATE_ID = hrtELIGPROFILE0.OBJECT_ID
AND hrtELIGPROFILE0.OBJECT_TYPE = 'CHECKIN'
ORDER BY RES_NAME
